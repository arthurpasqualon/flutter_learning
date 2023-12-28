import 'package:flutter/material.dart';
import 'package:learn_app/model/card_detail_model.dart';
import 'package:learn_app/pages/card_detail.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  var cardDetail = CardDetailModel(
      "1",
      "Arthur Neves Pasqualon",
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, quis aliquet nisl nunc eu nisl. Donec euismod, nisl eget aliquam ultricies, nunc nisl ultricies nunc, quis aliquet nisl nunc eu nisl.",
      "https://avatars.githubusercontent.com/u/20956158?v=4");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CardDetail(cardDetail: cardDetail);
              }));
            },
            child: Hero(
              tag: cardDetail.id,
              child: Card(
                shadowColor: Colors.grey,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Image.network(
                            cardDetail.imageUrl,
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                              child: Text(
                            cardDetail.title,
                            style: const TextStyle(fontSize: 24),
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        cardDetail.description,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Read More",
                                style: TextStyle(
                                    color: Colors.purple,
                                    decoration: TextDecoration.underline),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
