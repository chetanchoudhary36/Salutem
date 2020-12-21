import 'package:flutter/material.dart';

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc(
      "Anonymously trace your contact with the help of encryption and Google/Apple COVID exposure API.");
  sliderModel.setTitle("Contact Tracing");
  sliderModel.setImageAssetPath("lib/assets/illustration.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc(
      "Help us keep the community safe from the spread of any contaigious disease.");
  sliderModel.setTitle("Co-ordinate");
  sliderModel.setImageAssetPath("lib/assets/illustration2.jpg");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "Contact Tacing is done as a community service rather than any data collection agenda. Your privacy is top Priority.");
  sliderModel.setTitle("Privacy");
  sliderModel.setImageAssetPath("lib/assets/illustration3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
