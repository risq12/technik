
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = AppStore();
  await store.load();
  runApp(TechnikAI(store: store));
}

class Lesson {
  final String id, course, title, theory, analogy, how, formula, example, task;
  final String question, answer;
  final List<String> choices;
  final int xp;
  const Lesson({
    required this.id, required this.course, required this.title,
    required this.theory, required this.analogy, required this.how,
    this.formula = '', this.example = '', required this.task,
    required this.question, required this.choices, required this.answer,
    this.xp = 20,
  });
}

class Course {
  final String id, title, subtitle, icon;
  final Color color;
  const Course(this.id, this.title, this.subtitle, this.icon, this.color);
}

const courses = <Course>[
  Course('mechanics', 'Mechanika – podstawy', 'Od sił i momentu do napędu', '⚙️', Color(0xFF4776C8)),
  Course('mechanics_diag', 'Mechanika – diagnostyka', 'Rozpoznawanie i usuwanie usterek', '🛠️', Color(0xFF4776C8)),
  Course('electronics', 'Elektronika', 'Prąd, napięcie, elementy i pomiary', '🔌', Color(0xFF269A83)),
  Course('electromech', 'Elektromechanika', 'Połączenie mechaniki i elektroniki', '🔧', Color(0xFF8A68C7)),
  Course('automation', 'Automatyka i robotyka', 'Czujniki, sterowanie i PLC', '🤖', Color(0xFFB47B35)),
  Course('programming', 'Programowanie', 'Wybierz język i ucz się praktycznie', '💻', Color(0xFF4C91B8)),
  Course('arduino', 'Arduino', 'Elektronika + kod + fizyczny układ', '🧩', Color(0xFF4C91B8)),
  Course('energy', 'Energetyka', 'Moc, sprawność i źródła energii', '⚡', Color(0xFFB38B36)),
  Course('cad_tinker', 'CAD: Tinkercad', 'Modelowanie 3D od podstaw', '🧊', Color(0xFF3D9A9A)),
  Course('cad_fusion', 'CAD: Fusion 360', 'Części, szkice i bryły parametryczne', '🧰', Color(0xFF3D9A9A)),
  Course('cad_onshape', 'CAD: Onshape', 'Projektowanie w chmurze', '📐', Color(0xFF3D9A9A)),
  Course('cad_inventor', 'CAD: Inventor', 'Modelowanie części i złożeń', '🏗️', Color(0xFF3D9A9A)),
  Course('cad_autocad', 'CAD: AutoCAD', 'Rysunek techniczny 2D', '📏', Color(0xFF3D9A9A)),
  Course('cad_freecad', 'CAD: FreeCAD', 'Darmowe projektowanie parametryczne', '🧱', Color(0xFF3D9A9A)),
];

