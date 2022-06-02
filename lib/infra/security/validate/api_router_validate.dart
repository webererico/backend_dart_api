class ApiRouterValidate {
  final List<String> _routes = [];

  ApiRouterValidate add(String route) {
    _routes.add(route.replaceFirst('/', ''));
    return this;
  }

  bool isPublic(String route) => _routes.contains(route);
}
