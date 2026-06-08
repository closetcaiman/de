% websave("nbp.csv", "https://static.nbp.pl/dane/kursy/Archiwum/archiwum_tab_a_2025.csv")

clear; close all; clc;

% Zadanie 1

% 1. wczytanie danych
file = 'nbp.csv';
N_deg = 2;
k_win = 5;
PP = 1.15;
PZ = 0.01;

opts = delimitedTextImportOptions('NumVariables', 36);
opts.Delimiter = ';';
opts.DataLines = [3 Inf];
opts.ExtraColumnsRule = 'ignore';
opts.EmptyLineRule = 'skip';
opts.VariableTypes = repmat({'string'}, 1, 36);
raw = readtable(file, opts);

is_date = ~cellfun('isempty', regexp(raw.Var1, '^\d{8}$', 'once'));
raw = raw(is_date, :);

dates_all = datetime(raw.Var1, 'InputFormat', 'yyyyMMdd');
parse = @(x) str2double(strrep(x, ',', '.'));

% cena na 1 JPY/CLP w PLN - w danych sa podawane jako 100*
JPY_raw = parse(raw.Var14) / 100;   
CLP_raw = parse(raw.Var24) / 100;

maskJ = ~isnan(JPY_raw);
maskC = ~isnan(CLP_raw);

dates_J = dates_all(maskJ);   JPY = JPY_raw(maskJ);
dates_C = dates_all(maskC);   CLP = CLP_raw(maskC);

% 2. daty obecne tylko w jednym z szeregow
only_J = setdiff(dates_J, dates_C);
only_C = setdiff(dates_C, dates_J);

fprintf('Z1.2  Daty tylko w JPY: %d\n', numel(only_J));
if ~isempty(only_J)
    disp(only_J(1:min(5,end)));
end
fprintf('Z1.2  Daty tylko w CLP: %d\n', numel(only_C));
if ~isempty(only_C)
    disp(only_C(1:min(5,end)));
end

% 3
% a) intersekcja dat
[dates_i, iJ, iC] = intersect(dates_J, dates_C);
JPYi = JPY(iJ);
CLPi = CLP(iC);

% b) interpolacja
dates_u = union(dates_J, dates_C);
tnum_u  = datenum(dates_u);
JPYu = interp1(datenum(dates_J), JPY, tnum_u, 'linear', 'extrap');
CLPu = interp1(datenum(dates_C), CLP, tnum_u, 'linear', 'extrap');

fprintf('Z1.3  intersekcja: %d punktow, unia (interpolacja): %d punktow\n', ...
    numel(dates_i), numel(dates_u));

% 4
% przyrosty
abs_inc = @(y) diff(y);
rel_inc = @(y) diff(y) ./ y(1:end-1);
log_inc = @(y) diff(log(y));

dJ = abs_inc(JPYi);  dC = abs_inc(CLPi);
rJ = rel_inc(JPYi);  rC = rel_inc(CLPi);
lJ = log_inc(JPYi);  lC = log_inc(CLPi);

T1 = table( ...
    [mean(dJ); std(dJ); mean(dC); std(dC)], ...
    [mean(rJ); std(rJ); mean(rC); std(rC)], ...
    [mean(lJ); std(lJ); mean(lC); std(lC)], ...
    'VariableNames', {'Bezwzgledny','Wzgledny','Logarytmiczny'}, ...
    'RowNames', {'JPY mean','JPY std','CLP mean','CLP std'});
fprintf('\nZ1.4  Statystyki przyrostow (po intersekcji):\n');
disp(T1);

figure('Name','Z1 - kursy po uspojnieniu');
plot(dates_i, JPYi, 'b-', 'DisplayName','JPY'); hold on;
plot(dates_i, CLPi, 'r-', 'DisplayName','CLP');
legend; grid on; title('JPY i CLP - intersekcja dat');

% Komentarz:
% - nie ma rozbieznosci w datach
% - przyrost bezwzgledny nie bierze pod uwage skali cen, a tutaj jest ona
% znaczna (widac na wykresie roznice). Logarytmiczny bierze je
% proporcjonalnie co widac na wynikach (printf ze statystykami). Wieksza
% zmiennosc ma zatem CLP bo std_log(CLP) = ~0.008 > std_log(JPY) = ~0.005.

% Zadanie 2