final lessons = <Lesson>[
  // MECHANICS FOUNDATION
  Lesson(id:'m1',course:'mechanics',title:'Wielkości fizyczne i jednostki',
    theory:'Mechanika opisuje ruch, siły i energię. Zawsze zapisuj jednostki: długość w metrach (m), masę w kilogramach (kg), czas w sekundach (s), prędkość w m/s, a siłę w niutonach (N). Jednostki pomagają wykryć błędy w obliczeniach.',
    analogy:'To jak podawanie wymiarów śruby: samo „12” nic nie mówi. 12 mm i 12 cm to zupełnie co innego.',
    how:'Najpierw ustal, co znasz i czego szukasz. Potem dobierz wzór, podstaw wartości w spójnych jednostkach i sprawdź, czy wynik ma sens.',
    formula:'v = s / t     oraz     F = m · a',
    example:'Jeśli pojazd przejechał 100 m w 5 s, to v = 100 / 5 = 20 m/s.',
    task:'Przelicz 36 km/h na m/s. Podziel wartość przez 3,6.',
    question:'Ile metrów na sekundę odpowiada 36 km/h?',choices:['5 m/s','10 m/s','36 m/s'],answer:'10 m/s'),
  Lesson(id:'m2',course:'mechanics',title:'Siła, masa i przyspieszenie',
    theory:'Siła może zmienić prędkość, kierunek ruchu albo odkształcić element. Masa opisuje bezwładność obiektu. Im większa masa, tym trudniej nadać mu takie samo przyspieszenie.',
    analogy:'Pusty wózek sklepowy rozpędzisz łatwiej niż wózek załadowany zakupami.',
    how:'Jeśli znasz masę i przyspieszenie, mnożysz je. Wynik otrzymujesz w niutonach.',
    formula:'F = m · a',
    example:'Masa 2 kg przyspiesza z 3 m/s²: F = 2 · 3 = 6 N.',
    task:'Oblicz siłę potrzebną do rozpędzenia masy 4 kg z przyspieszeniem 2 m/s².',
    question:'Jaka siła działa na masę 4 kg przy 2 m/s²?',choices:['2 N','6 N','8 N'],answer:'8 N'),
  Lesson(id:'m3',course:'mechanics',title:'Moment obrotowy',
    theory:'Moment obrotowy mówi, jak mocno siła próbuje obrócić element wokół osi. Zależy od wartości siły i długości ramienia, czyli odległości od osi obrotu.',
    analogy:'Odkręcanie nakrętki długim kluczem jest łatwiejsze niż krótkim, bo ta sama siła działa na większym ramieniu.',
    how:'Siła musi działać prostopadle do ramienia, aby uzyskać maksymalny moment. W rzeczywistości kąt działania też ma znaczenie.',
    formula:'M = F · r  (dla siły prostopadłej)',
    example:'Siła 20 N na ramieniu 0,25 m daje M = 20 · 0,25 = 5 Nm.',
    task:'Policz moment dla siły 30 N i ramienia 0,2 m.',
    question:'Jaki moment daje 30 N na ramieniu 0,2 m?',choices:['6 Nm','15 Nm','60 Nm'],answer:'6 Nm'),
  Lesson(id:'m4',course:'mechanics',title:'Przekładnia zębata – zasada działania',
    theory:'Przekładnia przenosi ruch i moment między wałami. Małe koło napędzające duże koło zmniejsza prędkość obrotową i zwykle zwiększa moment na wyjściu. Duże napędzające małe – zwiększa obroty, ale zmniejsza moment.',
    analogy:'To jak biegi w rowerze: łatwy bieg pomaga ruszyć pod górę, ale pedałujesz szybciej.',
    how:'Porównaj liczbę zębów obu kół. Stosunek liczby zębów koła napędzanego do napędzającego określa przełożenie w przyjętej tu konwencji.',
    formula:'i = z₂ / z₁     oraz     n₂ = n₁ / i',
    example:'Koło 20 zębów napędza koło 60 zębów. i = 60/20 = 3. Gdy wejście ma 900 obr/min, wyjście ma około 300 obr/min.',
    task:'Koło 15-zębne napędza koło 45-zębne. Wyznacz przełożenie.',
    question:'Jakie jest przełożenie 15 → 45 zębów?',choices:['i = 0,33','i = 3','i = 30'],answer:'i = 3'),
  Lesson(id:'m5',course:'mechanics',title:'Moc mechaniczna i sprawność',
    theory:'Moc określa, jak szybko wykonywana jest praca lub przekazywana energia. Sprawność pokazuje, jaka część energii wejściowej staje się użytecznym efektem. Reszta zwykle zamienia się m.in. w ciepło i dźwięk.',
    analogy:'Dwa silniki mogą wykonać tę samą pracę, ale mocniejszy zrobi to w krótszym czasie.',
    how:'Dla ruchu obrotowego moc zależy od momentu i prędkości kątowej. Sprawność podajemy jako ułamek lub procent.',
    formula:'P = W / t     η = Pwy / Pwe · 100%',
    example:'Urządzenie pobiera 500 W i oddaje 400 W użytecznej mocy. Sprawność = 400/500 · 100% = 80%.',
    task:'Silnik pobiera 1000 W, a na wyjściu daje 750 W. Oblicz sprawność.',
    question:'Jaka jest sprawność układu 750 W / 1000 W?',choices:['25%','75%','133%'],answer:'75%'),
  // MECHANICS DIAGNOSTICS
  Lesson(id:'md1',course:'mechanics_diag',title:'Diagnostyka: hałas łożyska',
    theory:'Uszkodzone łożysko może hałasować, grzać się i mieć nadmierny luz. Sam dźwięk nie wystarcza do diagnozy – trzeba sprawdzić warunki pracy, mocowanie i stan pozostałych elementów.',
    analogy:'To jak szum w kole roweru: może pochodzić z łożyska, ale też z ocierającego hamulca.',
    how:'Zatrzymaj urządzenie, zabezpiecz je przed przypadkowym uruchomieniem, sprawdź luz i obrót ręczny. Nie dotykaj ruchomych części podczas pracy.',
    task:'W symulacji wybierz najpierw bezpieczne zatrzymanie napędu, a dopiero potem kontrolę luzu.',
    question:'Co robisz przed kontrolą łożyska w maszynie?',choices:['Zatrzymuję i zabezpieczam napęd','Wkładam rękę do pracującej maszyny','Zwiększam obroty'],answer:'Zatrzymuję i zabezpieczam napęd'),
  Lesson(id:'md2',course:'mechanics_diag',title:'Diagnostyka: pasek napędowy',
    theory:'Pasek może ślizgać się przez zbyt małe napięcie, zużycie, zabrudzenie lub niewspółosiowość kół. Nadmierne napięcie również szkodzi, bo przeciąża łożyska.',
    analogy:'Zbyt luźny pasek przypomina łańcuch rowerowy, który przeskakuje pod obciążeniem.',
    how:'Sprawdź dokumentację producenta, stan paska, osiowość kół i napięcie metodą przewidzianą dla danego napędu.',
    task:'Wskaż przyczynę, która może powodować poślizg paska.',
    question:'Która przyczyna może wywołać ślizganie paska?',choices:['Zbyt małe napięcie','Idealna osiowość','Prawidłowy naciąg'],answer:'Zbyt małe napięcie'),
  Lesson(id:'md3',course:'mechanics_diag',title:'Diagnostyka: silnik nie osiąga mocy',
    theory:'Spadek mocy może wynikać z problemów z zasilaniem, zapłonem, dolotem, wydechem, kompresją, chłodzeniem lub przeniesieniem napędu. Wymienianie części na chybił trafił jest kosztowne.',
    analogy:'Jeśli człowiek nie ma siły biec, sprawdzasz oddech, jedzenie i zmęczenie, a nie od razu wymieniasz nogi.',
    how:'Zapisz objaw i warunki jego występowania. Zacznij od prostych kontroli i pomiarów zgodnych z instrukcją serwisową.',
    task:'Ułóż diagnozę od obserwacji objawu do pomiaru, zamiast od razu wymieniać części.',
    question:'Jaki jest najlepszy pierwszy krok diagnostyczny?',choices:['Dokładny opis objawu i warunków','Wymiana losowej części','Ignorowanie objawu'],answer:'Dokładny opis objawu i warunków'),
  // ELECTRONICS
  Lesson(id:'e1',course:'electronics',title:'Napięcie, prąd i rezystancja',
    theory:'Napięcie jest różnicą potencjałów, która może wymusić przepływ prądu. Prąd to uporządkowany przepływ ładunku. Rezystancja opisuje, jak mocno element ogranicza przepływ prądu.',
    analogy:'Wyobraź sobie instalację wodną: napięcie przypomina różnicę ciśnień, prąd – ilość przepływającej wody na sekundę, a rezystancja – zwężenie rury. To analogia, nie pełny opis elektryczności.',
    how:'W prostym obwodzie rezystancyjnym większe napięcie daje większy prąd, a większa rezystancja ogranicza prąd.',
    formula:'U = I · R     I = U / R',
    example:'Zasilacz 12 V i rezystor 600 Ω: I = 12/600 = 0,02 A = 20 mA.',
    task:'Oblicz prąd dla 9 V i rezystora 300 Ω.',
    question:'Jaki prąd płynie przy 9 V i 300 Ω?',choices:['3 mA','30 mA','300 mA'],answer:'30 mA'),
  Lesson(id:'e2',course:'electronics',title:'Obwód szeregowy i równoległy',
    theory:'W szeregu elementy są połączone jeden za drugim – przez każdy płynie ten sam prąd. Równolegle elementy mają wspólne dwa węzły – napięcie na gałęziach jest takie samo.',
    analogy:'Szereg to jedna droga z kilkoma bramkami. Równoległe połączenie to kilka osobnych dróg między tym samym początkiem i końcem.',
    how:'W szeregu rezystancje się sumują. Dla dwóch rezystorów równoległych rezystancja zastępcza jest mniejsza od każdego z nich.',
    formula:'Rsz = R₁ + R₂     1/Rr = 1/R₁ + 1/R₂',
    example:'Dwa rezystory 100 Ω szeregowo dają 200 Ω. Równolegle dają 50 Ω.',
    task:'Dwa rezystory 10 Ω połącz szeregowo – oblicz opór zastępczy.',
    question:'Jaki opór mają dwa rezystory 10 Ω w szeregu?',choices:['5 Ω','10 Ω','20 Ω'],answer:'20 Ω'),
  Lesson(id:'e3',course:'electronics',title:'Dioda LED i rezystor',
    theory:'LED przewodzi głównie w jednym kierunku i emituje światło. Rezystor szeregowy ogranicza prąd. Bez ograniczenia prądu dioda może się uszkodzić.',
    analogy:'LED jest jak zawór jednokierunkowy, ale nie jest samoregulującym ogranicznikiem przepływu. Rezystor działa jak kontrolowane zwężenie.',
    how:'Anoda LED jest zwykle dłuższą nóżką, katoda krótszą i ma spłaszczenie obudowy. W praktyce sprawdź oznaczenia elementu. Dobierz rezystor z prawa Ohma.',
    formula:'R = (Uzasilania − ULED) / ILED',
    example:'Dla 5 V, LED 2 V i prądu 10 mA: R = (5−2)/0,01 = 300 Ω. Wybiera się najbliższą odpowiednią wartość standardową, np. 330 Ω.',
    task:'W symulatorze połącz źródło, rezystor i LED w jednym zamkniętym obwodzie.',
    question:'Po co dajemy rezystor szeregowo z LED?',choices:['Ogranicza prąd','Zwiększa napięcie do nieskończoności','Zmienia LED w silnik'],answer:'Ogranicza prąd'),
  Lesson(id:'e4',course:'electronics',title:'Multimetr – podstawowe pomiary',
    theory:'Multimetr może mierzyć napięcie, rezystancję, ciągłość, a w odpowiednim trybie także prąd. Sposób podłączenia zależy od rodzaju pomiaru.',
    analogy:'Woltomierz sprawdza różnicę między dwoma punktami, a amperomierz musi znaleźć się w drodze przepływu prądu.',
    how:'Napięcie mierzy się równolegle. Prąd mierzy się szeregowo, z właściwym gniazdem i zakresem. Nigdy nie przykładaj miernika ustawionego na prąd bezpośrednio do źródła napięcia.',
    task:'Wybierz poprawny sposób podłączenia miernika do pomiaru napięcia na rezystorze.',
    question:'Jak podłączamy miernik przy pomiarze napięcia?',choices:['Równolegle do elementu','Szeregowo zamiast elementu','Bez przewodów'],answer:'Równolegle do elementu'),
  Lesson(id:'e5',course:'electronics',title:'Tranzystor jako przełącznik',
    theory:'Tranzystor może sterować większym prądem za pomocą mniejszego sygnału sterującego. W układzie cyfrowym często pracuje jako elektroniczny przełącznik.',
    analogy:'Mały przycisk może sterować dużym stycznikiem. Tranzystor robi podobną rzecz w elektronice, ale z półprzewodnika.',
    how:'Trzeba znać typ tranzystora, wyprowadzenia, dopuszczalne napięcie i prąd oraz sposób sterowania. Dla obciążeń indukcyjnych często potrzebna jest dioda zabezpieczająca.',
    task:'Wskaż, dlaczego nie podłącza się dużego silnika bezpośrednio do pinu mikrokontrolera.',
    question:'Dlaczego pin Arduino nie powinien bezpośrednio zasilać dużego silnika?',choices:['Ma ograniczoną wydajność prądową','Bo silnik nie ma koloru','Bo kod nie obsługuje obrotów'],answer:'Ma ograniczoną wydajność prądową'),
  Lesson(id:'e6',course:'electronics',title:'Bezpieczeństwo i zasilanie',
    theory:'Zasilacz musi mieć odpowiednie napięcie, polaryzację i zapas wydajności prądowej. Zwarcie może spowodować przegrzanie przewodów, uszkodzenie źródła lub pożar. Instalacje sieciowe wymagają kwalifikacji i procedur.',
    analogy:'Nie podłączasz cienkiego wężyka do hydrantu – przewód i element muszą być dobrane do obciążenia.',
    how:'Zaczynaj od niskich, bezpiecznych napięć laboratoryjnych. Używaj ograniczenia prądu, sprawdzaj polaryzację i nie pracuj przy napięciu sieciowym bez uprawnień i nadzoru.',
    task:'Wybierz najbezpieczniejszy sposób testowania nowego układu.',
    question:'Jak bezpiecznie uruchomić prototyp niskonapięciowy?',choices:['Zasilacz laboratoryjny z ograniczeniem prądu','Dowolny zasilacz o wyższym napięciu','Zwarcie na próbę'],answer:'Zasilacz laboratoryjny z ograniczeniem prądu'),
  // ELECTROMECHANICS locked
  Lesson(id:'em1',course:'electromech',title:'Silnik elektryczny – budowa',
    theory:'Silnik zamienia energię elektryczną na mechaniczną. W zależności od rodzaju wykorzystuje pole magnetyczne stojana i wirnika. Ważne są napięcie, prąd, moment, obroty i chłodzenie.',
    analogy:'To jak odwrócenie generatora: zamiast napędzać wał, podajesz energię elektryczną i otrzymujesz ruch.',
    how:'Rodzaj silnika determinuje sposób sterowania. Silniki DC, BLDC, asynchroniczne i krokowe mają różne wymagania.',
    task:'Dopasuj sterownik do rodzaju silnika zgodnie z dokumentacją producenta.',
    question:'Co robi silnik elektryczny?',choices:['Zamienia energię elektryczną na mechaniczną','Zamienia masę w napięcie','Mierzy temperaturę'],answer:'Zamienia energię elektryczną na mechaniczną'),
  Lesson(id:'em2',course:'electromech',title:'Przekaźnik i stycznik',
    theory:'Przekaźnik pozwala sterować jednym obwodem za pomocą drugiego. Stycznik jest przeznaczony do częstego łączenia większych obciążeń, zgodnie z jego parametrami.',
    analogy:'Mały sygnał sterujący naciska na elektryczny przełącznik, który obsługuje osobny obwód.',
    how:'Cewka wytwarza pole magnetyczne i przełącza styki. Dobierz napięcie cewki oraz parametry styków do obciążenia.',
    task:'Rozpoznaj, że obwód sterowania i obwód mocy to różne części układu.',
    question:'Co oddziela przekaźnik w typowym układzie?',choices:['Obwód sterowania od obwodu przełączanego','Wał od koła','Dwa kolory przewodu'],answer:'Obwód sterowania od obwodu przełączanego'),
  Lesson(id:'em3',course:'electromech',title:'Czujniki położenia i prędkości',
    theory:'Czujniki przekazują sterownikowi informację o stanie maszyny. Mogą wykrywać położenie, prędkość, temperaturę, ciśnienie lub obecność obiektu.',
    analogy:'Czujnik jest jak zmysł maszyny – dostarcza informacji, ale sam nie podejmuje decyzji.',
    how:'Wybierz czujnik według mierzonej wielkości, zakresu, dokładności, wyjścia i środowiska pracy.',
    task:'Dobierz czujnik do wykrywania metalowego elementu bez kontaktu.',
    question:'Jaki czujnik często wykrywa metal bez kontaktu?',choices:['Indukcyjny','Mikrofon','Fotodioda zawsze'],answer:'Indukcyjny'),
  // AUTOMATION
  Lesson(id:'a1',course:'automation',title:'Układ sterowania – wejście, logika, wyjście',
    theory:'Typowy układ automatyki zbiera dane z czujników, przetwarza je w sterowniku i steruje elementami wykonawczymi. Proces powtarza się w pętli.',
    analogy:'Czujnik to oczy, sterownik to mózg, a siłownik to mięśnie.',
    how:'Sygnał wejściowy trafia do logiki programu. Wynik steruje wyjściem, np. lampką, zaworem lub silnikiem.',
    task:'Ułóż kolejność: czujnik, sterownik, siłownik.',
    question:'Co zwykle znajduje się pomiędzy czujnikiem a siłownikiem?',choices:['Sterownik','Łożysko','Obudowa'],answer:'Sterownik'),
  Lesson(id:'a2',course:'automation',title:'Czujniki cyfrowe i analogowe',
    theory:'Sygnał cyfrowy przyjmuje określone stany, np. 0/1. Analogowy zmienia się płynnie w pewnym zakresie, np. 0–10 V lub 4–20 mA.',
    analogy:'Cyfrowy jest jak włącznik światła. Analogowy jest jak pokrętło ściemniacza.',
    how:'Sprawdź typ wyjścia, zakres, zasilanie, sposób podłączenia i wymagania sterownika.',
    task:'Wybierz typ sygnału do pomiaru płynnie zmieniającej się temperatury.',
    question:'Który sygnał lepiej opisuje płynnie zmieniającą się wartość?',choices:['Analogowy','Tylko 0/1','Brak sygnału'],answer:'Analogowy'),
  Lesson(id:'a3',course:'automation',title:'Logika AND, OR i NOT',
    theory:'AND daje 1, gdy wszystkie warunki są prawdziwe. OR daje 1, gdy prawdziwy jest przynajmniej jeden. NOT odwraca stan logiczny.',
    analogy:'AND: drzwi otworzą się, jeśli masz kartę i kod. OR: wystarczy karta lub kod.',
    how:'Zapisz warunki jako sygnały 0/1 i sprawdź tabelę prawdy.',
    formula:'AND: 1·1=1; OR: 1+0=1; NOT(1)=0',
    task:'Jeśli A=1 i B=0, oblicz A AND B.',
    question:'A=1, B=0. Ile wynosi A AND B?',choices:['0','1','2'],answer:'0'),
  Lesson(id:'a4',course:'automation',title:'PLC – do czego służy?',
    theory:'PLC to programowalny sterownik logiczny używany do sterowania maszynami i procesami. Odczytuje wejścia, wykonuje program i ustawia wyjścia.',
    analogy:'PLC to przemysłowy komputer zaprojektowany do pracy w trudniejszych warunkach.',
    how:'Program może być zapisany np. w języku drabinkowym. Projekt musi uwzględniać bezpieczeństwo, blokady i stany awaryjne.',
    task:'Rozpoznaj, że zatrzymanie awaryjne nie może zależeć wyłącznie od zwykłego programu aplikacji.',
    question:'Do czego służy PLC?',choices:['Do sterowania procesem lub maszyną','Tylko do rysowania 3D','Do przechowywania paliwa'],answer:'Do sterowania procesem lub maszyną'),
  // PROGRAMMING
  Lesson(id:'p1',course:'programming',title:'Wybierz język programowania',
    theory:'Różne języki rozwiązują podobne problemy, ale mają inne zastosowania. C jest popularny w systemach bliskich sprzętowi, C++ w systemach wbudowanych i aplikacjach, Python w automatyzacji i analizie danych, a JavaScript w aplikacjach internetowych.',
    analogy:'To jak zestaw narzędzi: młotek, klucz i śrubokręt są różne, ale każdy ma swoje zadanie.',
    how:'Wybierz język, a potem ucz się zmiennych, warunków, pętli, funkcji i pracy z danymi.',
    task:'Wybierz język, którego ścieżkę chcesz rozpocząć w aplikacji.',
    question:'Który język jest często używany w prostych skryptach i analizie danych?',choices:['Python','HTML jako język programowania ogólnego','G-code'],answer:'Python'),
  Lesson(id:'p2',course:'programming',title:'Zmienne i typy danych',
    theory:'Zmienna przechowuje wartość, której program może użyć. Typ określa, jakie dane przechowujemy, np. liczbę całkowitą, liczbę zmiennoprzecinkową lub tekst.',
    analogy:'Zmienna to podpisane pudełko. Wiesz, co do niego wkładasz i jakiego rodzaju zawartości oczekujesz.',
    how:'Nadaj zmiennej nazwę, przypisz wartość i wykorzystaj ją w obliczeniu.',
    example:'temperatura = 25; po zwiększeniu o 5 otrzymasz 30.',
    task:'Wymyśl zmienną przechowującą obroty silnika.',
    question:'Do czego służy zmienna?',choices:['Do przechowywania danych','Do chłodzenia procesora','Do zwiększania napięcia'],answer:'Do przechowywania danych'),
  Lesson(id:'p3',course:'programming',title:'Warunki i pętle',
    theory:'Warunek pozwala wykonać kod tylko wtedy, gdy spełnione jest określone kryterium. Pętla powtarza instrukcje, dopóki warunek jest spełniony lub określoną liczbę razy.',
    analogy:'Jeśli temperatura jest za wysoka, włącz wentylator. Powtarzaj pomiar co sekundę.',
    how:'Uważaj na warunki kończące pętlę, aby nie stworzyć nieskończonego powtarzania.',
    task:'Zaprojektuj regułę: jeśli temperatura przekracza 60°C, włącz alarm.',
    question:'Co robi instrukcja warunkowa?',choices:['Wybiera działanie na podstawie warunku','Zawsze powtarza kod bez końca','Usuwa wszystkie zmienne'],answer:'Wybiera działanie na podstawie warunku'),
  Lesson(id:'p4',course:'programming',title:'Funkcje i dzielenie programu',
    theory:'Funkcja to nazwany fragment kodu wykonujący określone zadanie. Dzięki funkcjom program jest czytelniejszy, łatwiejszy do testowania i ponownego wykorzystania.',
    analogy:'To jak osobna procedura warsztatowa: raz opisujesz wymianę koła, a potem odwołujesz się do tej instrukcji.',
    how:'Funkcja może przyjmować argumenty i zwracać wynik.',
    task:'Zaprojektuj funkcję obliczającą obwód koła z promienia.',
    question:'Co może robić funkcja?',choices:['Przyjmować dane i zwracać wynik','Tylko zmieniać kolor ekranu','Zastępować zasilacz'],answer:'Przyjmować dane i zwracać wynik'),
  // ARDUINO
  Lesson(id:'ar1',course:'arduino',title:'Arduino – płytka i piny',
    theory:'Arduino to platforma do nauki elektroniki i programowania mikrokontrolerów. Piny cyfrowe mogą odczytywać stan lub sterować prostymi sygnałami. Piny analogowe odczytują napięcie w określonym zakresie.',
    analogy:'Płytka jest małym sterownikiem: odbiera sygnały z czujników i steruje wyjściami.',
    how:'Sprawdź napięcie logiki, limity prądowe, mapę pinów i dokumentację konkretnej płytki.',
    task:'Wybierz pin cyfrowy do sterowania diodą przez rezystor.',
    question:'Czy diodę LED należy podłączać do pinu bez rezystora?',choices:['Nie, trzeba ograniczyć prąd','Tak, zawsze bezpośrednio','Tylko przy 12 V'],answer:'Nie, trzeba ograniczyć prąd'),
  Lesson(id:'ar2',course:'arduino',title:'Wejście, wyjście i pierwszy program',
    theory:'Program ustawia pin jako wejście lub wyjście. Następnie może odczytać przycisk i sterować diodą.',
    analogy:'Wejście to pytanie zadane światu, a wyjście to odpowiedź płytki.',
    how:'W Arduino typowy program ma setup() wykonywane raz i loop() wykonywane wielokrotnie.',
    example:'pinMode(LED_BUILTIN, OUTPUT); digitalWrite(LED_BUILTIN, HIGH);',
    task:'Zaplanuj układ: przycisk na wejściu, LED z rezystorem na wyjściu.',
    question:'Która funkcja Arduino konfiguruje pin?',choices:['pinMode()','digitalWrite()','delay()'],answer:'pinMode()'),
  Lesson(id:'ar3',course:'arduino',title:'Czujnik i reakcja układu',
    theory:'Mikrokontroler może odczytywać czujnik i reagować na przekroczenie progu. W prawdziwym układzie trzeba uwzględnić zakłócenia, kalibrację i bezpieczeństwo.',
    analogy:'To jak termostat: mierzy temperaturę i włącza urządzenie po przekroczeniu ustalonej wartości.',
    how:'Odczytaj sygnał, przelicz go na jednostkę fizyczną, porównaj z progiem i steruj wyjściem.',
    task:'Zbuduj logikę: jeśli odczyt przekracza próg, zapal diodę.',
    question:'Co powinno nastąpić po przekroczeniu ustawionego progu?',choices:['Program wykonuje zaplanowaną reakcję','Mikrokontroler ignoruje pomiar','Zawsze wyłącza zasilanie całego domu'],answer:'Program wykonuje zaplanowaną reakcję'),
  // ENERGY
  Lesson(id:'en1',course:'energy',title:'Energia, praca i moc',
    theory:'Energia opisuje zdolność do wykonania pracy. Moc mówi, jak szybko energia jest przekazywana lub przetwarzana. W praktyce moc urządzeń podaje się np. w watach.',
    analogy:'Dwa zbiorniki mogą dostarczyć tyle samo wody, ale jeden opróżnia się szybciej. To różnica między ilością energii a mocą.',
    how:'Energia elektryczna zależy od mocy i czasu pracy.',
    formula:'E = P · t',
    example:'Urządzenie 100 W pracujące 2 h zużyje 200 Wh = 0,2 kWh.',
    task:'Oblicz energię urządzenia 500 W pracującego przez 2 godziny.',
    question:'Ile energii zużyje 500 W przez 2 h?',choices:['0,1 kWh','1 kWh','2 kWh'],answer:'1 kWh'),
  Lesson(id:'en2',course:'energy',title:'Sprawność i straty energii',
    theory:'Żadne rzeczywiste urządzenie nie zamienia całej energii wejściowej na użyteczny efekt. Straty pojawiają się m.in. jako ciepło, tarcie, opory elektryczne i hałas.',
    analogy:'Silnik, który się nagrzewa, oddaje część energii do otoczenia zamiast zamieniać ją na ruch.',
    how:'Sprawność to stosunek energii lub mocy użytecznej do pobranej.',
    formula:'η = Ewy / Ewe · 100%',
    example:'Z 1000 J energii wejściowej otrzymano 800 J pracy użytecznej. Sprawność wynosi 80%.',
    task:'Oblicz sprawność urządzenia, które z 200 J wykorzystuje 150 J.',
    question:'Jaka jest sprawność 150 J / 200 J?',choices:['50%','75%','125%'],answer:'75%'),
  Lesson(id:'en3',course:'energy',title:'Źródła energii',
    theory:'Energia może pochodzić z paliw, słońca, wiatru, wody, geotermii i reakcji jądrowych. Każde źródło ma inną dyspozycyjność, wpływ na środowisko, koszty i wymagania infrastrukturalne.',
    analogy:'To jak różne sposoby zasilania warsztatu: sieć, agregat, akumulator lub instalacja fotowoltaiczna.',
    how:'Porównuj źródła według mocy, czasu dostępności, magazynowania, sprawności i wpływu środowiskowego.',
    task:'Wskaż, dlaczego magazynowanie energii pomaga przy fotowoltaice.',
    question:'Po co magazynować energię z PV?',choices:['Aby wykorzystać ją także poza okresem produkcji','Aby panele świeciły w nocy','Aby energia nie miała strat'],answer:'Aby wykorzystać ją także poza okresem produkcji'),
  // CAD: 2-3 lessons each
  Lesson(id:'ct1',course:'cad_tinker',title:'Tinkercad: bryły i widok roboczy',
    theory:'Tinkercad pozwala tworzyć modele z prostych brył. Łącząc bryły i otwory, budujesz bardziej złożone kształty.',
    analogy:'To jak składanie kształtu z klocków, z których część dodaje materiał, a część go odejmuje.',
    how:'Ustaw bryłę, zmień wymiary, wyrównaj obiekty, a potem grupuj lub odejmuj kształty.',
    task:'Zbuduj prosty dystans: walec i otwór przechodzący przez środek.',
    question:'Co robi funkcja grupowania brył?',choices:['Łączy obiekty w jeden kształt','Zmienia materiał na metal','Eksportuje rysunek 2D'],answer:'Łączy obiekty w jeden kształt'),
  Lesson(id:'ct2',course:'cad_tinker',title:'Tinkercad: dokładne wymiary i eksport',
    theory:'Model do druku musi mieć poprawne wymiary i geometrię. Eksport STL zapisuje powierzchnię bryły, a nie pełną historię parametrów.',
    analogy:'STL jest jak gotowy odlew – widać kształt, ale nie wszystkie kroki jego projektowania.',
    how:'Używaj siatki, wpisuj wymiary numerycznie, sprawdź model i wyeksportuj STL.',
    task:'Zmień średnicę otworu na dokładnie 5 mm.',
    question:'Jaki format jest często używany do druku 3D?',choices:['STL','MP3','TXT'],answer:'STL'),
  Lesson(id:'cf1',course:'cad_fusion',title:'Fusion 360: szkic 2D',
    theory:'Szkic jest podstawą wielu modeli parametrycznych. Linie, okręgi i wymiary opisują geometrię, a więzy kontrolują jej położenie.',
    analogy:'Szkic to plan na papierze, z którego później wyciągasz bryłę.',
    how:'Wybierz płaszczyznę, narysuj geometrię, dodaj wymiary i więzy, aby szkic był jednoznaczny.',
    task:'Narysuj prostokąt 40 × 20 mm i zwymiaruj go.',
    question:'Po co dodaje się więzy szkicu?',choices:['Aby kontrolować geometrię i jej zachowanie','Aby zmienić kolor ekranu','Aby zwiększyć temperaturę dyszy'],answer:'Aby kontrolować geometrię i jej zachowanie'),
  Lesson(id:'cf2',course:'cad_fusion',title:'Fusion 360: wyciągnięcie i otwór',
    theory:'Wyciągnięcie zamienia zamknięty profil 2D w bryłę 3D. Operacje takie jak otwór, faza i zaokrąglenie nadają części funkcjonalny kształt.',
    analogy:'To jak wycięcie kształtu z kartonu i nadanie mu grubości.',
    how:'Wybierz zamknięty profil, uruchom Extrude, podaj odległość i wybierz tryb dodawania lub wycinania.',
    task:'Utwórz płytkę o grubości 5 mm i wykonaj w niej otwór.',
    question:'Co robi operacja Extrude?',choices:['Nadaje profilowi głębokość','Usuwa historię projektu','Zmienia jednostki na cale'],answer:'Nadaje profilowi głębokość'),
  Lesson(id:'co1',course:'cad_onshape',title:'Onshape: dokumenty i szkice',
    theory:'Onshape działa w przeglądarce i zapisuje projekty w dokumentach chmurowych. Modelowanie zaczyna się zwykle od szkicu na płaszczyźnie.',
    analogy:'Projekt jest jak dokument online – możesz pracować na nim z różnych komputerów.',
    how:'Utwórz dokument, Part Studio, szkic, geometrię i wymiary. Kontroluj wersje i udostępnianie.',
    task:'Utwórz szkic prostokąta i nadaj mu wymiary.',
    question:'Gdzie w Onshape tworzysz części?',choices:['Part Studio','Render Queue only','Pulpit Windows'],answer:'Part Studio'),
  Lesson(id:'co2',course:'cad_onshape',title:'Onshape: bryły i współpraca',
    theory:'Operacje modelowania tworzą i modyfikują bryły. Współdzielenie pozwala pracować zespołowo, ale wymaga kontroli uprawnień.',
    analogy:'Kilka osób może pracować nad jednym projektem, podobnie jak nad wspólnym dokumentem.',
    how:'Używaj Extrude, Revolve, Fillet i Assembly. Przed udostępnieniem sprawdź uprawnienia.',
    task:'Zbuduj prostą bryłę i utwórz jej zaokrągloną krawędź.',
    question:'Do czego służy Assembly?',choices:['Do składania komponentów w zespół','Do rysowania wykresów audio','Do zmiany hasła'],answer:'Do składania komponentów w zespół'),
  Lesson(id:'ci1',course:'cad_inventor',title:'Inventor: część i szkic',
    theory:'Autodesk Inventor to parametryczny CAD do projektowania części i zespołów. Szkic 2D jest bazą operacji bryłowych.',
    analogy:'Najpierw rysujesz przekrój lub zarys, potem nadajesz mu trzeci wymiar.',
    how:'Utwórz plik części, wybierz płaszczyznę, wykonaj szkic, zwymiaruj go i użyj Extrude.',
    task:'Zaprojektuj prostą tuleję z otworem.',
    question:'Jaki jest typowy pierwszy etap modelowania części?',choices:['Szkic 2D','Eksport animacji','Drukowanie rysunku'],answer:'Szkic 2D'),
  Lesson(id:'ci2',course:'cad_inventor',title:'Inventor: złożenia i wiązania',
    theory:'Złożenie łączy wiele części i określa ich wzajemne położenie. Wiązania ograniczają stopnie swobody komponentów.',
    analogy:'To jak montaż prawdziwej maszyny: każda część musi mieć określone miejsce i sposób ruchu.',
    how:'Wstaw komponenty, ustal bazę i dodaj wiązania zgodnie z ruchem mechanizmu.',
    task:'Połącz wał i koło tak, aby miały wspólną oś.',
    question:'Po co stosuje się wiązania w złożeniu?',choices:['Aby określić położenie i ruch części','Aby zwiększyć rozdzielczość monitora','Aby dodać dźwięk'],answer:'Aby określić położenie i ruch części'),
  Lesson(id:'ca1',course:'cad_autocad',title:'AutoCAD: współrzędne i linie',
    theory:'AutoCAD jest często używany do rysunków 2D i dokumentacji. Precyzja opiera się na współrzędnych, jednostkach, warstwach i wymiarowaniu.',
    analogy:'To cyfrowa deska kreślarska, w której możesz wpisywać dokładne położenie punktów.',
    how:'Ustaw jednostki, używaj poleceń LINE, OFFSET, TRIM i OSNAP. Pracuj na warstwach.',
    task:'Narysuj prostokąt o wymiarach 100 × 50 mm.',
    question:'Do czego służy OSNAP?',choices:['Do precyzyjnego wskazywania punktów charakterystycznych','Do renderowania dźwięku','Do zmiany języka Windows'],answer:'Do precyzyjnego wskazywania punktów charakterystycznych'),
  Lesson(id:'ca2',course:'cad_autocad',title:'AutoCAD: warstwy i wymiarowanie',
    theory:'Warstwy porządkują elementy rysunku, np. osie, kontury i wymiary. Wymiarowanie przekazuje rzeczywiste wartości projektowe.',
    analogy:'Warstwy są jak przezroczyste arkusze tematyczne ułożone jeden na drugim.',
    how:'Utwórz warstwy, ustaw kolory i typy linii, a potem dodawaj wymiary zgodnie z normami rysunku.',
    task:'Rozdziel kontur i osie na osobne warstwy.',
    question:'Po co stosuje się warstwy?',choices:['Do organizacji elementów rysunku','Do zwiększania mocy komputera','Do zmiany skali monitora'],answer:'Do organizacji elementów rysunku'),
  Lesson(id:'cfr1',course:'cad_freecad',title:'FreeCAD: szkic i więzy',
    theory:'FreeCAD jest otwartym parametrycznym programem CAD. Środowisko Sketcher pozwala tworzyć szkice sterowane wymiarami i więzami.',
    analogy:'Parametry są jak przepisy: zmieniasz wymiar, a model aktualizuje się zgodnie z historią.',
    how:'Utwórz Body, szkic na płaszczyźnie, geometrię i więzy. Następnie użyj Pad lub Pocket.',
    task:'Zrób szkic koła o średnicy 20 mm.',
    question:'Jak nazywa się środowisko do tworzenia szkiców w FreeCAD?',choices:['Sketcher','Slicer','Timeline'],answer:'Sketcher'),
  Lesson(id:'cfr2',course:'cad_freecad',title:'FreeCAD: Pad, Pocket i eksport',
    theory:'Pad dodaje materiał przez wyciągnięcie profilu, a Pocket usuwa materiał. Model można eksportować do formatów wymiany, np. STEP, albo do siatki STL.',
    analogy:'Pad dokłada plastelinę, Pocket wycina z niej materiał.',
    how:'Zbuduj bryłę, wykonaj otwór, sprawdź jednostki i wybierz format eksportu zgodny z dalszym użyciem.',
    task:'Utwórz płytkę z otworem i wyeksportuj ją do STEP.',
    question:'Który format lepiej zachowuje bryły CAD do dalszej edycji?',choices:['STEP','JPG','MP4'],answer:'STEP'),
];

