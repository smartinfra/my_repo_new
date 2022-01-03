class ListItem {
  String value;
  String name;

  ListItem(this.value, this.name);

  ListItem.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      value = jsonMap['value'].toString();
      name = jsonMap['name'].toString();
    } catch (e) {
      value = "";
      name = "";
      print(e);
    }
  }
}
