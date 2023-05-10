import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shoe_stores/views/widgets/rating_item.dart';
import 'package:shoe_stores/views/widgets/review_chip.dart';

import '../../constants/color.dart';
import '../../models/product.dart';
import '../../providers/reviews.dart';
import '../../resources/assets_manager.dart';
import '../../resources/font_manager.dart';
import '../../resources/styles_manager.dart';

Padding reviewTab({
  required Product product,
  required Size size,
  required Reviews reviewData,
  required String currentReviewTag,
  required List<String> reviewTags,
  required Function changeReviewTag,
}) {
  return Padding(
    padding: const EdgeInsets.only(top: 15.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Review & Ratings:',
          style: getMediumStyle(
            color: accentColor,
            fontSize: FontSize.s16,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(
                      product.rating.toString(),
                      style: getBoldStyle(
                        color: accentColor,
                        fontSize: FontSize.s50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '/ 5.0',
                      style: getRegularStyle(
                        color: greyFontColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                RatingBar(
                  initialRating: product.rating,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemSize: 20,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: Image.asset(AssetManager.fullStar),
                    half: Image.asset(AssetManager.halfStar),
                    empty: Image.asset(AssetManager.emptyStar),
                  ),
                  itemPadding: const EdgeInsets.only(right: 1.0),
                  onRatingUpdate: (double value) {},
                ),
                const SizedBox(height: 30),
                Text(
                  '${product.reviews.length}k Reviews',
                  style: getRegularStyle(
                      color: greyFontColor, fontSize: FontSize.s16),
                )
              ],
            ),
            const SizedBox(width: 10),
            Column(
              children: const [
                RatingItem(
                  index: '5',
                  figure: '1.5k',
                  progressValue: 0.8,
                ),
                RatingItem(
                  index: '4',
                  figure: '710',
                  progressValue: 0.4,
                ),
                RatingItem(
                  index: '3',
                  figure: '140',
                  progressValue: 0.3,
                ),
                RatingItem(
                  index: '2',
                  figure: '100',
                  progressValue: 0.2,
                ),
                RatingItem(
                  index: '1',
                  figure: '120',
                  progressValue: 0.1,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        Text(
          'Review with images & videos',
          style: getMediumStyle(
            color: accentColor,
            fontSize: FontSize.s16,
          ),
        ),
        SizedBox(
          height: 90,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.horizontal,
            itemCount: product.otherImgs.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(3, 8.0, 8.0, 8.0),
              child: Container(
                height: 20,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: otherImgsBg,
                ),
                child: Image.asset(
                  product.otherImgs[index],
                  // fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        const Divider(
          color: storeColor,
          thickness: 0.4,
        ),
        const SizedBox(height: 30),
        Text(
          'Top Reviews:',
          style: getMediumStyle(
            color: accentColor,
            fontSize: FontSize.s16,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Showing 3 of ${product.reviews.length}k reviews',
              style: getRegularStyle(
                color: greyFontColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: boxBg,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DropdownButton(
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: greyFontColor,
                ),
                underline: Container(),
                value: currentReviewTag,
                items: reviewTags
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(
                          value,
                          style: getRegularStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) => changeReviewTag(value),
              ),
            )
          ],
        ),
        SizedBox(
          height: size.height / 1.6,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 15),
            itemCount: product.reviews.length,
            itemBuilder: (context, index) {
              var item = reviewData.findById(product.reviews[index]);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: boxBg,
                            backgroundImage: AssetImage(item.imgUrl),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            item.username,
                            style: getMediumStyle(
                              color: Colors.black,
                              fontSize: FontSize.s14,
                            ),
                          )
                        ],
                      ),

                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Image.asset(
                                AssetManager.fullStar,
                                width: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                item.rating.toString(),
                                style: getBoldStyle(
                                  color: Colors.black,
                                  fontSize: FontSize.s16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () => {},
                                child: const Icon(
                                  Icons.more_horiz,
                                  color: greyFontColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  //
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reviewChip(text: 'Positive condition'),
                      reviewChip(text: 'Nice and soft'),
                      reviewChip(text: 'Smooth and new'),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    item.review,
                    style: getRegularStyle(
                      color: Colors.black,
                      fontSize: FontSize.s14,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => {},
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Icon(
                              Icons.thumb_up,
                              color: primaryColor,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Helpful ?',
                              style: getMediumStyle(
                                  color: primaryColor, fontSize: FontSize.s14),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Yesterday',
                        style: getRegularStyle(
                          color: greyFontColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  const Divider(
                    color: storeColor,
                    thickness: 0.4,
                  ),
                  const SizedBox(height: 30),
                ],
              );
            },
          ),
        )
      ],
    ),
  );
}
