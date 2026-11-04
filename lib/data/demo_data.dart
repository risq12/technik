import 'package:flutter/material.dart';

import '../models/technical_category.dart';
import '../models/user_progress.dart';

const demoProgress = UserProgress();

const demoCategories = <TechnicalCategory>[
  TechnicalCategory(
    id: 'mechanics',
    namePl: 'Mechanika',
    nameEn: 'Mechanics',
    descriptionPl: 'Silniki, maszyny i materiały',
    descriptionEn: 'Engines, machines and materials',
    iconCodePoint: 0xe8b8,
    courseCount: 8,
    lessonCount: 64,
  ),
  TechnicalCategory(
    id: 'electronics',
    namePl: 'Elektronika',
    nameEn: 'Electronics',
    descriptionPl: 'Obwody, układy i mikrokontrolery',
    descriptionEn: 'Circuits, systems and microcontrollers',
    iconCodePoint: 0xe0e7,
    courseCount: 7,
    lessonCount: 58,
  ),
  TechnicalCategory(
    id: 'automation',
    namePl: 'Automatyka',
    nameEn: 'Automation',
    descriptionPl: 'PLC, czujniki i sterowanie',
    descriptionEn: 'PLCs, sensors and control',
    iconCodePoint: 0xe1b1,
    courseCount: 6,
    lessonCount: 42,
  ),
  TechnicalCategory(
    id: 'programming',
    namePl: 'Programowanie',
    nameEn: 'Programming',
    descriptionPl: 'Kod, Arduino i systemy',
    descriptionEn: 'Code, Arduino and systems',
    iconCodePoint: 0xe86f,
    courseCount: 9,
    lessonCount: 72,
  ),
  TechnicalCategory(
    id: 'cad',
    namePl: 'CAD i produkcja',
    nameEn: 'CAD and manufacturing',
    descriptionPl: 'Projektowanie, CNC i druk 3D',
    descriptionEn: 'Design, CNC and 3D printing',
    iconCodePoint: 0xe3b0,
    courseCount: 5,
    lessonCount: 38,
  ),
  TechnicalCategory(
    id: 'energy',
    namePl: 'Energetyka',
    nameEn: 'Energy',
    descriptionPl: 'Instalacje i źródła energii',
    descriptionEn: 'Installations and energy sources',
    iconCodePoint: 0xe8e5,
    courseCount: 4,
    lessonCount: 31,
  ),
];

const demoLessonTitle = 'Zasada działania silnika czterosuwowego';
const demoLessonSubtitle = 'Mechanika • Silniki spalinowe • 12 min';

IconData iconFromCodePoint(int codePoint) => IconData(
      codePoint,
      fontFamily: 'MaterialIcons',
    );
