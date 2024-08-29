// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  ExploreCred exploreCred;
  List<Section> sections;

  Category({
    required this.exploreCred,
    required this.sections,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        exploreCred: ExploreCred.fromJson(json["explore_cred"]),
        sections: List<Section>.from(
            json["sections"].map((x) => Section.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "explore_cred": exploreCred.toJson(),
        "sections": List<dynamic>.from(sections.map((x) => x.toJson())),
      };
}

class ExploreCred {
  ExploreCredTemplateProperties templateProperties;

  ExploreCred({
    required this.templateProperties,
  });

  factory ExploreCred.fromJson(Map<String, dynamic> json) => ExploreCred(
        templateProperties:
            ExploreCredTemplateProperties.fromJson(json["template_properties"]),
      );

  Map<String, dynamic> toJson() => {
        "template_properties": templateProperties.toJson(),
      };
}

class ExploreCredTemplateProperties {
  PurpleHeader header;

  ExploreCredTemplateProperties({
    required this.header,
  });

  factory ExploreCredTemplateProperties.fromJson(Map<String, dynamic> json) =>
      ExploreCredTemplateProperties(
        header: PurpleHeader.fromJson(json["header"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
      };
}

class PurpleHeader {
  String identifier;
  String title;
  String subtitleTitle;

  PurpleHeader({
    required this.identifier,
    required this.title,
    required this.subtitleTitle,
  });

  factory PurpleHeader.fromJson(Map<String, dynamic> json) => PurpleHeader(
        identifier: json["identifier"],
        title: json["title"],
        subtitleTitle: json["subtitle_title"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "title": title,
        "subtitle_title": subtitleTitle,
      };
}

class Section {
  SectionTemplateProperties templateProperties;

  Section({
    required this.templateProperties,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
        templateProperties:
            SectionTemplateProperties.fromJson(json["template_properties"]),
      );

  Map<String, dynamic> toJson() => {
        "template_properties": templateProperties.toJson(),
      };
}

class SectionTemplateProperties {
  FluffyHeader header;
  List<Item> items;

  SectionTemplateProperties({
    required this.header,
    required this.items,
  });

  factory SectionTemplateProperties.fromJson(Map<String, dynamic> json) =>
      SectionTemplateProperties(
        header: FluffyHeader.fromJson(json["header"]),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class FluffyHeader {
  String identifier;
  String title;

  FluffyHeader({
    required this.identifier,
    required this.title,
  });

  factory FluffyHeader.fromJson(Map<String, dynamic> json) => FluffyHeader(
        identifier: json["identifier"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "title": title,
      };
}

class Item {
  String identifier;
  DisplayData displayData;

  Item({
    required this.identifier,
    required this.displayData,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        identifier: json["identifier"],
        displayData: DisplayData.fromJson(json["display_data"]),
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "display_data": displayData.toJson(),
      };
}

class DisplayData {
  String name;
  String description;
  String iconUrl;

  DisplayData({
    required this.name,
    required this.description,
    required this.iconUrl,
  });

  factory DisplayData.fromJson(Map<String, dynamic> json) => DisplayData(
        name: json["name"],
        description: json["description"],
        iconUrl: json["icon_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "icon_url": iconUrl,
      };
}