class AppStore extends ChangeNotifier {
  SharedPreferences? prefs;
  final Set<String> completed = {};
  bool dark = false;
  bool english = false;
  String cadChoice = 'Fusion 360';
  String languageChoice = 'C++';
  int xp = 0;
  Future<void> load() async {
    prefs = await SharedPreferences.getInstance();
    completed.addAll(prefs?.getStringList('completed') ?? []);
    dark = prefs?.getBool('dark') ?? false;
    english = prefs?.getBool('english') ?? false;
    xp = prefs?.getInt('xp') ?? 0;
    cadChoice = prefs?.getString('cadChoice') ?? 'Fusion 360';
    languageChoice = prefs?.getString('languageChoice') ?? 'C++';
  }
  Future<void> finish(Lesson l) async {
    if (completed.add(l.id)) {
      xp += l.xp;
      await prefs?.setStringList('completed', completed.toList());
      await prefs?.setInt('xp', xp);
      notifyListeners();
    }
  }
  Future<void> toggleTheme(bool v) async { dark=v; await prefs?.setBool('dark',v); notifyListeners(); }
  Future<void> toggleLanguage(bool v) async { english=v; await prefs?.setBool('english',v); notifyListeners(); }
  Future<void> setCad(String v) async { cadChoice=v; await prefs?.setString('cadChoice',v); notifyListeners(); }
  Future<void> setLanguageChoice(String v) async { languageChoice=v; await prefs?.setString('languageChoice',v); notifyListeners(); }
  int get level => 1 + (xp ~/ 100);
  int get xpInLevel => xp % 100;
  double get overall => lessons.isEmpty ? 0 : completed.length / lessons.length;
  bool isUnlocked(String course) {
    if (course == 'mechanics_diag') return lessons.where((l)=>l.course=='mechanics').every((l)=>completed.contains(l.id));
    if (course == 'electromech' || course == 'arduino') return lessons.where((l)=>l.course=='electronics').every((l)=>completed.contains(l.id));
    return true;
  }
  double progress(String course) {
    final ls = lessons.where((l)=>l.course==course).toList();
    if (ls.isEmpty) return 0;
    return ls.where((l)=>completed.contains(l.id)).length / ls.length;
  }
}

