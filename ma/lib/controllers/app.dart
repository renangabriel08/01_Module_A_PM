import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ma/widgets/toast.dart';

class App {
  static ValueNotifier page = ValueNotifier(0);

  static List diaries = [];
  static List favorites = [];
  static List map = [];
  static List ids = [];

  static String img = '';

  static Map? user;

  static getDiarios() async {
    try {
      final url = Uri.parse('http://10.91.248.17:4000/diary');
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        diaries = res;
        MyToast.get('Diarios buscados com sucesso!');
      } else {
        MyToast.get('Erro ${req.statusCode} ao buscar diarios.');
      }
    } catch (e) {
      MyToast.get('Erro ao buscar diarios.');
    }
  }

  static getDiario(String id) async {
    try {
      final url = Uri.parse('http://10.91.248.17:4000/diary?diary_id=$id');
      final req = await http.get(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        return res[0];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static getfavorites() async {
    try {
      final url = Uri.parse('http://10.91.248.17:4000/favorites');
      final req = await http.get(url);

      if (req.statusCode == 200) {
        favorites.clear();
        ids.clear();
        final res = jsonDecode(utf8.decode(req.bodyBytes));

        for (var r in res) {
          ids.add(r['diary_id']);
          favorites.add(await getDiario(r['diary_id']));
        }

        MyToast.get('Favoritos buscados com sucesso!');
      } else {
        MyToast.get('Erro ${req.statusCode} ao buscar favoritos.');
      }
    } catch (e) {
      MyToast.get('Erro ao buscar favoritos.');
    }
  }

  static logar(String email, String senha) async {
    try {
      final url = Uri.parse('http://10.91.248.17:4000/signin');
      final req = await http.post(
        url,
        body: {"email": email, "password": senha},
      );

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        user = res;
        await getfavorites();
        MyToast.get('Login realizado com sucesso!');
      } else {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        MyToast.get(res.toString());
      }
    } catch (e) {
      MyToast.get('Erro ao realizar login.');
    }
  }

  static addFavorite(String id) async {
    try {
      final url = Uri.parse('http://10.91.248.17:4000/favorites');
      final req = await http.post(
        url,
        body: {
          "diary_id": id,
          "favorite_datetime": DateFormat(
            "yyyy-MM-dd hh:mm:ss",
          ).format(DateTime.now()),
          "auth_token": "XHJ0VF1GJXHQMTP2PVWP6EXZS",
        },
      );

      if (req.statusCode == 201) {
        await getfavorites();
      } else {
        MyToast.get('Erro ${req.statusCode} ao adicionar aos favoritos.');
      }
    } catch (e) {
      MyToast.get('Erro ao adicionar aos favoritos.');
    }
  }

  static removeFavorite(String id) async {
    try {
      final url = Uri.parse('http://10.91.248.17:4000/favorites/$id');
      final req = await http.delete(url);

      if (req.statusCode == 200) {
        await getfavorites();
      } else {
        MyToast.get('Erro ${req.statusCode} ao remover dos favoritos.');
      }
    } catch (e) {
      MyToast.get('Erro ao remover dos favoritos.');
    }
  }
}
