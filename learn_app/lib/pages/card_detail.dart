import 'package:flutter/material.dart';
import 'package:learn_app/model/card_detail_model.dart';

class CardDetail extends StatelessWidget {
  final CardDetailModel cardDetail;

  const CardDetail({super.key, required this.cardDetail});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: cardDetail.id,
      child: Scaffold(
        appBar: AppBar(
          title: Text(cardDetail.title),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(
                  cardDetail.imageUrl,
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  width: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: Text(
                    cardDetail.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
