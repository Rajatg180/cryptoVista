import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage{
  // using shared Preferences to store the theme of app in local storage

  // set theme
  static Future<bool> saveTheme(String theme) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool result=await sharedPreferences.setString("theme", theme);
    return result;
  }

  // get theme
  static Future<String?> getTheme()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? currentTheme = sharedPreferences.getString("theme");
    return currentTheme;
  }

  //function for favourite store
  static Future<bool> addFavorite(String id) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // getting the already presented favorite list from local storage to store another favorite item id
    // if not present then we will set it to null
    List<String> favorite=sharedPreferences.getStringList("favorites") ?? [];

    favorite.add(id);

    //sorting the list in local storage
    return await sharedPreferences.setStringList("favorites",favorite);

  }

  //function for remove favourite
  static Future<bool> removeFavorite(String id) async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // getting the already presented favorite list from local storage to store another favorite item id
    // if not present then we will set it to null
    List<String> favorite=sharedPreferences.getStringList("favorites") ?? [];

    favorite.remove(id);

    return await sharedPreferences.setStringList("favorites",favorite);

  }

  // getting the list of Favorite
  static Future<List<String>> fetchFavorites() async{

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    return sharedPreferences.getStringList("favorites")??[];
  }

}