class TechnikAI extends StatelessWidget {
  final AppStore store;
  const TechnikAI({super.key, required this.store});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: store,
    builder: (_,__) => MaterialApp(
      debugShowCheckedModeBanner:false,
      title:'TECHNIK AI',
      themeMode: store.dark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(colorSchemeSeed: const Color(0xFF286F9C), useMaterial3:true, brightness:Brightness.light),
      darkTheme: ThemeData(colorSchemeSeed: const Color(0xFF63B6D8), useMaterial3:true, brightness:Brightness.dark),
      home: MainShell(store:store),
    ),
  );
}

class MainShell extends StatefulWidget {
  final AppStore store;
  const MainShell({super.key,required this.store});
  @override State<MainShell> createState()=>_MainShellState();
}
class _MainShellState extends State<MainShell> {
  int index=0;
  @override Widget build(BuildContext context) {
    final store=widget.store;
    final pages=[
      LearnPage(store:store),
      ProgressPage(store:store),
      WorkshopPage(store:store),
      ProfilePage(store:store),
    ];
    return Scaffold(
      body:SafeArea(child:pages[index]),
      bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),destinations:const[
        NavigationDestination(icon:Icon(Icons.menu_book_outlined),selectedIcon:Icon(Icons.menu_book),label:'Nauka'),
        NavigationDestination(icon:Icon(Icons.insights_outlined),selectedIcon:Icon(Icons.insights),label:'Postępy'),
        NavigationDestination(icon:Icon(Icons.precision_manufacturing_outlined),selectedIcon:Icon(Icons.precision_manufacturing),label:'Pracownia'),
        NavigationDestination(icon:Icon(Icons.person_outline),selectedIcon:Icon(Icons.person),label:'Profil'),
      ]),
    );
  }
}

