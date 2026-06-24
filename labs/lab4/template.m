% websave("data/archiwum_tab_a_2025.csv", "https://static.nbp.pl/dane/kursy/Archiwum/archiwum_tab_a_2025.csv")

clear; close all; clc;

% Zadanie 1

% 1. wczytanie danych
file = 'data/archiwum_tab_a_2025.csv';
N_deg = 2;
k_win = 5;
PP = 1.15;
PZ = 0.01;



% 2. daty obecne tylko w jednym z szeregow



% 3. uspojnianie osi czasu
% a) intersekcja dat


% b) interpolacja liniowa (interp1)



% 4. przyrosty bezwzgledne, wzgledne i logarytmiczne



% Zadanie 2

% 1. trend liniowy globalny (polyfit stopien 1), RMSE



% 2. trendy w dwoch polowach, nachylenia i RMSE



% 3. wielomian stopnia N_deg, reszty i histogram reszt



% 4. wykres: dane + 3 linie trendow



% Zadanie 3

% 1. wygladzanie srednia ruchoma wsteczna dla k = [5, 21, 63]



% 2. wykres z 4 subplotami (oryginal + 3 wygladzone)



% 3-4. reszty wygladzania: srednia bezwzgledna i odchylenie standardowe
%      tabela: k | mean_abs_resid | std_resid



% Zadanie 4

% 1. generacja Szeregu 3 (rozklad normalny, parametry dostosowane do JPY)



% 2. korelacja Pearsona: JPY-CLP, JPY-S3, CLP-S3



% 3. odleglosc Euklidesowa globalna dla 3 par



% 4. odleglosc Euklidesowa w oknie ruchomym k_win, wykres D(t)



% 5. korelacja i odleglosc po normalizacji (z-score)
