enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  settingRoute("/settings");

  const NavigationRoute(this.name);
  final String name;
}
