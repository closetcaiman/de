danych szeregi

Floracia danych - szeregi

Eksploracja danych 2025/2026

Grupa 4-Zestaw 5

Waluta A: JPY

Waluta B: CLP

Zakres: caly 2025

Stopień N (22): 2

Okno k (23): 5

Długość L1 (25): 4

Próg P (25): 115%

Próg 2 (25): 1%

Zadania obligatoryjne

Zadanie 1. Uspójnianie danych i przyrosty

1. Wczytaj kursy walut JPY i CLP z plików NBP dla zakresu cały 2025.

2. Sprawdź zgodność dat. Wypisz daty obecne tylko w jednym szeregu - liczbę takich dat i pierwsze 5 konkretnych.

3. Uspójnij oś czasu dwiema metodami: (a) intersekcja dat, (b) interpolacja liniowa (interp1).

4. Dla obu szeregów po uspójnieniu oblicz przyrosty bezwzględne, względne i logarytmiczne. Wyświetl średnią i odchylenie standardowe każdego rodzaju.

Pytanie do interpretacji: Skąd biorą się rozbieżności w datach między JPY a CLP? Wskaż konkretną datę z listy rozbieżności i zaproponuj wyjaśnienie (święto narodowe, dzień ustawowo wolny w kraju emitenta waluty). Który z dwóch szeregów ma większą zmienność? Argumentuj liczbowo. Czy ten wniosek zależy od rodzaju przyrostu (bezwzględny vs logarytmiczny)? Wyjaśnij, dlaczego porównywanie zmienności walut o różnym poziomie cen na podstawie przyrostów bezwzględnych może być mylące.

Zadanie 2. Trend liniowy i wielomianowy (stopień N = 2 )

1. Dla szeregu waluty JPY dopasuj trend liniowy do całego zakresu (polyfit, stopień 1). Oblicz RMSE.

2. Podziel szereg na dwie połowy. Dopasuj trend liniowy osobno do każdej. Wyświetl oba nachylenia i RMSE w obu częściach.

3. Dopasuj wielomian stopnia 2 do całego szeregu. Narysuj reszty (różnica dane - wielomian) oraz histogram reszt.

4. Wykres: dane + 3 linie (trend liniowy globalny, trend liniowy 1. połowy, trend liniowy 2. połowy).

Pytanie do interpretacji: Czy nachylenia obu połówek się różnią istotnie? Jeśli tak-znaczy, że trend globalny" jest sztucznym uśrednieniem dwóch zjawisk. Spójrz na histogram reszt z wielomianu stopnia 2-czy reszty wyglądają jak szum (symetria wokół zera), czy widzisz systematyczny wzorzec? Czy stopień 2 jest odpowiedni dla Twojej waluty, za niski czy za wysoki? Argumentuj liczbowo (RMSE, kształt reszt).

Zadanie 3. Wygładzanie średnią ruchomą (okno k = 5

1. Wygładź szereg waluty JPY średnią ruchomą wsteczną Y*sr(t) = mean(Y(t-k+1:t)) dla trzech wartości okna: k * 1 = 5 , k \_ 2 = 21 (miesiąc roboczy), k \* 3 = 63 kwartał roboczy).

2. Narysuj wykres z 4 subplot-ami: oryginał + 3 wygładzone wersje.

3. Dla każdego z 3 okien oblicz reszty wygładzania (różnica oryginał - wygładzony) i ich średnią bezwzględną oraz odchylenie standardowe.

4. Wyświetl tabelę: okno k, średnia | reszt, std reszt.

Pytanie do interpretacji: Dla którego k średnia bezwzględna reszt jest najmniejsza? Czy to oznacza, że jest najlepsze"? Uwaga - przy bardzo małym k reszty zawsze będą małe (prawie nie wygładzamy). Wskaż na wykresie konkretny moment, w którym widzisz różnicę między k = 5 k = 63 Który okres wygładzania uważasz za optymalny dla pokazania ogólnego kierunku trendu, a który dla analizy lokalnych wahań? Uzasadnij. Nie ma jednej dobrej odpowiedzi - oceniana jest jakość argumentacji.

Zadanie 4. Podobieństwo szeregów (okno k = 5)

1. Wygeneruj Szereg 3 (rozkład normalny, długość długość szeregów JPY i CLP, parametry μίσ dostosowane do skali waluty JPY).

2. Oblicz korelację Pearsona: JPY-CLP, JPY-Szereg3, CLP-Szereg 3. Wyświetl wartości w tabeli.

3. Oblicz odległość Euklidesową globalnie dla tych samych 3 par. 4.

Powtórz odległość Euklidesową dla pary JPY-CLP w oknie ruchomym k = 5 Narysuj wykres D(t).

5. Powtórz korelację oraz odległość po znormalizowaniu szeregów (Y-mean)/std.

Pytanie do interpretacji: Czy korelacja JPY CLP jest istotnie wyższa niż korelacja JPY Szereg3? Co to mówi o powiązaniu walut z Twojej pary? Na wykresie D(t) wskaż okres największego rozjeżdżania się JPY CLP-jakie wydarzenie z tego okresu mogło być przyczyną? Postaw konkretne pytanie badawcze (nie musisz znać odpowiedzi). Czy normalizacja zmieniła ranking podobieństwa?