class LearnPage extends StatelessWidget {
  final AppStore store;
  const LearnPage({super.key,required this.store});
  @override Widget build(BuildContext context) {
    final isEn=store.english;
    return CustomScrollView(slivers:[
      SliverPadding(padding:const EdgeInsets.fromLTRB(18,18,18,8),sliver:SliverToBoxAdapter(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text('TECHNIK AI',style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.w900,letterSpacing:1)),
        const SizedBox(height:4),
        Text(isEn?'Learn technology by understanding and doing.':'Ucz się techniki przez zrozumienie i praktykę.'),
        const SizedBox(height:16),
        LevelCard(store:store),
        const SizedBox(height:20),
        Text(isEn?'Learning paths':'Ścieżki nauki',style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold)),
        const SizedBox(height:4),
        Text(isEn?'Complete foundations to unlock practical specializations.':'Ukończ podstawy, aby odblokować specjalizacje praktyczne.',style:Theme.of(context).textTheme.bodySmall),
      ]))),
      SliverPadding(padding:const EdgeInsets.fromLTRB(16,4,16,20),sliver:SliverList(delegate:SliverChildBuilderDelegate((context,i){
        final c=courses[i]; final unlocked=store.isUnlocked(c.id); final p=store.progress(c.id);
        return Card(margin:const EdgeInsets.only(bottom:10),clipBehavior:Clip.antiAlias,child:InkWell(onTap:()=>unlocked?Navigator.push(context,MaterialPageRoute(builder:(_)=>CoursePage(store:store,course:c))):_locked(context,c.id),child:Padding(padding:const EdgeInsets.all(14),child:Row(children:[
          Container(width:52,height:52,decoration:BoxDecoration(color:c.color.withOpacity(.13),borderRadius:BorderRadius.circular(15)),child:Center(child:Text(c.icon,style:const TextStyle(fontSize:27)))),
          const SizedBox(width:13),
          Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
            Text(c.title,style:const TextStyle(fontWeight:FontWeight.bold)),
            Text(c.subtitle,style:Theme.of(context).textTheme.bodySmall),
            const SizedBox(height:8),
            ClipRRect(borderRadius:BorderRadius.circular(9),child:LinearProgressIndicator(value:p,minHeight:6)),
            const SizedBox(height:3),
            Text('${(p*100).round()}% • ${lessons.where((l)=>l.course==c.id&&store.completed.contains(l.id)).length}/${lessons.where((l)=>l.course==c.id).length} lekcji',style:Theme.of(context).textTheme.labelSmall),
            if(!unlocked) Padding(padding:const EdgeInsets.only(top:5),child:Text(c.id=='mechanics_diag'?'Odblokuj po podstawach mechaniki':'Odblokuj po ukończeniu podstaw elektroniki',style:TextStyle(color:Theme.of(context).colorScheme.tertiary,fontSize:11,fontWeight:FontWeight.w600))),
          ])),
          Icon(unlocked?Icons.chevron_right:Icons.lock_outline,color:unlocked?null:Colors.grey),
        ]))));
      },childCount:courses.length))),
    ]);
  }
  void _locked(BuildContext context,String id) {
    final msg=id=='mechanics_diag'?'Ukończ wszystkie lekcje kursu Mechanika – podstawy.':'Ukończ wszystkie lekcje kursu Elektronika, aby odblokować tę ścieżkę.';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(msg)));
  }
}