y = JPYi;
t = (1:numel(y))';
T_dates = dates_i;

% 1. trend liniowy globalny
p_lin = polyfit(t, y, 1);
y_lin = polyval(p_lin, t);
rmse_lin = sqrt(mean((y - y_lin).^2));
fprintf('\nZ2.1  Trend liniowy globalny: nachylenie = %.4e [PLN/dzien], RMSE = %.4e\n', ...
    p_lin(1), rmse_lin);

% 2. trendy w dwoch polowach
mid = floor(numel(t)/2);
t1 = t(1:mid);       y1 = y(1:mid);
t2 = t(mid+1:end);   y2 = y(mid+1:end);
p_h1 = polyfit(t1, y1, 1);
p_h2 = polyfit(t2, y2, 1);
rmse_h1 = sqrt(mean((y1 - polyval(p_h1, t1)).^2));
rmse_h2 = sqrt(mean((y2 - polyval(p_h2, t2)).^2));
fprintf('Z2.2  Polowa 1: nachylenie = %+.4e, RMSE = %.4e\n', p_h1(1), rmse_h1);
fprintf('Z2.2  Polowa 2: nachylenie = %+.4e, RMSE = %.4e\n', p_h2(1), rmse_h2);

% 3. wielomian
p_poly = polyfit(t, y, N_deg);
y_poly = polyval(p_poly, t);
resid_poly = y - y_poly;
rmse_poly = sqrt(mean(resid_poly.^2));
fprintf('Z2.3  Wielomian st. %d: RMSE = %.4e\n', N_deg, rmse_poly);

figure('Name','Z2 - reszty wielomianu st. 2');
subplot(2,1,1);
plot(T_dates, resid_poly); grid on;
title('Reszty (dane - wielomian st. 2)');
ylabel('PLN');
subplot(2,1,2);
histogram(resid_poly, 30); grid on;
title('Histogram reszt'); xlabel('PLN');

% 4. wykres
figure('Name','Z2 - trendy');
plot(T_dates, y, 'k-', 'LineWidth', 1.2, 'DisplayName','JPY'); hold on;
plot(T_dates, y_lin, 'r--', 'LineWidth', 1.4, 'DisplayName','trend globalny');
plot(T_dates(1:mid),     polyval(p_h1,t1), 'g-', 'LineWidth', 1.4, 'DisplayName','trend 1. polowa');
plot(T_dates(mid+1:end), polyval(p_h2,t2), 'b-', 'LineWidth', 1.4, 'DisplayName','trend 2. polowa');
legend('Location','best'); grid on;
title('JPY - trendy liniowe');

% Komentarz:
% - tak, nachylenia dwoch polowek roznia sie istotnie
%    - nachylenie pierwszej polowy to -5.4334e-06, a drugiej -1.6128e-05
% - histogram reszt jest raczej symetryczny (nie jest to idealny jak np.
% rozklad normalny, ale nie widac innych wzorcow, bardziej wskazuje na to,
% ze reszty sa faktycznym szumem)
% - przy wielomianie N=2 RMSE spadlo z 3.6309e-04 do 2.8619e-04, co jest
% dobrym znakiem
% - stopien wydaje sie byc okej dla tej waluty, przy wyzszych RMSE mogloby
% spasc jeszczew bardziej ale ryzykujemy overfittingiem

% Zadanie 3

ks = [5 21 63];
y  = JPYi;
n  = numel(y);
sm = nan(n, numel(ks));

for i = 1:numel(ks)
    k = ks(i);
    s = nan(n,1);
    for tt = k:n
        s(tt) = mean(y(tt-k+1:tt));
    end
    sm(:,i) = s;
end

figure('Name','Z3 - wygladzanie MA');
subplot(4,1,1); plot(T_dates, y, 'k'); grid on; title('Oryginal JPY');
for i = 1:numel(ks)
    subplot(4,1,i+1);
    plot(T_dates, sm(:,i)); grid on;
    title(sprintf('Srednia ruchoma wsteczna, k = %d', ks(i)));
end

mean_abs_resid = zeros(numel(ks),1);
std_resid      = zeros(numel(ks),1);
for i = 1:numel(ks)
    r = y - sm(:,i);
    r = r(~isnan(r));
    mean_abs_resid(i) = mean(abs(r));
    std_resid(i)      = std(r);
end

