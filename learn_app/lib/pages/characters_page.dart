import 'package:flutter/material.dart';
import 'package:learn_app/model/characters_model.dart';
import 'package:learn_app/repositories/characters_repository.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  late CharactersRepository charactersRepository;
  CharactersModel? characters;

  void loadCharacters() async {
    characters = await charactersRepository.fetchCharacters();
    setState(() {});
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
          : ListView.builder(
              shrinkWrap: true,
              itemCount: characters?.data?.results?.length ?? 0,
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
    ));
  }
}