class LevelCard extends StatelessWidget {
  final AppStore store;
  const LevelCard({super.key,required this.store});
  @override Widget build(BuildContext context)=>Card(color:Theme.of(context).colorScheme.primaryContainer,child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[const Icon(Icons.military_tech),const SizedBox(width:8),Text('Poziom ${store.level}',style:const TextStyle(fontWeight:FontWeight.bold,fontSize:18)),const Spacer(),Text('${store.xp} XP',style:const TextStyle(fontWeight:FontWeight.bold))]),
    const SizedBox(height:10),
    ClipRRect(borderRadius:BorderRadius.circular(8),child:LinearProgressIndicator(value:store.xpInLevel/100,minHeight:9)),
    const SizedBox(height:5),
    Text('${store.xpInLevel}/100 XP do następnego poziomu',style:Theme.of(context).textTheme.bodySmall),
  ])));
}

class CoursePage extends StatelessWidget {
  final AppStore store; final Course course;
  const CoursePage({super.key,required this.store,required this.course});
  @override Widget build(BuildContext context) {
    final ls=lessons.where((l)=>l.course==course.id).toList();
    return Scaffold(appBar:AppBar(title:Text(course.title)),body:ListView(padding:const EdgeInsets.all(16),children:[
      Card(color:course.color.withOpacity(.12),child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text(course.subtitle,style:Theme.of(context).textTheme.titleMedium),
        const SizedBox(height:8),
        Text('${ls.where((l)=>store.completed.contains(l.id)).length} z ${ls.length} lekcji ukończonych'),
        const SizedBox(height:8),
        LinearProgressIndicator(value:store.progress(course.id)),
        ]))),
      if(course.id.startsWith('cad_')) ...[
        const SizedBox(height:8),
        Text('Program: ${course.title.replaceFirst('CAD: ','')}',style:Theme.of(context).textTheme.bodyMedium),
      ],
      const SizedBox(height:10),
      ...List.generate(ls.length,(i){
        final l=ls[i]; final done=store.completed.contains(l.id);
        return Card(child:ListTile(leading:CircleAvatar(child:done?const Icon(Icons.check):Text('${i+1}')),title:Text(l.title),subtitle:Text('${l.xp} XP • teoria + przykład + zadanie'),trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>LessonPage(store:store,lesson:l)))));
      }),
    ]));
  }
}

