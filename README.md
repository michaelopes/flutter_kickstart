![Logo](https://github.com/michaelopes/flutter_kickstart/assets/10121156/fa2245cc-90ed-4c89-88a4-414355eb793e)
# Flutter Kickstart

O projeto Flutter Kickstart surgiu para facilitar o dia a dia do desenvolvedor, trazendo uma série de funcionalidades uteis para a rotina de desenvolvimento, mas também, ajudando a começar um novo projeto, já que embarca diversas soluções para criação de novos projetos. O projeto também visa facilitar o entendimento de quem está começando com o Flutter facilitando alguns processos de desenvolvimento. 
O Flutter Kickstart utiliza de recursos/packages já existentes no mercado como o GoRouter para o gerenciamento de rotas, porém, há uma camada acima para contemplar como nós gostaríamos que as rotas fossem gerenciadas, contudo, também há funcionalidades próprias desenvolvidas exclusivas para o package como o sistema reativo de gerência de estados,assim como o sistema de temas, que será explicado à frente.

A arquitetura proposta para o projeto é a MVVM, a qual se encaixou melhor no modelo agil de denvolvimento proposto pelo projeto. 




## Autores
- [@michaelopes](https://github.com/michaelopes)


## Projeto com exemplos

 - [Clique aqui para visualisar](https://github.com/michaelopes/flutter_kickstart/tree/develop/example)

Nesse link vai encontrar as funcionalidades aplicadas na prática.
## Iniciar um APP

```dart
void main() async {
  //É obrigatório a chamada desse método antes do runApp. 
  //Esse método é responsável pela iniciação do package 
  await Fk.init(
    //Diretório para pasta de traduções
    i18nDirectory: "assets/i18n/",
    //Traduções disponívels
    availableLanguages: ["pt_BR"],
    //Tradução padrão do app
    defaultLocale: const Locale("pt", "BR"),
    //Intermediador de requests HTTP (OPCIONAL)
    //Será exemplificado à frente 
    httpDriverMiddleware: AppHttpMiddleware(),
    //Intermediador de navegação de view (OPCIONAL).
    //Pode ser utilizado por exemplo para chegar se o usuário está 
    //com o login válido no app será exemplificado à frente 
    moduleMiddleware: AppModuleMiddleware(),
    //Parser de respostas HTTP (OPCIONAL).
    //Com esse parser é possivel customizar erros ou respostas para 
    //cada faixa de códigos HTTP ex: 200, 400, 500, etc..
    httpDriverResponseParser: AppHttpResponseParser(),
    baseUrl: "https://www.thecocktaildb.com/api/json",
  );

  runApp(
    FkApp(
      appTitle: "Flutter Kickstart",
      //Registos de módulos (VIEWS) do app
      modules: () => AppModules().modules,
      //Registos de injeção de depêndencias no app
      injections: AppInjections().get,
      //Register do gerenciador global de erros
      globalFailureHandler: AppGlobalError(),
      //Register do FkTheme no app
      theme: AppTheme().theme,
    ),
  );
}
```


## Sistema de tradução (i18n)
Caso deseje trabalhar com traduções dentro do Flutter KickStart é bem simples.

Basta criar uma pasta de onde estará os arquivos de tradução com a extenção .json. 
Exemplo para tradução pt_BR será criado um arquivo no nosso exemplo, **pt_BR.json** dentro da pasta **assets/i18n** 
no root do projeto lembrado que essa pasta deverá ser referênciada no **pubspec.yaml** do projeto como abaixo:

```YAML
flutter:
  assets:
    - assets/i18n/
```
Após feito essa configuração basta criar o conteúdo do arquivo json como no exemplo abaixo, lembrado que não há 
limite de encadeamento de chaves de tradução.

```json
{
  "pages": {
    "drink": {
      "title": "Bebidas",
      "search_label": "Buscar por drinks",
      "search_placeholder": "Ex: margarita, beer, vodka...",
      "empty_search_message": "Realize uma busca de drink. Ex: margarita, beer, vodka..",
      "not_found_search_message": "Nenhum resultado foi encotrado com o termo buscado. Por favor, tente uma busca diferente,"
    },
    "drink_detail": {
      "ingredients": "Ingredientes",
      "instructions": "Instruções"
    }
  }
}
```

Utilizando uma tradução em um FkView ou FkWidget ambas implementações terão um atributo herdado chamado **tr** 
a qual será utilizado como no exemplo abaixo.

```dart
//Exemplo para tradução dentro do pages: { "drink": { "title": "Bebidas" } }
//Que convertido para o sistema de tratução ficará como abaixo:
final textoTraducao = tr.pages.drink.title();
```
Lembre-se de sempre adicionar **()** no final da chamada da tratução feito isso o texto "Bebidas" será 
adicionado a variável textoTraducao, contudo pode ser adicionado diretamente ao widget de texto como no exemplo:

```dart
Text(tr.pages.drink.not_found_search_message())
```
Note que cada nó separado por ponto representa um nó no arquivo .json.
## Intermediador de requests HTTP
O intermediado de requests http será utilizado com o intuido de interceptar erros, requisições e respostas enviadas 
em chamadas HTTPs do app. Segue um exemplo abaixo:

```dart
class AppHttpMiddleware extends FkHttpDriverMiddleware {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    //Tratar as requisições de apis aqui
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    //Tratar as respostas de apis aqui
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //Tratar os erros de apis aqui
    handler.next(err);
  }
}
```

Os requests do Flutter Kickstart são uma implementação do pacote DIO.
## Intermediador de navegação de Views
O intemediador de navegação é utilizado para aplicação de regras de navegação, no exemplo abaixo foi adicionado regras de navegação para 
idenficar se há um usuário logado, caso não haja um usuário logado o mesmo será direcionado para View de login.

Ao criar um intemediador de módulo será obrigatório a adição de um reactive (Reativo) 
a qual será exemplificado à frente. Este reactivo será o responsável por gerenciar o estado da aplicação.

```dart 
final class AppModuleMiddleware extends FkModuleMiddleware<GlobalReactive> {
  AppModuleMiddleware() : super(reactive: GlobalReactive()) {
    _initialAppChecks();
  }

  Future<void> _initialAppChecks() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    reactive.isLogged = sharedPreferences.getBool("LOGIN_KEY") ?? false;
    await Future.delayed(const Duration(milliseconds: 2000));
    reactive.initialized = true;
  }

  @override
  FutureOr<String?> onViewRedirect(BuildContext context, GoRouterState state) {
    final isGoingToInit = state.location == AppModules.splash;
    final isGoingToLogin = state.location == AppModules.login;

    if (!reactive.initialized && !isGoingToInit) {
      return AppModules.splash;
    } else if (reactive.initialized && !reactive.isLogged && !isGoingToLogin) {
      return AppModules.login;
    } else if ((reactive.isLogged && isGoingToLogin) ||
        (reactive.isLogged && reactive.initialized && isGoingToInit)) {
      return AppModules.typography;
    } else {
      //Aqui não será executado nada e a navegação segue seu curso normal.
      return null;
    }
  }
}
```
## Parser de respostas HTTP
O parser de respostas HTTP é um recurso que pode ser utilizado para realizar tratamentos de respostas HTTP 
por faixa de StatusCode pode ser muito util para resoluções de erros e casts de respostas não padronizadas 
dentro de um app utilização no exemplo abaixo.

```dart
final class AppHttpResponseParser extends FkBaseHttpDriverResponseParser {
  @override
  FkHttpDriverResponse range200(FkHttpDriverResponse response) {
    //Tratar resposta da faixa 200 aqui
    return response;
  }

  @override
  FkHttpDriverResponse range400(FkHttpDriverResponse response) {
    //Tratar resposta da faixa 400 aqui
    return response;
  }

  @override
  FkHttpDriverResponse range500(FkHttpDriverResponse response) {
    //Tratar resposta da faixa 500 aqui
    return response;
  }
}
```
## Rotas/Modules
O Flutter Kickstart usa uma camada de implementação sobre o package GoRouter para o gerenciamento de rotas, 
contudo com uma implementação simples de um sistema dividido por módulos. No exemplo abaixo de como é feito a implementação:

```dart
class AppModules {
  static const splash = "/";
  static const login = "/login";
  static const typography = "/typography";
  static const useAssets = "/use-assets";
  static const useResponsive = "/use-responsive";
  static const validations = "/validations";

  static const drink = "/drink";
  static const drinkDetail = "/drink-detail";

  List<FkBaseModule> get modules {
    return [
      FkModule.singleView(
        path: splash,
        builder: (context, goRouterStat) => SplashView(),
        viewModelFactory: () => SplashViewModel(),
      ),
      FkModule.singleView(
        path: login,
        builder: (context, goRouterStat) => LoginView(),
        viewModelFactory: LoginViewModel.new,
      ),
      //A utilização desse recurso serve para criar sub navegações entre os módulos 
      //nesse exemplo é criado um wrapper para bottom navigador bar a qual a página 
      //inicial é a primeira pagina da lista de módulos
      FkModuleGroup(
        builder: (_, __, child) {
          return InitialNavigator(child: child);
        },
        modules: [
          FkModule.singleView(
            path: typography,
            builder: (context, goRouterStat) => TypographyView(),
            viewModelFactory: TypographyViewModel.new,
          ),
          FkModule.singleView(
            path: useAssets,
            builder: (context, goRouterStat) => UseAssetsView(),
            viewModelFactory: UseAssetsViewModel.new,
          ),
          FkModule.singleView(
            path: useResponsive,
            builder: (context, goRouterStat) => UseResponsiveView(),
            viewModelFactory: UseResponsiveViewModel.new,
          ),
          FkModule(
            views: [
              FkModuleView(
                path: drink,
                builder: (context, goRouterStat) => DrinkView(),
                viewModelFactory: DrinkViewModel.new,
              ),
              FkModuleView(
                path: drinkDetail,
                builder: (context, goRouterStat) => DrinkDetailView(),
                viewModelFactory: DrinkDetailViewModel.new,
              )
            ],
          ),
          FkModule.singleView(
            path: validations,
            builder: (context, goRouterStat) => ValidationsView(),
            viewModelFactory: ValidationsViewModel.new,
          ),
        ],
      )
    ];
  }
}
```

Para um exemplo completo veja o exemplo no nosso repositório.


## Injeção de depêndencias
O pacote comporta um sistema simples de injeção de depêndencias contudo que atende a maioria app do mercado. Assim 
como o atende 100% a proposta do desenvolvimento do Flutter Kickstart.

Exemplo de uso:
```dart
class AppInjections {
  void _services() {
    FkInject.I.add<IDrinkService>(() => DrinkService());
  }

  void _repositories() {
    FkInject.I.add<ITheCocktailDBRepo>(() => TheCocktailDBRepo());
  }

  List<void Function()> get() {
    return [
      _repositories,
      _services,
    ];
  }
}
```
## Gerenciador global de erros
Esse recurso é muito util para interceptar erros comum dentro de um app. Caso tenha uma erro que ocorra em mais de um 
lugar dentro do app o mesmo pode ser tratado de forma global para evitar duplicidade de códigos.

```dart
class AppGlobalError extends IGlobalFailureHandler {
  @override
  void onFailure(context, error, stackTrace) {
    //Tratar os erros aqui
    //Pode ser utilizado para enviar erros para o Crashlytics por exemplo.
  }
}
```
## (Tema do app) FkTheme
Trabalhar com tema dentro do Flutter Kickstart é bem simples, foi criada uma implementação de tema em cima do sistema de 
tema nativo flutter material, adicionando mais recursos para deixar mais flexível e mais simples de utilizar os recursos.

Exemplo da criação de um tema
```dart
class AppTheme {
  final _colorPalete = FkColorPalete(
    primary: FkColor(
      //Cor principal a qual será referenciada caso não informado a cor será a shade500
      target: (thiz) => thiz.shade400,
      shade50: const Color(0xFFFFF8ED),
      shade100: const Color(0xFFFFEFD5),
      shade200: const Color(0xFFFFDBA9),
      shade300: const Color(0xFFFEC173),
      shade400: const Color(0xFFfc9631),
      shade500: const Color(0xFFFA7E15),
      shade600: const Color(0xFFEB630B),
      shade700: const Color(0xFFC34A0B),
      shade800: const Color(0xFF9b3b11),
      shade900: const Color(0xFF7d3211),
    ),
  );

  final _neutral1 = FkColor(
    target: (thiz) => thiz.shade100,
    shade50: const Color(0xFF000000),
    shade100: const Color(0xFF000000),
    shade200: const Color(0xFF1C1C1C),
    shade300: const Color(0xFF393939),
    shade400: const Color(0xFF555555),
    shade500: const Color(0xFF717171),
    shade600: const Color(0xFF8E8E8E),
    shade700: const Color(0xFFAAAAAA),
    shade800: const Color(0xFFC6C6C6),
    shade900: const Color(0xFFF3F3F3),
  );

  final _neutral2 = FkColor(
    target: (thiz) => thiz.shade100,
    shade50: const Color(0xFFFFFFFF),
    shade100: const Color(0xFFFFFFFF),
    shade200: const Color(0xFFF3F3F3),
    shade300: const Color(0xFFE3E3E3),
    shade400: const Color(0xFFC6C6C6),
    shade500: const Color(0xFFAAAAAA),
    shade600: const Color(0xFF8E8E8E),
    shade700: const Color(0xFF717171),
    shade800: const Color(0xFF555555),
    shade900: const Color(0xFF393939),
  );
  //Pasta para indicação dos assets 
  //Neste exemplo é a mesmas pastas
  //Tanto para o tema light quanto para o 
  //tema dark, contudo cada tema pode ter
  //icones independentes 
  final iconsDirectory = "assets/icons/";
  final imagesDirectory = "assets/images/";
  final animationsDirectory = "assets/animations/";

  final assetsSnippets = <FkAssetSnippetProvider>[
    //Adição de snippets de assets forma de utilização 
    //será exemplicada à frente
    AppAnimationsSnippets(),
    AppIconsSnippets(),
    AppImagesSnippets()
  ];

  FkTheme get light {
    return FkTheme.light(
      colorPalete: _colorPalete.copyWith(
        neutral: _neutral1,
        neutralVariant: _neutral2,
      ),
      iconsDirectory: iconsDirectory,
      imagesDirectory: imagesDirectory,
      animationsDirectory: animationsDirectory,
      background: (colorPalete) => colorPalete.neutralVariant,
      assetsSnippets: assetsSnippets,
      bottomNavigationBarTheme: (colorPalete) {
        return BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: colorPalete.primary,
          unselectedItemColor: colorPalete.neutral,
          backgroundColor: colorPalete.neutral.shade900,
        );
      },
      inputDecorationTheme: (colorPalete) {
        return InputDecorationTheme(
          labelStyle: TextStyle(
            color: colorPalete.neutral.onShade200,
          ),
          hintStyle: TextStyle(
            color: colorPalete.neutral.onShade400,
          ),
          fillColor: colorPalete.neutralVariant.shade200,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorPalete.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorPalete.neutralVariant.shade200,
            ),
          ),
        );
      },
      //Adição de braços do tema exemplificado a frente.
      themeBranchs: (owner) {
        return [
          AppVerticalCardThemeBranch(owner),
        ];
      },
    );
  }

  FkTheme get dark {
    return FkTheme.dark(
      colorPalete: _colorPalete.copyWith(
        neutral: _neutral2,
        neutralVariant: _neutral1,
      ),
      iconsDirectory: iconsDirectory,
      imagesDirectory: imagesDirectory,
      animationsDirectory: animationsDirectory,
      background: (colorPalete) => colorPalete.neutralVariant,
      assetsSnippets: assetsSnippets,
      bottomNavigationBarTheme: (colorPalete) {
        return BottomNavigationBarThemeData(
          selectedItemColor: colorPalete.primary,
          unselectedItemColor: colorPalete.neutral,
        );
      },
      inputDecorationTheme: (colorPalete) {
        return InputDecorationTheme(
          labelStyle: TextStyle(
            color: colorPalete.neutral.onShade200,
          ),
          hintStyle: TextStyle(
            color: colorPalete.neutral.onShade300,
          ),
          fillColor: colorPalete.neutralVariant.onShade200,
          filled: true,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: colorPalete.primary,
            ),
          ),
          enabledBorder: const OutlineInputBorder(),
        );
      },
      themeBranchs: (owner) {
        return [
          AppVerticalCardThemeBranch(owner),
        ];
      },
    );
  }

  FkThemeData get theme => FkThemeData(light: light, dark: dark);
}

```
## Braços de tema
Braços de tema (Theme Branch), esse recurso visa facilitar o compartilhamento global de um recurso de thema independente 
do tema principal que pode ser referênciado para um ou mais FkWidget ou FkView dentro do app.

Criação de um braço de tema

```dart
final class AppVerticalCardThemeBranch extends FkCustomThemeBranch {
  AppVerticalCardThemeBranch(super.ownerTheme);

  @override
  //Nome themeBranch
  String get name => "VerticalCard";

  @override
  FkTheme get theme => isLight ? _light : _dark;

  FkTheme get _dark {
    return ownerTheme.copyWith(
      defaultTextColor: (colorPalete) => ownerTheme.colorPalete.neutral,
      decoration: BoxDecoration(
        color: ownerTheme.colorPalete.neutral.onShade800,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  FkTheme get _light {
    return ownerTheme.copyWith(
      defaultTextColor: (colorPalete) => colorPalete.neutral,
      decoration: BoxDecoration(
        color: ownerTheme.colorPalete.neutralVariant.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
```

Utilização do do braço do tema em um FkWidget contudo a mesma lógica se aplica a FkView
```dart
class DrinkCard extends FkWidget {
  DrinkCard({
    super.key,
    required this.drinkName,
    required this.drinkThumbnail,
  });

  final String drinkName;
  final String drinkThumbnail;

  @override
  //Aqui é no "name" referênciado na criação do 
  //Braço de tema AppVerticalCardThemeBranch
  String get themeBranch => "VerticalCard";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: theme.decoration,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: theme.decoration!.borderRadius,
            child: Image.network(drinkThumbnail),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Text(
              drinkName,
              style: theme.typography.bodyExtra,
            ),
          )
        ],
      ),
    );
  }
}
```
## Reativo (Reactive)
O reactive será responsável pela gerência de estados de forma reativa dentro de uma FkView o reative é referênciado 
pelo o ViewModel responsável da view, contudo, um FkWidget pode referênciar diretamente a um reactive para sua gerência interna de estado.

Exemplo de criação de um Reativo
```dart
class _DrinkViewModelReactive extends FkReactive {
  @override
  //Setar um valor inicial é obrigatório caso o reativo não suporte valor nulo
  init() {
    drinks = FkList.of([]);
  }
  
  //Cria um get set do atributo reativo. 
  //E é só isso. Agora basta adicionar itens a lista 
  //que o valor será atualizado na view.
  set drinks(FkList<DrinkModel> value);
  FkList<DrinkModel> get drinks;
}
```
O reativo da suporte para todos os tipo dados primários do flutter
para collections deve-se utilizar os tipos de dados abaixo:

- **FkList** para List
- **RxMap** para Map
- **FkSet** para Set

Exemplo de um reativo em um FkWidget 
```dart
class ReactiveWidget extends FkWidget<GlobalReactive> {
  //reactive é OPCIONAL
  //utilizar somente quando deseja 
  //ter uma gerencia de estados facilidade dentro do widget
  ReactiveWidget({super.key}) : super(reactive: GlobalReactive());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: double.infinity,
      child: Column(
        children: [
          Text(reactive.counter.toString()),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              reactive.counter++;
            },
            child: const Text("Increment"),
          )
        ],
      ),
    );
  }
}
```
## ViewModel
O ViewModel será responsável pela gerência de estados de uma view, mas não somente isso ele visa atuar como um controlador 
da view onde ficará as variáves e metodos responsáveis pela logica da view, assim como o acesso aos serviços, a view a 
princípios ficará somente responsável para rendenização dos widgets.

```dart
class DrinkViewModel extends FkViewModel<_DrinkViewModelReactive> {
  DrinkViewModel() : super(reactive: _DrinkViewModelReactive());

  late final _drinkService = locator.get<IDrinkService>();

  late final _deboucer = FkDebouncer(
    duration: const Duration(milliseconds: 800),
    onValue: _onSearch,
  );

  final searchEditingController = TextEditingController();

  //Aqui seta um valor global para o módulo  drink 
  //Que pode ser recuperado por todas as views subsequentes do mesmo módulo atraves do 
  //método getModuleValue("SelectedDrink")
  //Contudo a tentativa de recuperação desse valor 
  //em ViewModel que não pertença ao mesmo módulo não retornará nada
  //NÃO RECOMENDAMOS A UTILIZAÇÃO DESSE RECURSO NO FLUTTER WEB
  set seletedDrink(DrinkModel value) => addModuleValue("SelectedDrink", value);

  @override
  Future<void> init() async {
    searchEditingController.addListener(() {
      var term = searchEditingController.text.trim();
      if (term.isEmpty) {
        reactive.drinks.clear();
      } else {
        _deboucer.value = term;
      }
    });
  }

  Future<void> _onSearch(String term) async {
    setLoading(true);
    try {
      reactive.drinks.clear();
      reactive.drinks.addAll(
        await _drinkService.searchDrinks(term),
      );
    } catch (e, s) {
      setError(e, s);
    } finally {
      setLoading(false);
    }
  }
}

class _DrinkViewModelReactive extends FkReactive {
  @override
  init() {
    drinks = FkList.of([]);
  }

  set drinks(FkList<DrinkModel> value);
  FkList<DrinkModel> get drinks;
}
```
## Criar uma View
Para criar uma view basta herdar da classe FkView<SeuViewModel> como no exemplo abaixo:

```dart
class DrinkView extends FkView<DrinkViewModel> {
  DrinkView({super.key});

  dynamic get pageTr => tr.pages.drink;

  Widget get _buildSearchInput {
    return TextFormField(
      controller: vm.searchEditingController,
      decoration: InputDecoration(
        labelText: pageTr.search_label(),
        hintText: pageTr.search_placeholder(),
      ),
    );
  }

  Widget get _buildEmptySearch {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: theme.icons.emptySearch(),
        ),
        SizedBox(
          width: 300,
          child: Text(
            pageTr.empty_search_message(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget get _buildNotFound {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 150,
          height: 150,
          child: theme.icons.notFound(),
        ),
        SizedBox(
          width: 300,
          child: Text(
            pageTr.not_found_search_message(),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget get _buildDrinkList {
    if (vm.loading()) {
      return const Center(child: CircularProgressIndicator());
    } else if (vm.searchEditingController.text.trim().isNotEmpty &&
        vm.reactive.drinks.isEmpty) {
      return _buildNotFound;
    } else if (vm.searchEditingController.text.trim().isEmpty &&
        vm.reactive.drinks.isEmpty) {
      return _buildEmptySearch;
    } else {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 34),
          child: FkResponsiveRow(
            mainAxisSpacing: FkResponsiveSpacing(
              xl: 16,
              lg: 16,
              md: 16,
            ),
            crossAxisSpacing: FkResponsiveSpacing(
              xl: 16,
              lg: 16,
              md: 16,
              sm: 16,
            ),
            children: vm.reactive.drinks
                .map(
                  (e) => FkResponsiveCol(
                    md: FkResponsiveSize.col4,
                    lg: FkResponsiveSize.col3,
                    xl: FkResponsiveSize.col2,
                    child: InkWell(
                      onTap: () {
                        vm.seletedDrink = e;
                        nav.push(AppModules.drinkDetail);
                      },
                      child: DrinkCard(
                        drinkName: e.name,
                        drinkThumbnail: e.thumbnail,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTr.title()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(top: 40),
        child: Column(
          children: [
            _buildSearchInput,
            const SizedBox(
              height: 16,
            ),
            ReactiveWidget(),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return Dialog(
                      child: ReactiveWidget(),
                    );
                  },
                );
              },
              child: const Text("Show dialog"),
            ),
            Expanded(
              child: _buildDrinkList,
            ),
          ],
        ),
      ),
    );
  }
}
```
## Criar um widget
Para criar uma view basta herdar da classe FkWidget como no exemplo abaixo:
```dart
class DrinkCard extends FkWidget {
  DrinkCard({
    super.key,
    required this.drinkName,
    required this.drinkThumbnail,
  });

  final String drinkName;
  final String drinkThumbnail;

  @override
  String get themeBranch => "VerticalCard";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: theme.decoration,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: theme.decoration!.borderRadius,
            child: Image.network(drinkThumbnail),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
            child: Text(
              drinkName,
              style: theme.typography.bodyExtra,
            ),
          )
        ],
      ),
    );
  }
}
```
## Utilização dos assets
Usar assets como icones, imagens e animações lottie dentro do flutter KickStart é muito simples. Basta colocar um 
icone dentro da pasta referenciada no tema exemplo **assets/icons** ex: **flutter.svg** que ele já está disponível 
para utilização como no exemplo abaixo:

```dart
class UseAssetsView extends FkView<UseAssetsViewModel> {
  UseAssetsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How to using assets"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /*
             Este é um exemplo de como usar recursos de imagens.
          **/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* 
                Dessa forma, basta colocar o arquivo de imagem dentro da pasta "assets/images" e chamar
                 diretamente o nome do arquivo e sua extensão separados pelo símbolo "$", como a seguir:
                 Se o arquivo tiver a extensão PNG, não é necessário informar a extensão após o símbolo "$".
              **/
              SizedBox(
                height: 50,
                width: 50,
                child: theme.images.flutterj$JPEG,
              ),
              const SizedBox(
                width: 24,
              ),
              /* Se a imagem é PNG, não é necessário informar a extensão. */
              SizedBox(
                height: 50,
                width: 50,
                child: theme.images.flutter,
              ),
              const SizedBox(
                width: 24,
              ),
              /* 
               Dessa forma, um snippet de código foi criado para auxiliar na busca por arquivos de imagem encontrados
              na pasta "assets_snippets/app_images". Em Dart, o snippet de código é uma referência para os arquivos adicionados
              dentro da pasta "assets/images". O nome da variável do trecho de código deve ter o mesmo nome do arquivo na pasta.
              Se for um arquivo PNG, não é necessário especificar a extensão. Caso a extensão seja necessária, ela deve ser escrita
              após o símbolo "$", como mostrado abaixo:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child:
                    theme.assets<AppImagesSnippets>().flutterj$JPEG.toImage(),
              ),
              const SizedBox(
                width: 24,
              ),
              /* Se a imagem for PNG, não é necessário informar a extensão. */
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppImagesSnippets>().flutter.toImage(),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          /*
             Este é um exemplo de como usar recursos de ícones:
          **/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* 
                Dessa forma, basta colocar o arquivo de ícone dentro da pasta "assets/icons" e
                chamar diretamente o nome do arquivo e sua extensão separados pelo símbolo "$", como a seguir:
                Se o arquivo tiver a extensão SVG, não é necessário informar a extensão após o símbolo "$". 
              **/
              SizedBox(height: 50, width: 50, child: theme.icons.flutter$PNG),
              const SizedBox(
                width: 24,
              ),
              /* Se o icone é SVG, não é necessário informar a extensão. */
              SizedBox(height: 50, width: 50, child: theme.icons.flutter),
              const SizedBox(
                width: 24,
              ),
              /* 
              Dessa forma, um snippet de código foi criado para auxiliar na busca por arquivos de ícones encontrados na pasta "assets_snippets/app_icons".
              Em Dart, o snippet de código é uma referência para os arquivos adicionados dentro da pasta "assets/icons". O nome da variável do trecho de
              código deve ter o mesmo nome do arquivo na pasta. Se for um arquivo SVG, não é necessário especificar a extensão. Caso a extensão seja necessária,
              ela deve ser escrita após o símbolo "$", como mostrado abaixo:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppIconsSnippets>().flutter$PNG.toIcon(),
              ),
              const SizedBox(
                width: 24,
              ),
              /* Se a imagem for SVG, não é necessário informar a extensão. */
              SizedBox(
                height: 50,
                width: 50,
                child: theme.assets<AppIconsSnippets>().flutter.toIcon(),
              ),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          /*
            Este é um exemplo de como usar recursos de animações SOMENTE LOTTIE EM FORMATO JSON:
          **/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* 
                Dessa forma, basta colocar o arquivo do ícone dentro da pasta "assets/animations" e chamar diretamente o nome do arquivo abaixo:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child: theme.animations.splash2,
              ),
              const SizedBox(
                width: 24,
              ),

              /* 
               Dessa forma, um snippet de código foi criado para auxiliar na busca por arquivos de animações encontrados
               na pasta "assets_snippets/app_animations". Em Dart, o snippet de código é uma referência para os arquivos adicionados dentro
               da pasta "assets/animations". O nome da variável do trecho de código deve ter o mesmo nome do arquivo na pasta. Por exemplo:
              **/
              SizedBox(
                height: 50,
                width: 50,
                child:
                    theme.assets<AppAnimationsSnippets>().splash.toAnimation(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

Os snippets utilizados no exemplo devem ser adicionado na na criação do tema. De uma olhada na sessão de criação do tema para ver um exemplo.
## Responsividade
O Flutter Kickstart suporta recursos básicos de responsividade baseado no Grid System do Bootstrap para web:

Exemplo:
```dart
class UseResponsiveView extends FkView<UseResponsiveViewModel> {
  UseResponsiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Resposive Grid System",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FkResponsiveLayout.builderByDevice(
              mobile: (_, __) {
                return const Center(
                  child: Text("MOBILE"),
                );
              },
              tablet: (_, __) {
                return const Center(
                  child: Text("TABLET"),
                );
              },
              desktop: (_, __) {
                return const Center(
                  child: Text("DESKTOP"),
                );
              },
            ),
            FkResponsiveRow(
              children: [
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    color: Colors.red,
                  ),
                ),
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    color: Colors.blue,
                  ),
                ),
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    color: Colors.green,
                  ),
                ),
                FkResponsiveCol(
                  sm: FkResponsiveSize.col12,
                  md: FkResponsiveSize.col6,
                  lg: FkResponsiveSize.col4,
                  xl: FkResponsiveSize.col3,
                  child: Container(
                    height: 80,
                    width: 400,
                    color: Colors.yellow,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
```
## Validações
O Flutter Kickstart suporta as principais validações utilizadas do Brasil. Caso tenho sugestões de validações adicione uma issue para 
que possamos incorpora-la no projeto.

Validações suportadas.
```dart
enum FkValidateTypes {
  required,
  min,
  max,
  maxAge,
  minAge,
  stringRange,
  dateGreaterThanNow,
  isEmail,
  isStrongPassword,
  isPasswordEquals,
  isEmailEquals,
  isCpf,
  isCnpj,
  isCpfOrCnpj,
  isAlfanumeric,
  isName,
  isBRPhone,
  isBRCellphone,
  isCardNumber,
  isCardExpiringDate,
  isCardCVV,
  isCep,
  isFacebookUrl,
  isInstagramUrl,
  isLinkedinUrl,
  isYoutubeUrl,
  isDribbbleUrl,
  isGithubUrl,
  isDate,
}
```

Exemplo de uma validação direta
```dart
final isValid = FkValidator.isCellphone("11999999999");
```

Exemplos de validações de Fields
```dart
class ValidationsView extends FkView<ValidationsViewModel> {
  ValidationsView({super.key});

  Widget get _buildRequiredField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Required validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.required),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildMinField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Min 2 validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.min, value: 2),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildMaxField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Max 6 validation field ",
        ),
        initialValue: "12345678",
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.max, value: 6),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildStringRangeField => TextFormField(
        decoration: const InputDecoration(
          labelText: "String Range 2,6 validation field ",
        ),
        initialValue: "12345678",
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.stringRange, value: "2,6"),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildEmailField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Email validation field ",
        ),
        onChanged: (value) {
          vm.email = value;
        },
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isEmail),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildConfirmEmailField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Confirm Email validation field ",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isEmailEquals, value: vm.email),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildStrongPasswordField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Strong Password validation field ",
        ),
        onChanged: (value) {
          vm.password = value;
        },
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isStrongPassword),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildConfirmPasswordField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Confirm Password validation field ",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(
              FkValidateTypes.isPasswordEquals,
              value: vm.password,
            ),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCpfFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CPF validation field",
        ),
        inputFormatters: [
          FkMasks.cpf,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCpf),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCnpjFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CNPJ validation field",
        ),
        inputFormatters: [
          FkMasks.cnpj,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCnpj),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildAlfanumericFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Alfanumeric validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isAlfanumeric),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildNameFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Name validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isName),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildBRPhoneFieldField => TextFormField(
        decoration: const InputDecoration(
          labelText: "BRPhone validation field",
        ),
        inputFormatters: [
          FkMasks.brPhone,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isBRPhone),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildBRCellphoneField => TextFormField(
        decoration: const InputDecoration(
          labelText: "BRCellphone validation field",
        ),
        inputFormatters: [
          FkMasks.brCellphone,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isBRCellphone),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCardNumberField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CardNumber validation field",
        ),
        inputFormatters: [
          FkMasks.cardNumber,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCardNumber),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCardExpiringDateField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CardExpiringDate validation field",
        ),
        inputFormatters: [
          FkMasks.cardExpiringDate,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCardExpiringDate),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCardCVVField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CardCVV validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCardCVV),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildCepField => TextFormField(
        decoration: const InputDecoration(
          labelText: "CEP validation field",
        ),
        inputFormatters: [
          FkMasks.cep,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isCep),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildFacebookUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "FacebookUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isFacebookUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildInstagramUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "InstagramUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isInstagramUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildLinkedinUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "LinkedinUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isLinkedinUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildYoutubeUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "YoutubeUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isYoutubeUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildDribbbleUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "DribbbleUrl validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isDribbbleUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildGithubUrlField => TextFormField(
        decoration: const InputDecoration(
          labelText: "DribbbleUrl, validation field",
        ),
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isGithubUrl),
          ];
          return FkFieldValidator(rules).validate(value);
        },
      );

  Widget get _buildDateField => TextFormField(
        decoration: const InputDecoration(
          labelText: "Date validation field",
        ),
        inputFormatters: [
          FkMasks.brDate,
        ],
        validator: (value) {
          var rules = [
            FkValidateRule(FkValidateTypes.isDate),
          ];
          var date = FkToolkit.brDatetime2IsoDatetime(value ?? "");
          return FkFieldValidator(rules).validate(date);
        },
      );

  /*
  isGithubUrl,
  isDate,
 */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Validations and Masks",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: vm.formKey,
            child: Column(
              children: [
                FkResponsiveRow(
                  crossAxisSpacing: FkResponsiveSpacing(
                    sm: 16,
                    lg: 16,
                    md: 16,
                    xl: 16,
                  ),
                  mainAxisSpacing: FkResponsiveSpacing(
                    sm: 16,
                    lg: 16,
                    md: 16,
                    xl: 16,
                  ),
                  children: [
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildRequiredField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildMinField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildMaxField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildStringRangeField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildEmailField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildConfirmEmailField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildStrongPasswordField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildConfirmPasswordField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCpfFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCnpjFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildAlfanumericFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildNameFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildBRPhoneFieldField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildBRCellphoneField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCardNumberField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCardExpiringDateField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCardCVVField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildCepField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildFacebookUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildInstagramUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildLinkedinUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildYoutubeUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildDribbbleUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildGithubUrlField,
                    ),
                    FkResponsiveCol(
                      sm: FkResponsiveSize.col12,
                      md: FkResponsiveSize.col6,
                      lg: FkResponsiveSize.col4,
                      xl: FkResponsiveSize.col3,
                      child: _buildDateField,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: vm.submit,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```