T3 = table(ks(:), mean_abs_resid, std_resid, ...
    'VariableNames', {'k','mean_abs_resid','std_resid'});
fprintf('\nZ3.4  Reszty wygladzania:\n');
disp(T3);

% Komentarz:
% - najmniejsza srednia bezweglna reszt jest dla k = 5 (0.00011302)
% - nie oznacza to ze jest najlepsza, bo k=5 jest male i dane prawie nie sa
% wygladzone, wiec mozemy wlaczac de facto szum
% - np. poczatek dla k=63 spadki sa zaczynaja sie dopiero w okolicach lipca
% k=5 sygnalizuje tez spadki dla wczesniejszych przedzialow, np. okolice
% kwietnia
% - ogolny trend - k=63, najlepiej eliminuje szum
% - lokalne zmiany mniejsze k (21 lub 5), w zaleznosci od potrzeby
% rozdrobnienia

% Zadanie 4

yJ = JPYi;
yC = CLPi;
n  = numel(yJ);

% 1. szereg
rng(42);
mu_J = mean(yJ);  s_J = std(yJ);
y3 = mu_J + s_J .* randn(n,1);

% 2. korelacje
cor_JC = corr(yJ, yC);
cor_J3 = corr(yJ, y3);
cor_C3 = corr(yC, y3);
T4a = table([cor_JC; cor_J3; cor_C3], ...
    'RowNames', {'JPY-CLP','JPY-S3','CLP-S3'}, ...
    'VariableNames', {'Pearson'});
fprintf('\nZ4.2  Korelacje Pearsona:\n'); disp(T4a);

% 3. odleglosc euklidesowa
eucl = @(a,b) sqrt(sum((a - b).^2));
e_JC = eucl(yJ, yC);
e_J3 = eucl(yJ, y3);
e_C3 = eucl(yC, y3);
T4b = table([e_JC; e_J3; e_C3], ...
    'RowNames', {'JPY-CLP','JPY-S3','CLP-S3'}, ...
    'VariableNames', {'Euclid'});
fprintf('Z4.3  Odleglosc Euklidesowa (globalna):\n'); disp(T4b);

% 4. odleglosc euklidesowa w oknie ruchomym k=5
D = nan(n,1);
for tt = k_win:n
    idx = (tt-k_win+1):tt;
    D(tt) = eucl(yJ(idx), yC(idx));
end
figure('Name','Z4 - D(t) okno k=5');
plot(T_dates, D); grid on;
title(sprintf('Odleglosc Euklidesowa JPY-CLP, okno k=%d', k_win));
xlabel('data'); ylabel('D(t)');

% po normalizacji (z-score)
zJ = (yJ - mean(yJ)) / std(yJ);
zC = (yC - mean(yC)) / std(yC);
z3 = (y3 - mean(y3)) / std(y3);

T4c = table([corr(zJ,zC); corr(zJ,z3); corr(zC,z3)], ...
    [eucl(zJ,zC); eucl(zJ,z3); eucl(zC,z3)], ...
    'RowNames', {'JPY-CLP','JPY-S3','CLP-S3'}, ...
    'VariableNames', {'Pearson_n','Euclid_n'});
fprintf('Z4.5  Po normalizacji (z-score):\n'); disp(T4c);

% Komentarz:
% - tak jest wyzsza, korelacja JPY-CLP wynosi 0.60645, co oznacza silny,
% dodatni związek liniowy, korelacje z szeregiem 3 oscylują wokół zera (-0.049 oraz 0.005),
% co sugeruje brak powiązania (szum)
% - najwieksze rozjechanie sie JPY i CLP to 11.04.2025. Pytanie: Czy moze
% to byc spowodowane jakims lokalnym kryzysem gospodarczym? Wzrost jakiegos
% zasobu?
% - tak, normalizacja zmienila rankding podobienstwa, odległość JPY-S3 wynosi zaledwie 0.0258, podczas gdy prawdziwych walut JPY-CLP aż 0.3361. 
% Po normalizacji odległość JPY-CLP wynosi 14.028, a odległości do losowego szumu wystrzeliły do 22.912 i 22.301. Ranking stal sie prawilowy. 
% JPY jest najbardziej zbliżone do CLP, a losowy szum (S3) został słusznie sklasyfikowany jako zupełnie niepodobny do żadnej z walut.