class LessonPage extends StatefulWidget {
  final AppStore store; final Lesson lesson;
  const LessonPage({super.key,required this.store,required this.lesson});
  @override State<LessonPage> createState()=>_LessonPageState();
}
class _LessonPageState extends State<LessonPage> {
  int? selected;
  bool submitted=false;
  @override Widget build(BuildContext context) {
    final l=widget.lesson; final store=widget.store;
    final correct=selected!=null&&l.choices[selected!]==l.answer;
    return Scaffold(appBar:AppBar(title:Text(l.title)),body:ListView(padding:const EdgeInsets.all(16),children:[
      _section(context,'1. Teoria po ludzku',l.theory,Icons.menu_book),
      _section(context,'2. Przykład z życia',l.analogy,Icons.lightbulb_outline),
      _section(context,'3. Jak to działa?',l.how,Icons.settings_suggest),
      if(l.formula.isNotEmpty)_section(context,'4. Wzór',l.formula,Icons.functions),
      if(l.example.isNotEmpty)_section(context,'Przykład obliczenia',l.example,Icons.calculate),
      _section(context,'Zadanie praktyczne',l.task,Icons.build),
      Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text('Sprawdź się',style:Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight:FontWeight.bold)),
        const SizedBox(height:8),Text(l.question),
        const SizedBox(height:8),
        ...List.generate(l.choices.length,(i)=>RadioListTile<int>(contentPadding:EdgeInsets.zero,value:i,groupValue:selected,onChanged:submitted?null:(v)=>setState(()=>selected=v),title:Text(l.choices[i]))),
        if(submitted) Padding(padding:const EdgeInsets.only(top:8),child:Text(correct?'Dobrze! Odpowiedź poprawna. +${l.xp} XP':'Jeszcze nie. Poprawna odpowiedź: ${l.answer}',style:TextStyle(fontWeight:FontWeight.bold,color:correct?Colors.green:Theme.of(context).colorScheme.error))),
        const SizedBox(height:8),
        SizedBox(width:double.infinity,child:FilledButton(onPressed:selected==null?null:()async{
          if(!submitted){setState(()=>submitted=true);if(correct){await store.finish(l);}}
          else if(correct){Navigator.pop(context);}else{setState(() { selected = null; submitted = false; });}
        },child:Text(submitted?(correct?'Zakończ lekcję':'Spróbuj ponownie'):'Sprawdź odpowiedź'))),
      ]))),
      const SizedBox(height:18),
    ]));
  }
  Widget _section(BuildContext context,String title,String body,IconData icon)=>Card(margin:const EdgeInsets.only(bottom:12),child:Padding(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Row(children:[Icon(icon,color:Theme.of(context).colorScheme.primary),const SizedBox(width:8),Expanded(child:Text(title,style:const TextStyle(fontWeight:FontWeight.bold,fontSize:16)))]),
    const SizedBox(height:9),Text(body,style:const TextStyle(height:1.45)),
  ])));
}

class ProgressPage extends StatelessWidget {
  final AppStore store;
  const ProgressPage({super.key,required this.store});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
    Text('Twoje postępy',style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.bold)),
    const SizedBox(height:12),
    LevelCard(store:store),
    const SizedBox(height:16),
    Text('Opanowane umiejętności',style:Theme.of(context).textTheme.titleLarge),
    const SizedBox(height:8),
    ...courses.where((c)=>lessons.any((l)=>l.course==c.id)).map((c){
      final ls=lessons.where((l)=>l.course==c.id).toList();final done=ls.where((l)=>store.completed.contains(l.id)).length;
      return Card(child:Padding(padding:const EdgeInsets.all(13),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Row(children:[Text(c.icon),const SizedBox(width:8),Expanded(child:Text(c.title,style:const TextStyle(fontWeight:FontWeight.w600))),Text('$done/${ls.length}')]),
        const SizedBox(height:8),LinearProgressIndicator(value:done/ls.length),
      ])));
    }),
    const SizedBox(height:16),
    Text('Ostatnio ukończone',style:Theme.of(context).textTheme.titleLarge),
    ...lessons.where((l)=>store.completed.contains(l.id)).toList().reversed.take(8).map((l)=>ListTile(leading:const Icon(Icons.check_circle,color:Colors.green),title:Text(l.title),subtitle:Text('+${l.xp} XP'))),
    if(store.completed.isEmpty)const Padding(padding:EdgeInsets.all(16),child:Text('Ukończ pierwszą lekcję, a tutaj pojawią się Twoje umiejętności i historia.')),
  ]);
}

class WorkshopPage extends StatelessWidget {
  final AppStore store;
  const WorkshopPage({super.key,required this.store});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
    Text('Pracownia',style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.bold)),
    const Text('Ćwicz bez ryzyka uszkodzenia prawdziwych podzespołów.'),
    const SizedBox(height:14),
    Card(child:ListTile(leading:const CircleAvatar(child:Text('⚡')),title:const Text('Symulator obwodu LED'),subtitle:const Text('Dobierz elementy i zbuduj obwód z bloczków.'),trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const CircuitSimulationPage())))),
    Card(child:ListTile(leading:const CircleAvatar(child:Text('⚙️')),title:const Text('Symulator przekładni'),subtitle:const Text('Zmieniaj liczbę zębów i obserwuj przełożenie.'),trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const GearSimulationPage())))),
    Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.code)),title:const Text('Wybierz język programowania'),subtitle:Text('Aktualnie: ${store.languageChoice}'),onTap:()=>showDialog(context:context,builder:(ctx)=>SimpleDialog(title:const Text('Język'),children:['C','C++','Python','JavaScript'].map((v)=>SimpleDialogOption(onPressed:(){store.setLanguageChoice(v);Navigator.pop(ctx);},child:Text(v))).toList())))),
    Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.view_in_ar)),title:const Text('Wybierz program CAD'),subtitle:Text('Aktualnie: ${store.cadChoice}'),onTap:()=>showDialog(context:context,builder:(ctx)=>SimpleDialog(title:const Text('Program CAD'),children:['Tinkercad','Fusion 360','Onshape','Inventor','AutoCAD','FreeCAD'].map((v)=>SimpleDialogOption(onPressed:(){store.setCad(v);Navigator.pop(ctx);},child:Text(v))).toList())))),
  ]);
}

class CircuitSimulationPage extends StatefulWidget {
  const CircuitSimulationPage({super.key});
  @override State<CircuitSimulationPage> createState()=>_CircuitSimulationPageState();
}
class _CircuitSimulationPageState extends State<CircuitSimulationPage>{
  bool source=false,resistor=false,led=false,wired=false;
  @override Widget build(BuildContext context){
    final ready=source&&resistor&&led&&wired;
    return Scaffold(appBar:AppBar(title:const Text('Symulator obwodu LED')),body:ListView(padding:const EdgeInsets.all(18),children:[
      const Text('Zadanie: zbuduj prosty obwód szeregowy. Zaznacz elementy, które dodajesz do układu, a następnie połącz je przewodami.'),
      const SizedBox(height:16),
      Card(child:Padding(padding:const EdgeInsets.all(16),child:Column(children:[
        Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[
          _component('Zasilanie',Icons.battery_charging_full,source),
          _component('Rezystor',Icons.horizontal_rule,resistor),
          _component('LED',Icons.light_mode,led),
        ]),
        const SizedBox(height:16),
        Container(height:110,width:double.infinity,decoration:BoxDecoration(border:Border.all(color:Theme.of(context).colorScheme.outline),borderRadius:BorderRadius.circular(14)),child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
          Icon(Icons.lightbulb,size:50,color:ready?Colors.amber:Colors.grey),
          Text(ready?'LED świeci – obwód zamknięty':'Obwód nie jest jeszcze kompletny'),
        ]))),
      ]))),
      const SizedBox(height:12),
      _check('Dodaj źródło niskiego napięcia',source,(v)=>setState(()=>source=v)),
      _check('Dodaj rezystor ograniczający prąd',resistor,(v)=>setState(()=>resistor=v)),
      _check('Dodaj LED z poprawną polaryzacją',led,(v)=>setState(()=>led=v)),
      _check('Połącz elementy w zamknięty obwód',wired,(v)=>setState(()=>wired=v)),
      if(ready)const Card(color:Color(0x2232A852),child:Padding(padding:EdgeInsets.all(14),child:Text('Sukces! W prawdziwym układzie sprawdź jeszcze napięcie LED, dobór rezystora i limity prądowe.'))),
      OutlinedButton(onPressed:() => setState(() { source=false; resistor=false; led=false; wired=false; }),child:const Text('Zresetuj symulację')),
    ]));
  }
  Widget _component(String label,IconData icon,bool active)=>Column(children:[Icon(icon,size:30,color:active?Colors.green:null),Text(label,style:const TextStyle(fontSize:12))]);
  Widget _check(String title,bool value,ValueChanged<bool> onChanged)=>CheckboxListTile(value:value,onChanged:(v)=>onChanged(v??false),title:Text(title),contentPadding:EdgeInsets.zero);
}

