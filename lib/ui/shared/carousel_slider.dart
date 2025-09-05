
  import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/core/constant/app_image.dart';
import 'package:e_commerce/core/data/model/product_model.dart';
import 'package:flutter/widgets.dart';

CarouselSlider carouselslider(Product product) {
    return CarouselSlider(
                                          options: CarouselOptions(
                                            height: 300,
                              
                                            autoPlay: true,
                                            enlargeCenterPage: true,
                                            viewportFraction: 0.8,
                                          ),
                                          items:
                                              (product.images != null &&
                                                          product
                                                              .images!
                                                              .isNotEmpty
                                                      ? product.images!
                                                      : [
                                                          Appimages.logo,
                                                        ] 
                                                        )
                                                  .map((imageUrl) {
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      child: Image.network(
                                                        imageUrl,
                                                        width: 600,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    );
                                                  })
                                                  .toList(),
                                        );
  }