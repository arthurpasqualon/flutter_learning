import 'package:flutter/material.dart';
import 'package:learn_app/model/characters_model.dart';
import 'package:learn_app/repositories/characters_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  ScrollController scrollController = ScrollController();
  late CharactersRepository charactersRepository;
  CharactersModel? characters;
  var offset = 0;
  var loading = false;

  void loadCharacters() async {
    if (loading) {
      return;
    } else {
      setState(() {
        loading = true;
      });
    }
    debugPrint("loadCharacters");
    if (characters == null) {
      characters = await charactersRepository.fetchCharacters(offset);
    } else {
      offset = offset + (characters?.data?.count ?? 0);
      var newCharacters = await charactersRepository.fetchCharacters(offset);
      characters?.data?.results?.addAll(newCharacters.data?.results ?? []);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    charactersRepository = CharactersRepository();
    loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: characters == null
          ? const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(child: LinearProgressIndicator()))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: characters?.data?.results?.length ?? 0,
                      controller: scrollController
                        ..addListener(() {
                          if (scrollController.position.pixels >
                              scrollController.position.maxScrollExtent * 0.8) {
                            loadCharacters();
                          }
                        }),
                      itemBuilder: (context, index) {
                        var character = characters?.data?.results?[index];

                        if (character == null) {
                          return null;
                        }
                        return ListTile(
                          leading: character.thumbnail != null
                              ? Image.network(
                                  "${character.thumbnail?.path}.${character.thumbnail?.extension}",
                                  height: 72,
                                  width: 72,
                                )
                              : null,
                          title: Text(character.name ?? ""),
                          subtitle: Text(character.description ?? ""),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      }),
                ),
                if (loading)
                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: Center(child: CircularProgressIndicator()),
                  )
              ],
            ),
    ));
  }
}