class GearSimulationPage extends StatefulWidget {
  const GearSimulationPage({super.key});
  @override State<GearSimulationPage> createState()=>_GearSimulationPageState();
}
class _GearSimulationPageState extends State<GearSimulationPage>{
  double z1=20,z2=60,n1=900;
  @override Widget build(BuildContext context){
    final ratio=z2/z1;final n2=n1/ratio;
    return Scaffold(appBar:AppBar(title:const Text('Symulator przekładni')),body:ListView(padding:const EdgeInsets.all(18),children:[
      const Text('Ustaw liczbę zębów kół i prędkość wejściową. Dla idealnej przekładni pomijamy straty.'),
      const SizedBox(height:18),
      _slider('Zęby koła napędzającego',z1,10,80,(v)=>setState(()=>z1=v)),
      _slider('Zęby koła napędzanego',z2,10,120,(v)=>setState(()=>z2=v)),
      _slider('Obroty wejściowe (obr/min)',n1,100,3000,(v)=>setState(()=>n1=v)),
      Card(color:Theme.of(context).colorScheme.primaryContainer,child:Padding(padding:const EdgeInsets.all(18),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
        Text('Przełożenie i = ${ratio.toStringAsFixed(2)}',style:Theme.of(context).textTheme.titleLarge),
        const SizedBox(height:8),
        Text('Obroty wyjściowe ≈ ${n2.toStringAsFixed(0)} obr/min'),
        Text('W idealnym przybliżeniu moment wyjściowy rośnie około ${ratio.toStringAsFixed(2)} razy.'),
        const SizedBox(height:8),
        const Text('W praktyce uwzględnij sprawność, luzy, wytrzymałość zębów i kierunek obrotu.'),
      ]))),
    ]));
  }
  Widget _slider(String title,double value,double min,double max,ValueChanged<double> onChanged)=>Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
    Text('$title: ${value.round()}'),Slider(value:value,min:min,max:max,divisions:(max-min).round(),onChanged:onChanged),
  ]);
}

class ProfilePage extends StatelessWidget {
  final AppStore store;
  const ProfilePage({super.key,required this.store});
  @override Widget build(BuildContext context)=>ListView(padding:const EdgeInsets.all(18),children:[
    Text('Profil i ustawienia',style:Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight:FontWeight.bold)),
    const SizedBox(height:14),
    Card(child:ListTile(leading:const CircleAvatar(child:Icon(Icons.account_circle)),title:const Text('Logowanie przez Google'),subtitle:const Text('Zaloguj się i połącz konto'),trailing:const Icon(Icons.chevron_right),onTap:()=>Navigator.push(context,MaterialPageRoute(builder:(_)=>const GoogleLoginPage())))),
    Card(child:SwitchListTile(value:store.dark,onChanged:store.toggleTheme,title:const Text('Ciemny motyw'),secondary:const Icon(Icons.dark_mode))),
    Card(child:SwitchListTile(value:store.english,onChanged:store.toggleLanguage,title:const Text('English UI (częściowo)'),secondary:const Icon(Icons.language))),
    Card(child:ListTile(leading:const Icon(Icons.help_outline),title:const Text('Pomoc'),subtitle:const Text('Jak korzystać z kursów i symulacji'),onTap:()=>showAboutDialog(context:context,applicationName:'TECHNIK AI',applicationVersion:'0.2.0',children:[const Text('Ucz się od podstaw, wykonuj zadania i zdobywaj XP. Zablokowane ścieżki odblokowują się po ukończeniu wymaganych podstaw.')] ))),
    Card(child:ListTile(leading:const Icon(Icons.info_outline),title:const Text('O aplikacji'),subtitle:const Text('Wersja testowa 0.2.0 • postępy zapisywane lokalnie'))),
    const SizedBox(height:12),
    const Text('Uwaga: treści są materiałem edukacyjnym. Prace przy instalacjach sieciowych, maszynach i układach dużej mocy wymagają właściwych uprawnień, zabezpieczeń i nadzoru.'),
  ]);
}


class GoogleLoginPage extends StatefulWidget {
  const GoogleLoginPage({super.key});
  @override State<GoogleLoginPage> createState()=>_GoogleLoginPageState();
}
class _GoogleLoginPageState extends State<GoogleLoginPage> {
  bool loading=false;
  String? message;
  User? user;

  Future<void> signIn() async {
    if (!FirebaseConfig.isConfigured) {
      setState(()=>message='Najpierw uzupełnij dane Firebase i Web Client ID w lib/firebase_config.dart. Instrukcja znajduje się w README.md.');
      return;
    }
    setState(() { loading=true; message=null; });
    try {
      if (Firebase.apps.isEmpty) { await Firebase.initializeApp(options:FirebaseOptions(
        apiKey:FirebaseConfig.apiKey,
        appId:FirebaseConfig.appId,
        messagingSenderId:FirebaseConfig.messagingSenderId,
        projectId:FirebaseConfig.projectId,
      )); }
      final google=GoogleSignIn(scopes:const ['email'],serverClientId:FirebaseConfig.webClientId);
      final account=await google.signIn();
      if(account==null){setState(()=>loading=false);return;}
      final auth=await account.authentication;
      final credential=GoogleAuthProvider.credential(
        accessToken:auth.accessToken,
        idToken:auth.idToken,
      );
      final result=await FirebaseAuth.instance.signInWithCredential(credential);
      setState(() { user=result.user; loading=false; message='Zalogowano pomyślnie.'; });
    } catch(e) {
      setState(() { loading=false; message='Logowanie nie powiodło się: $e'; });
    }
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      setState(() { user=null; message='Wylogowano.'; });
    } catch(e) {
      setState(()=>message='Nie udało się wylogować: $e');
    }
  }

  @override Widget build(BuildContext context)=>Scaffold(
    appBar:AppBar(title:const Text('Konto Google')),
    body:Center(child:SingleChildScrollView(padding:const EdgeInsets.all(22),child:Column(mainAxisSize:MainAxisSize.min,children:[
      CircleAvatar(radius:38,child:Icon(user==null?Icons.account_circle:Icons.verified_user,size:42)),
      const SizedBox(height:14),
      Text(user?.displayName??'Zaloguj się do TECHNIK AI',style:Theme.of(context).textTheme.titleLarge,textAlign:TextAlign.center),
      if(user!=null)Text(user?.email??'',style:Theme.of(context).textTheme.bodyMedium),
      const SizedBox(height:20),
      if(user==null)SizedBox(width:double.infinity,child:FilledButton.icon(
        onPressed:loading?null:signIn,
        icon:loading?const SizedBox(width:18,height:18,child:CircularProgressIndicator(strokeWidth:2)):const Icon(Icons.login),
        label:Text(loading?'Logowanie...':'Kontynuuj z Google'),
      )) else SizedBox(width:double.infinity,child:OutlinedButton.icon(onPressed:signOut,icon:const Icon(Icons.logout),label:const Text('Wyloguj'))),
      if(message!=null)Padding(padding:const EdgeInsets.only(top:16),child:Text(message!,textAlign:TextAlign.center,style:TextStyle(color:Theme.of(context).colorScheme.secondary))),
      const SizedBox(height:16),
      const Text('Logowanie wymaga własnej konfiguracji Firebase i OAuth. Nie wpisuj tutaj hasła Google – logowanie odbywa się w oficjalnym oknie Google.',textAlign:TextAlign.center),
    ]))),
  );
}
