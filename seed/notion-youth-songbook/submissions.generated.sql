SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'А ты не думай', 'Прощение', NULL, '[Куплет 1]
D Hm
А ты не думай, что тебе тяжело,
Em A
А ты не думай, что тебе лишь темно,
D Hm
А ты забудь, что на сердце печаль.
Em G A
Ты помни лишь о том:

[Припев]
D
// В жизни надо успеть //
Hm
// И на небо посмотреть, //
Em A
Другу улыбнуться, сказать “прости”.
D
// В жизни надо успеть //
Hm
// Хоть одну песню спеть, //
Em G A
Людям радость дать и о Боге рассказать.
D
И о Боге рассказать.

[Куплет 2]
D Hm
Вспомни: тебе надо любить,
Em A
Вспомни: и обиды все простить,
D Hm
Помни, что другому тяжело.
Em G A
Подставь ему своё плечо.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=1 | photo=notion-youth-songbook | notionPageId=b7e923e9-208c-423f-9f0c-ab265a5b8983 | notionChordPageId=adb7c20c-b77a-4da4-8491-706696cbd589 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b7e923e9208c423f9f0cab265a5b8983', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'А ты не думай'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=1%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Агнец Пасхальный', 'Пасхальные', NULL, '[Куплет 1]
Am Dm Am Dm
Над Голгофою тьма нависла, тучи солнце закрыли быстро,
C G F G
Вся стонет земля от смерти Царя.
Am Dm Am Dm
Содрогается от рыданий, ибо чувствует боль страданий,
C G F G
Кровь Божья течёт к ней со креста.
Dm Am F C Dm Am
Между небом и землей Агнец Божий умирает,
F Am F C Dm E
Он на древо вознесен, ад объятья раскрывает…

[Припев]
A E D A
Но смерть Его не в силах удержать,
D A Hm E
Рождён, чтоб побеждать, и принести спасенье!
A E D A
Он пришёл свободу пленным дать,
D A Hm E
Прощать и исцелять, и Свыше дать рожденье!

[Куплет 2]
Am Dm Am Dm
Он народом Своим отвержен, Он страданиям был подвержен,
C G F G
Но словно овца, безгласен был.
Am Dm Am Dm
се друзья Его разбежались, Его били, над Ним смеялись,
C G F G
Но Он до конца чашу испил…
Dm Am F C Dm Am
“Совершилось!” - Он сказал, в храме порвана завеса,
F Am F C Dm E
Исполняя Божий план, умер в муках и воскрес Он!

[Мост]
Он наш Агнец Пасхальный, заклан за нас, заклан за нас.
Претерпел Он страданья, Кровью нас спас, Кровью нас спас!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=2 | photo=notion-youth-songbook | notionPageId=7576a9df-f607-4039-936f-bd591ac41938 | notionChordPageId=b0522ea3-c67c-4e0d-a40e-917d56defe31 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7576a9dff6074039936fbd591ac41938', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Агнец Пасхальный'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=2%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ангелы в небе', 'Свадебные', NULL, '[Куплет 1]
Em H
Ангелы в небе Господа славят,
Am H Em E
Славу достойную Богу поют, Богу поют:
Am D G C
Вечная слава, вечная слава,
Am H Em
Вечная слава, слава Христу!
E
Слава Христу!

[Куплет 2]
Em H
Хочется с ангельским пением слиться
Am H Em E
В хоре искупленных спасенных Господом.
Am D G C
И сердце Господу, Богу единому,
Am H Em
Христу Спасителю славу поет.
E
Славу поет!

[Куплет 3]
Em H
Здесь, на земле людей, Церковь томится,
Am H Em E
К небу стремится, дух к Жениху влечёт.
Am D G C
О, гряди, Господи, видишь, невеста ждёт
Am H Em
Тебе Единому славу поёт.
E
Славу поет!

[Куплет 4]
Em H
Чудный прославленный, царственный Божий Сын,
Am H Em E
Дивный Христос Господь в небе нас ждёт.
Am D G C
И сердце Господу, Богу Единому,
Am H Em
Христу Спасителю славу поёт.
E
Славу поет!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=3 | photo=notion-youth-songbook | notionPageId=e83a746c-21f0-4488-8166-90a56a931022 | notionChordPageId=e6f8ae5a-f3dc-4e42-a89f-e3f5198e90ae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e83a746c21f04488816690a56a931022', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ангелы в небе'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=3%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Баллада о трёх сыновьях', 'Семья', NULL, '[Куплет 1]
Em Am D Em
В краю средь гор и цветущих долин
Em Am D Em
Текла река, исчезая вдали.
C D Hm C
Прекрасней не было страны,
Am D Em
Где рождались баллады и сны.
Em Am D Em
В дорогу звал глас таинственных гор.
Em Am D Em
Три сына там покидали свой дом.
C D Hm C
Один был горд, другой - упрям,
Am D Em
А третий был сердцем смирен.
Em Am D Em
Слова Отца были грусти полны:
Em Am D Em
"В любви моей вы росли, как цветы.
C D Hm C
Что ждет вас там, в чужих краях.
Am D Em
Да хранит вас молитва моя".
C D Em C D Em
И звучало в ответ эхо горных вершин
C D Hm C
"Сохраните богатство души
Am D Em
И любви нескончаемый свет".

[Куплет 2]
Em Am D Em
Прошли года, затерялись вдали.
Em Am D Em
В краю средь гор и цветущих долин
C D Hm C
Встречал отец своих детей
Am D Em
После долгих разлук и скорбей.
Em Am D Em
И первый сын возвратился домой:
Em Am D Em
"Гордись, отец, - я великий герой.
C D Hm C
Вся власть моя, и в этом суть
Am D Em
На крови я построил свой путь".
Em Am D Em
Второй принес золотые дары:
Em Am D Em
"Смотри, отец, я могу все миры
C D Hm C
Купить, продать и слезы всех
Am D Em
Превратить в серебро и успех."
C D Em C D Em
И звучало в ответ эхо горных вершин
C D Hm C
"Разменяли богатство души
Am D Em
Ради славы и блеска монет".

[Мост]
А третий сын на коленях стоял:
"Прости, отец, я великим не стал.
Смиренным был, врагов прощал"
А отец с теплотой отвечал:
"Душа твоя и добра и чиста.
И пусть богат ты и знатен не стал,
Но ты хранил любовь мою.
Я тебе свой престол отдаю!
И звучало в ответ эхо горных вершин
Кроток сердцем и духом смирен
Верный сын унаследовал трон.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=4 | photo=notion-youth-songbook | notionPageId=3d2948d7-632e-4578-86ef-c6a2868837c4 | notionChordPageId=e32e8382-3297-4dc6-a61f-b5957e61851b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3d2948d7632e457886efc6a2868837c4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Баллада о трёх сыновьях'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=4%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благо есть славить Господа', 'Семья', NULL, '[Куплет 1]
Благо есть славить Господа
И петь имени Твоему, Спаситель,
Возвещать утром милость Твою
И истину Твою везде.

[Припев]
Ты возвеселил душу мою,
Я Тебе, Господь, хвалу пою!
Дела Твои велики, мой Отец,
Ты мой Творец!

[Куплет 2]
Возвожу свои очи к горам,
Возношу свои руки к небу.
Я познал, что Господь есть Бог
И на земле и в небесах.

[Куплет 3]
Ты укажешь мне жизни путь,
Да не постыжусь, что к Тебе взываю,
На Тебя уповаю я,
Благослови, Господь, меня.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=5 | photo=notion-youth-songbook | notionPageId=a03f83e5-cf38-433d-b124-01a999feb4e8 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/a03f83e5cf38433db12401a999feb4e8 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благо есть славить Господа'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=5%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благодарные сердца', 'Благодарение', NULL, '[Куплет 1]
A F#m D E
Благодарные сердца, поспешите в дом Отца!
A F#m D E
Урожай свезли с полей до прихода зимних дней.
F#m D E C#
Бог - начало всех начал - нам все нужное послал.
D E E7
Поспешите в Божий дом вознести хвалы псалом!

[Припев]
A C# F#m C#m
Наш Господь опять придет, жатву с поля соберет,
D A D E
Все соблазны удалит, рай желанный возвратит.
A C# F#m C#m
Даст Он ангелам приказ: сжечь все плевелы огнем,
D A D E A
А пшеницу в тот же час отнести в небесный дом.

[Куплет 2]
A F#m D E
Мир весь - поле, что давно Богу плод принесть должно.
A F#m D E
Плевел и пшеница тут рядом издавна растут.
F#m D E C#
Сперва зелень, позже - плод, так идет из рода в род.
D E E7
Боже, молим об одном: сделай добрым нас зерном!

[Куплет 3]
A F#m D E
Ей, гряди, Господь, гряди! Церковь молит, Церковь ждет;
A F#m D E
Свой народ освободи от греха и от забот.
F#m D E C#
Обновленные душой вечно будем жить с Тобой.
D E E7
Боже, Боже, поспеши, в мире жатву соверши!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=6 | photo=notion-youth-songbook | notionPageId=8321e7f6-2cec-4848-8c04-5e1254def079 | notionChordPageId=c894bf77-0f2c-4bba-bc8c-3b35ac25a1cb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8321e7f62cec48488c045e1254def079', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благодарные сердца'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=6%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благословен тот дом', 'Семья', NULL, '[Куплет 1]
Hm Em F# Hm
Благословен тот дом, где в каждом чистом сердце
Hm Em F#
Слово святое Господа живет,
H Em A D
Нет власти тьмы, и страха смерти,
G Em F#
И Сам Господь в тот дом хозяином войдет.

[Припев]
Hm F# Hm
Благословен! Благословен!
Hm F# Hm
Блгословен тот дом.

[Куплет 2]
Hm Em F# Hm
Благословен тот дом, где в тихий час молитвы
Hm Em F#
Духом Святым Господь касается сердец,
H Em A D
Где радости счастья, любви в избытке,
G Em F#
И благодать излил небесный наш Отец.

[Куплет 3]
Hm Em F# Hm
Благословен тот дом, где старость уважают,
Hm Em F#
Где веру свято берегут из рода в род,
H Em A D
Славят Творца и Библию читают,
G Em F#
И возрастают в мудрости из года в год.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=7 | photo=notion-youth-songbook | notionPageId=600a0575-0dff-4805-ae68-4735de5f94e3 | notionChordPageId=1d55b8b7-5ada-42c9-8916-e8859b4c92f0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/600a05750dff4805ae684735de5f94e3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благословен тот дом'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=7%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благослови Господа, душа моя', 'Благодарение', NULL, '[Куплет 1]
D G D
Буду петь Господу всю жизнь мою.
A7 D A7
Буду петь Ему доколе я жив.
D G D
Да будет благоприятна песнь моя,
Em A D D7
Возвеселюсь, возрадуюсь о Господе.

[Припев]
G A7 F#m Hm
Благослови, душа моя, Господа!
Em A7 D D7
Благослови, душа моя, Господа!

[Куплет 2]
D G D
Буду петь Господу всю жизнь мою.
A7 D A7
Буду петь Ему доколе я жив.
D G D
Как высоко небо над землею
Em A D D7
Так велика, чудесна милость Господа.

[Куплет 3]
D G D
Буду славить Творца всем сердцем я,
A7 D A7
Благодарить Его каждый миг,
D G D
Как далеко восток от запада,
Em A D D7
Так удалил Он от нас наши грехи.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=8 | photo=notion-youth-songbook | notionPageId=8be04214-b121-45b3-8fab-27b76d4da3c5 | notionChordPageId=621d0c72-5f08-4881-b7d4-a052e3b5a250 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8be04214b12145b38fab27b76d4da3c5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благослови Господа, душа моя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=8%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог избрал нас', 'Спасение', NULL, '[Куплет 1]
Бог избрал нас из разных народов,
Дал нам имя Свое.
Бог избрал нас из разных племен и языков,
Но дал нам сердце одно!

[Припев]
Когда мы вместе – мы сильны!
Когда мы вместе – Господь среди нас!
Когда мы вместе – потоки Божьей любви
Льются с небес на нас.

[Куплет 2]
Мы есть Церковь – Мы есть Тело Христа,
Мы искуплены кровью Его!
Врата ада не одолеют нас,
Потому, что с нами Господь!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=9 | photo=notion-youth-songbook | notionPageId=53aa0387-82b2-4766-948b-9dc62c83227f | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/53aa038782b24766948b9dc62c83227f | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог избрал нас'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=9%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог мой, во мне Ты', 'Утешение и ободрение', NULL, '[Куплет 1]
G Am
Бог мой, во мне Ты,
C D G
Лишь Ты один наполнил жизнь мою.
G Am
Бог мой, со мной Ты,
C D G
Тебе навеки сердце отдаю.

[Припев]
Em C D
Ты во мне - я заново родился,
Em C D
Ты во мне - я счастье приобрёл,
Em C D
Ты ко мне, как солнца свет явился,
Em C D G
И в Тебе я жизни смысл нашёл.

[Куплет 2]
G Am
Радость, печали,
C D G
Порой бывает сердцу тяжело.
G Am
О счастье мечтали
C D G
И вот оно навеки к нам пришло.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=10 | photo=notion-youth-songbook | notionPageId=4681f5ad-a334-4151-8380-096cf70d345c | notionChordPageId=6c393284-7517-4c77-847a-bd996b81e7d7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4681f5ada33441518380096cf70d345c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог мой, во мне Ты'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=10%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог пришел и умер за меня', 'Пасхальные', NULL, '[Куплет 1]
Dm A# F C
Бог пришел и умер за меня, аминь, аминь
Dm A# F C
Победу одержал над силой зла, аминь, аминь
Dm A# F C
Распят был, но он воскрес, аминь, аминь
Dm A# F C
Сидящий на престоле Властелин, аминь, аминь

[Припев]
F Gm F A#
Слава Тебе Господь мой Всемогущий
F Gm F A#
Слава Тебе Великий Бог
F Gm F A#
Я пою Тебе всем сердцем Бог мой Всемогущий
A# C F
Слава Тебе мой Бог.

[Куплет 2]
Dm A# F C
Руки Господа покрыла Кровь, аминь, аминь
Dm A# F C
Но гвозди не могли держать его, аминь, аминь
Dm A# F C
И Любовь отца, для нас течет, аминь, аминь
Dm A# F C
Аллилуйя он опять Грядет, аминь, аминь

[Мост]
Ты вечный и Святой, Сущий вовек веков
Ты был и есть и вновь грядешь
Ты вечный и Святой, Сущий вовек веков
Ты был и есть и вновь грядешь', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=11 | photo=notion-youth-songbook | notionPageId=1fd3c678-3c1d-4219-b603-1ff73359baa5 | notionChordPageId=dcbbacaf-614e-42da-8855-a04a7f6e93a9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1fd3c6783c1d4219b6031ff73359baa5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог пришел и умер за меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=11%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог с нами в долине удачи', 'Спасение', NULL, '[Куплет 1]
Em
Бог с нами в долине удачи,
D
И близок в часы неудач.
C
Когда мы смеемся и плачем,
H7
Он с нами, Господь наш и врач.
Em
В глубокие топи уныния,
D
В ущелья, где смертная тень.
C
Спускается Он и доныне,
H7
Чтоб нам помогать каждый день.

[Припев]
Em Am
Скажем вместе: Богу слава! Богу слава!
H7 Em H7
Скажем вместе: Мы идем за Тобой.

[Куплет 2]
Em
Он с нами, когда наше знамя,
D
Которому имя любовь.
C
Торжественно реет над нами,
H7
Вобрав в себя образ Христов.
Em
Когда мы людей утешаем,
D
Слагая дела и слова.
C
Любовью своей подтверждаем,
H7
Что вера у нас не мертва.

[Куплет 3]
Em
Бог с нами когда мы по слову
D
В обыденной жизни живём
C
Когда по сердечному зову
H7
Во имя Иисуса идём
Em
Когда расширяем границы
D
Для новых людей Благодать
C
Есть смысл для Иисуса трудиться
H7
Есть смысл для Иисуса страдать

[Куплет 4]
Em
Бог с нами когда нас немного
D
Когда его имя несём
C
Ведь сила Великого Бога
H7
Сердца наполняет огнём
Em
Бог с нами Он в нашем собрании
D
И он нас в обиду не даст
C
Исполнятся наши желания
H7
В назначенный Господом час', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=12 | photo=notion-youth-songbook | notionPageId=569dac52-3c7e-45f5-b957-fbc45b8bc88b | notionChordPageId=9cb3dac6-12b9-4772-b093-19f8d1c9ee51 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/569dac523c7e45f5b957fbc45b8bc88b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог с нами в долине удачи'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=12%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Боже, Ты мой Бог', 'Божья любовь', NULL, '[Куплет 1]
Em C Am Hm
Боже, Ты мой Бог!
Em C Am D7
Тебя от ранней зари ищу я.
G7 C7 Am H7
Тебя жаждет душа моя.
Em Hm Em
Аллилуйя!

[Куплет 2]
Em C Am Hm
Я вспоминаю о Тебе.
Em C Am D7
Размышляю ночью о Тебе.
G7 C7 Am H7
Ты помощь моя.
Em Hm Em
Аллилуйя!

[Куплет 3]
Em C Am Hm
Милость Твоя лучше чем жизнь.
Em C Am D7
Благословлю Тебя в жизни моей.
G7 C7 Am H7
Уста мои восхваляют Тебя.
Em Hm Em
Аллилуйя!

[Куплет 4]
Em C Am Hm
Боже, Ты мой Бог!
Em C Am D7
Тебя от ранней зари ищу я.
G7 C7 Am H7
Тебя жаждет душа моя.
Em Hm Em
Аллилуйя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=13 | photo=notion-youth-songbook | notionPageId=baff265b-85b9-425e-bf2e-d3db75cbd481 | notionChordPageId=71772f51-511b-4035-b4e5-3bcf3dd2dd09 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/baff265b85b9425ebf2ed3db75cbd481', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Боже, Ты мой Бог'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=13%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Божья любовь', 'Божья любовь', NULL, '[Куплет 1]
Dm Gm
Скажи, ну что тебя сюда ведет?
C F
Ответь, ну что тебя сюда влечет?
A# Gm
И от чего твои глаза горят,
A7
Такой счастливый и открытый взгляд.

[Припев]
Dm Gm
Это любовь, Божья любовь,
C F
Она зальет все, заполнит все,
A# Gm
Только любовь, Божья любовь,
A7 Dm
Все в мире пройдет, кроме нее.

[Куплет 2]
Dm Gm
Я возвожу к Иисусу сердцем взгляд,
C F
И знаю: мой Господь мне очень рад.
A# Gm
В ответ с престола льется на меня,
A7
Вода живая, свет Его огня.

[Куплет 3]
Dm Gm
Скажи, откуда этот блеск в глазах?
C F
Ответь, ну что даёт нам Бог в сердца?
A# Gm
Он помогает в этом мире жить,
A7
Он дает силы верить и любить.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=14 | photo=notion-youth-songbook | notionPageId=d4d96011-4899-45a0-be4c-55ebf6bb14d9 | notionChordPageId=75d65a49-0948-4675-95e8-a786bcc4937f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d4d96011489945a0be4c55ebf6bb14d9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Божья любовь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=14%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Буду Бога хвалить', 'Спасение', NULL, '[Куплет 1]
A
Буду Бога хвалить доколе жив,
C#m
Буду Господу петь доколе есть.
Hm
Божьей милости я не заслужил,
E
А в ответ на любовь из сердца песнь.
A
На людей не надейся никогда
C#m
В самых сильных из них, спасенья нет.
Hm
Если есть у тебя сейчас нужда,
E
Прямо к Богу иди, он даст ответ.

[Припев]
F#m Hm
Как блажен, тот, кому помощник Бог
E A
У кого вся надежда на Него
F# Hm
Кто создать небеса и землю смог
E A
Не оставит своих ни одного!

[Куплет 2]
A
Справедливый и милосердный Царь
C#m
Будет царствовать вечно в род и род
Hm
Аллилуйя душа моя восклицай
E
Славь Царя своего, его народ.
A
Буду Бога хвалить доколе жив,
C#m
Буду Господу петь доколе есть.
Hm
Божьей милости я не заслужил,
E
А в ответ на любовь из сердца песнь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=15 | photo=notion-youth-songbook | notionPageId=42266a6a-3f58-46b3-a978-38f5d1e4f8be | notionChordPageId=f47930e4-c4af-4e12-900f-b9549c46048b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/42266a6a3f5846b3a97838f5d1e4f8be', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Буду Бога хвалить'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=15%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Будь благословен', 'Утешение и ободрение', NULL, '[Куплет 1]
A E F#m D
Будь благословен на земле изобилия,
A E D
Где течёт молоко и мёд, будь благословен.
A E F#m D
Будь благословен на земле иссохшей и пустой,
A E D
Когда мне тяжело в пути, будь благословен.

[Припев]
A E
За Твои благословенья
F#m D
Воздам хвалу,
A E
Если тьма меня стесняет,
F#m D
Всё равно скажу:
A E
Будь благословен, мой Господь,
F#m D
Будь благословен!
A E
Будь благословен, мой Господь,
F#m E D
Будь благословен великий Бог!

[Куплет 2]
A E F#m D
Будь благословен, когда всё хорошо вокруг,
A E D
Когда рядом есть близкий друг, будь благословен.
A E F#m D
Будь благословен на пути, где страдания,
A E D
Когда боль и испытания, будь благословен.

[Мост]
Лишь Ты имеешь власть
Всё дать и всё отнять.
Я выберу за всё
Тебя благословлять!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=16 | photo=notion-youth-songbook | notionPageId=c3e51ec0-6ec5-4e0b-bca2-d6073cefb8b4 | notionChordPageId=3f183d9c-b131-47d1-ad9d-8037658a4390 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c3e51ec06ec54e0bbca2d6073cefb8b4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Будь благословен'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=16%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Будь храброй, душа', 'Вера и упование', NULL, '[Куплет 1]
G D
Спокойно стой, прими покой:
Em C
Совершит все Господь.
G D
Все мысли Его выше наших путей,
Em C
Путь Его так велик!

[Припев]
Em D
Будь храброй, душа, и стой до конца,
G
Господь ‒ Он рядом, Господь ‒ Он рядом.
Em D
И надеждой крепись, до победы держись –
C D
Не подведет Он, не подведет Он!

[Куплет 2]
G D
Душа моя, славь Господа!
Em C
Силу в Нем ты найдешь.
G D
Не забывай верности Его,
Em C
Он проложит Свой путь!

[Мост]
Все звезды держишь Ты,
В Твоих руках весь мир,
Исполнишь все, что Ты обещал.
В победе я вновь поднимусь!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=17 | photo=notion-youth-songbook | notionPageId=7fe4ca5e-360b-4bd6-a14a-f3bb688882f7 | notionChordPageId=efb3acd5-4c31-4184-8ae8-1c0b4a04beb2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7fe4ca5e360b4bd6a14af3bb688882f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Будь храброй, душа'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=17%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В городе тихая осень', 'Прославление', NULL, '[Куплет 1]
F#m D E F#m
В городе тихая осень, первые дни октября.
F#m D E F#m
Клён как-то листья сбросил, и стала другой земля.
F#m D E F#m
Оделась она царицей всего на несколько дней,
F#m D E F#m
Но как просветлели лица у проходящих людей.

[Припев]
D E F#m A
Осень, красивую осень Бог подарил земле.
D E F#m
Осень, красивую осень я попросил себе.
D E A E F#m
Осень, красивую осень Бог подарил земле.
Hm C#m F#m
Осень, красивую осень я попросил себе.

[Мост]
Бог так одевает лилию, цветущую несколько дней,
Что Соломон великий меркнет при славе своей,
Но верных одел Бог лучше в праведной жизни своей,
Чтоб просветлели души рядом идущих людей.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=18 | photo=notion-youth-songbook | notionPageId=0dad6474-e94f-4fc2-ac5a-7f7769693401 | notionChordPageId=8a79ea7d-ec3c-45a1-b779-6ebe46af68b3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0dad6474e94f4fc2ac5a7f7769693401', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В городе тихая осень'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=18%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В жизни земной', 'Призыв к покаянию', NULL, '[Куплет 1]
Dm A# C Dm
В жизни земной всё приходит к концу,
Gm A Dm
И для всего назначено время.
A# C
Осенью ветер срывает листву,
Gm A Dm
И устилает озябшую землю.
Gm A Dm
Только однажды даётся нам жизнь,
A# C F
Ну, а затем начинается вечность.
Gm A Dm
Хочешь ли в вечности с Господом быть,
Gm A Dm
Ныне оставь роковую беспечность.

[Куплет 2]
Dm A# C Dm
Время летит, не прощая утрат,
Gm A Dm
Время диктует нам жёсткие сроки.
A# C
Выбери ныне блаженство иль ад,
Gm A Dm
Жизнь со Христом или гибель в пороках.
Gm A Dm
Может тебе одиноко сейчас,
A# C F
Пусто в душе, не уютно и душно,
Gm A Dm
Слышал ты призыв Христа и ни раз,
Gm A Dm
Но покаянье считаешь ненужным.

[Куплет 3]
Dm A# C Dm
Вот и теперь сам Спаситель зовёт,
Gm A Dm
Хочет вернуть Он заблудшего сына.
A# C
Ты изнемог и устал, Он поймёт,
Gm A Dm
Ласково, нежно с любовью обнимет.
Gm A Dm
Миром покроет любовью своей,
A# C F
Душу больную твою Он наполнит,
Gm A Dm
Только не медли, покайся скорей,
Gm A Dm
Жизнь повторять не придётся запомни.

[Мост]
Только однажды даётся нам жизнь,
Ну, а затем начинается вечность.
Хочешь ли в вечности с Господом быть,
Ныне оставь роковую беспечность.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=19 | photo=notion-youth-songbook | notionPageId=98bd3076-7070-4051-9253-1e2dd32426f1 | notionChordPageId=e723f2fd-e546-4df5-883a-ec6ff49347a0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/98bd30767070405192531e2dd32426f1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В жизни земной'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=19%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В мир греха', 'Спасение', NULL, '[Куплет 1]
Em Hm Em Hm
В мир греха, мерзости и зла
C D Em
С неба к нам любовь шла.
Em Hm Em Hm
Пыль дорог, боль усталых ног:
C D Em
По земле идет Бог.

[Припев]
Am Em
Он пришёл для тебя,
C D Em
Чтобы с Богом был ты и я.
Am Em
Он нашёл и привел
C D Em
Даже тех, кто в гибель шёл.
Am Em
Он нам дал идеал
C D Em
Той любви, что мир давно не знал.
Am Em
Он прощал и желал,
C D Em
Чтобы ты об этом узнал.

[Куплет 2]
Em Hm Em Hm
Жизнь людей, слёзы их детей.
C D Em
Сколько горестей в ней…
Em Hm Em Hm
“Только Бог нас избавить мог” –
C D Em
Вырывался их вздох.

[Куплет 3]
Em Hm Em Hm
Яркий луч средь нависших туч,
C D Em
Среди пенистых круч.
Em Hm Em Hm
С нами рос Иисус Христос,
C D Em
В мир спасение нёс.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=20 | photo=notion-youth-songbook | notionPageId=bcdfa534-ff65-429e-ba79-269919f4a603 | notionChordPageId=f3b64da8-fa68-4868-a30f-68e3adf88682 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bcdfa534ff65429eba79269919f4a603', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В мир греха'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=20%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В Палестине Царь родился в те далекие года', 'Рождественские', NULL, '[Куплет 1]
F Dm
В Палестине Царь родился в те далекие года,
A# Gm C
Бог на землю к нам явился и зажглась Его звезда,
F Dm
Пастухов, стада пасущих, свет великий осиял,
A# Gm C
И тогда, идя к пещере, каждый Бога прославлял.

[Припев]
F Dm
Гори звезда, всегда гори, И светом новым озари,
C F
И светом новым озари,
F A Dm
Все, кто блуждает в темноте,
Gm C F
Пусть весть услышат о Христе.

[Куплет 2]
F Dm
Мудрецы, звезду увидев, в Вифлеемский стан пошли,
A# Gm C
На колени пред Ним пали и подарки принесли,
F Dm
И теперь она сияет, Вифлеемская звезда,
A# Gm C
Скоро все о ней узнают и поверят во Христа.

[Куплет 3]
F Dm
Много звезд на небе светит, только светит всех сильней,
A# Gm C
Та, что время возвестила Рождества Царя Царей,
F Dm
И когда печаль на сердце, подними глаза туда,
A# Gm C
Где сияет вечным светом Вифлеемская звезда', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=21 | photo=notion-youth-songbook | notionPageId=27a9f73a-2e3a-448a-acda-8f5b7da5c5ee | notionChordPageId=8597f944-d10c-4992-928f-23dc0246a8ea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/27a9f73a2e3a448aacda8f5b7da5c5ee', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В Палестине Царь родился в те далекие года'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=21%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В Христе одном', 'Пасхальные', NULL, '[Куплет 1]
G D G A
В Христе одном надежда есть,
D G A D
Вся моя жизнь и сила в Нём.
G D G A
Он - Камень мой, скала и песнь,
D G A D
Надёжный спутник в страшный шторм.
G D A
Как высока любовь Его,
D G D A
Как мир глубок, как с Ним легко.
G D G A
Мой Утешитель – Всё во всём,
D G A D
Моя опора только в Нём.

[Куплет 2]
G D G A
В Христе одном, принявшем плоть,
D G A D
Открылся Всемогущий Бог.
G D G A
Но дар любви, что дал Господь,
D G A D
Отверг народ, избрав порок.
G D A
Он на кресте Себя отдал,
D G D A
В смиреньи гнев Отца принял.
G D G A
Мой грех на плечи возложил,
D G A D
Чтобы Его я смертью жил.

[Куплет 3]
G D G A
В земле, как все, Он мёртвым был,
D G A D
Объят был тьмою свет небес.
G D G A
Но в третий день Он победил,
D G A D
Из гроба мрачного воскрес!
G D A
Он Бог и победитель всех,
D G D A
Уже не правит больше грех.
G D G A
Навеки Он хозяин мой,
D G A D
Я куплен кровию святой.

[Куплет 4]
G D G A
Нет страха смерти, нет вины,
D G A D
Всё только силою Христа.
G D G A
От первых дней, до седины,
D G A D
До смерти в Нём моя судьба.
G D A
||: Нет никого и ничего,
D G D A
Что вырвет из руки Его.
G D G A
Он приведёт меня в Свой дом,
D G A D
Моя опора только в Нём. :||', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=22 | photo=notion-youth-songbook | notionPageId=5e3a733d-3c37-4297-888a-dbbbb4e61262 | notionChordPageId=8c753842-be45-4628-a9ec-3161c94f3eca | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5e3a733d3c374297888adbbbb4e61262', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В Христе одном'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=22%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В часы тревог, унынья и сомненья', 'Пасхальные', NULL, '[Куплет 1]
Gm D7 Gm
В часы тревог, унынья и сомненья,
F A# D7
Не видя света, света пред собой,
Gm Cm
Душа болит, терзается в волненьи,
Gm D7 Gm
Спешу, Господь, прийти к Тебе с мольбой!

[Припев]
Cm D7 Gm
Как счастлив я, что я Христа имею!
Cm F A# D7
Как счастлив я, что Он всегда со мной!
Gm Cm
Живу я Им, об этом не жалею,
Gm D7 Gm
Как счастлив я, что Он со мной, Друг мой!

[Куплет 2]
Gm D7 Gm
О образ дивный, кроткий и смиренный,
F A# D7
Христос Господь, живи во мне всегда,
Gm Cm
Чтоб в сердце был моем запечатленный,
Gm D7 Gm
Не дал упасть под тяжестью креста.

[Куплет 3]
Gm D7 Gm
К кому пойду я в горести сердечной,
F A# D7
С участьем кто протянет руку мне?
Gm Cm
Лишь Ты один с любовью бесконечной
Gm D7 Gm
Меня простил, меня привлек к Себе.

[Куплет 4]
Gm D7 Gm
Но мне порой так тяжело бывает,
F A# D7
И кажется, оставил Бог меня.
Gm Cm
Но вновь душа словам Твоим внимает:
Gm D7 Gm
“Я не оставлю, Я люблю тебя”.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=23 | photo=notion-youth-songbook | notionPageId=9679d4e0-6d39-4931-a4b2-83ebd31669f7 | notionChordPageId=9699cc71-2d60-4427-b73e-1f75244dd9d3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9679d4e06d394931a4b283ebd31669f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В часы тревог, унынья и сомненья'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=23%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Велики и чудны', 'Прославление', NULL, '[Куплет 1]
Em Am D Em
Велики и чудны дела Твои,
C D G H
Господи Боже Вседержитель.
Em Am D Em
Праведны и истинны пути Твои
C D Em
Царь Святый.

[Припев]
Am H7 Em C
Кто не убоится не прославит Тебя,
Am D G
Ибо Ты един свят.
Am H7 Em C Am
Все народы поклонятся
Hm Em
Пред Тобой, ибо Ты един свят.
G D Am Em C D G
Свят, свят, Ты един свят.
G D Am Em C D Em
Свят, свят, Ты един свят.

[Куплет 2]
Em Am D Em
Благости и милости твои на всех,
C D G H
Господи Боже Вседержитель.
Em Am D Em
Сила и величие Твоё во всём,
C D Em
Царь Святый.

[Куплет 3]
Em Am D Em
Честь Тебе, хвала каждый миг, Ииисус,
C D G H
Господи Боже Вседержитель.
Em Am D Em
Аллилуйя и осанна лишь Тебе,
C D Em
Царь Святый.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=24 | photo=notion-youth-songbook | notionPageId=03e7b7e1-9b25-415f-8096-8a24b71729f4 | notionChordPageId=83fda083-a002-4dcd-af25-341796f18a56 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/03e7b7e19b25415f80968a24b71729f4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Велики и чудны'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=24%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Величит душа моя Бога', 'Молитвенные', NULL, '[Куплет 1]
G
Величит душа моя Бога,
Em
Он – Царь и Владыка миров,
Am D
Когда на душе тревога,
C D
Спешу под Его покров.

[Припев]
G Em
Он правдой меня осеняет,
C D
Дает мне под крыльями тень,
G Em
От коварных путей охраняет,
C G
И душу мою сберегает
C D G
По милости каждый день.

[Куплет 2]
G
Ему аллилуйя, осанна,
Em
Он полон небесных щедрот,
Am D
Я в Нем нахожу непрестанно
C D
Отраду в минуты невзгод.

[Куплет 3]
G
И я каждый день направляю
Em
Молитвы в небесную синь,
Am D
И громко Его прославляю
C D
Сердечной хвалою. Аминь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=25 | photo=notion-youth-songbook | notionPageId=5d8e0053-b0cd-41e0-9d85-e38d00a0ad5c | notionChordPageId=24b8d158-9139-4216-9303-c36ce1b4ca3b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5d8e0053b0cd41e09d85e38d00a0ad5c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Величит душа моя Бога'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=25%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Верим мы', 'Пасхальные', NULL, '[Куплет 1]
C Csus
В час когда вокруг сомненье,
C Csus
Страх вокруг во тьме земля
Am F
Есть Единственное Спасение
C F
Верю я! Верю я!

[Припев]
C G
Верим мы, что Бог - Отец наш, верим в Господа Христа
Am F
Верим мы в Святого Духа, нам жизнь вечная дана
C G
Верим мы - Христа распяли, верим мы что Он воскрес
Am F
Верим мы настанет время, Наш Господь придет с небес, верим мы!

[Куплет 2]
C Csus
В этом сломленном поколении,
C Csus
Свет приносишь только Ты
Am F
Есть Надежда на спасенье
C F
Верим мы! Верим мы!

[Куплет 3]
C Csus
Пусть, будет больше наша вера
C Csus
В час сомнений и тревог
Am F
Ты несешь надежду с неба
C F
Верим мы! Верим мы!

[Мост]
Кто потерян был выход найдёт пусть в сердца людей ворвется любовь
Церковь громко скажет чтоб слышал Ты, верим мы! Верим мы!
Нас не одолеют ада врата сила Божья завесу разорвала
Не пройдет Его любовь никогда верим мы! Верим мы!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=26 | photo=notion-youth-songbook | notionPageId=4ebcd920-7b2d-4c4f-b6eb-027a123e92de | notionChordPageId=b2f0e304-20bc-4522-99d0-bc7cc073a44d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4ebcd9207b2d4c4fb6eb027a123e92de', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Верим мы'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=26%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Верую, Господи', 'Небо', NULL, '[Куплет 1]
Dm Gm A A7
Верую, Господи, истинно верую в Слово святое Твое.
Dm Gm C C7
Время отмерено каждому верному определенье свое.
F D D7
Все, что назначено, будет исполнено сильной рукою Твоей
Gm A A7
Божье провиденье не омрачайте, не убегайте скорбей.

[Припев]
Dm Gm C F
Небо, небо правду знает, небо верных принимает:
Dm Gm A
Стефан, Павел, Магдалина, Иоанн, Филипп, Мария,
Dm Gm C F
Тит, Лука, Андрей, Варнава - Имена, и с ними слава.
Dm Gm A
О, дай Бог свое услышать имя.

[Куплет 2]
Dm Gm A A7
Все, что построили, будет проверено посланным с неба огнем.
Dm Gm C C7
Бог так устроил все, будьте уверены, может быть, после поймем,
F D D7
Где было золото, сено и дерево, чистое серебро.
Gm A A7
Каждый увидит, насколько он верен был в том, что от Неба дано.

[Куплет 3]
Dm Gm C F
Боже, помилуй нас, из рук не выпусти и для Себя сохрани.
Dm Gm A
Где бы не были мы, ехали, плыли бы, милости не отними.
Dm Gm C F
Перед Тобою никто не осмелится чтобы неправду сказать.
Dm Gm A
Чистое небо святыми заселится, грешникам там не бывать.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=27 | photo=notion-youth-songbook | notionPageId=3c7a9694-04dc-4538-a11a-5eeeb7b573f4 | notionChordPageId=9e3d2855-c14e-43bc-89fb-e8a081d52c2d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3c7a969404dc4538a11a5eeeb7b573f4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Верую, Господи'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=27%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ветры холодные', 'Семья', NULL, '[Куплет 1]
Am E
Ещё будет зима, ещё ветры подуют холодные,
Dm E Am
Ещё голосом вьюг разразится метель и пурга.
A7 Dm
Чтобы нас испытать, будем ли для спасенья пригодные
Am E Am
Или силы не станет когда нас облягут снега.
A7 Dm
А к концу всё подходит и время настало последнее
F E
Как нам нужно друзья дорожить им пока ещё день,
Am Dm
Запасаться елеем, чтобы жизнью нам жить здесь победною
Am E Am
Пока ночью ещё не накрыла нас мрачная тень.

[Куплет 2]
Am E
Очень скоро и лето закончится благоприятное
Dm E Am
Когда Бог свои милости щедрым дождём проливал.
A7 Dm
Когда были мы Им, по отцовски любовью обласканы
Am E Am
И так много Он нас, как детей своих благословлял.
A7 Dm
Но к концу всё подходит, и время настало последнее
F E
Как нам нужно друзья дорожить им пока ещё день,
Am Dm
Запасаться елеем, чтобы жизнью нам жить здесь победною
Am E Am
Пока ночью ещё не накрыла нас мрачная тень.

[Куплет 3]
Am E
Будет трудно потом, если мы без запаса останемся
Dm E Am
А пройти надо нам через всё и в борьбе устоять.
A7 Dm
Где мы силы возьмём, коль сегодня мы не постараемся
Am E Am
Чтоб её в тесном с Богом общении приобретать.
A7 Dm
Может надо нам будет оставить всё нами нажитое
F E
И пойти к Иисусу за стан, поруганье неся,
Am Dm
Но не будем мы Богом оставлены или забытые
Am E Am
Любит Он как отец, Сына в жертву за нас принеся.

[Куплет 4]
Am E
Будем твёрдо держаться Господнего обетования.
Dm E Am
Будем верны Ему, чего б нам не стоило то.
A7 Dm
Не оставим, друзья, никогда своего упования,
Am E Am
Ведь от Божьей любви отлучить нас не сможет ни что.
A7 Dm
Ни метели, ни вьюги, ни ветры с пургою холодною,
F E
Бог Своею любовью всегда будет нас согревать,
Am Dm
А пока время есть благодатного лета Господнего
Am E Am
О котором когда-то потом будем лишь вспоминать.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=28 | photo=notion-youth-songbook | notionPageId=08a5f372-3fcb-472f-978b-5f7b37b1ea88 | notionChordPageId=b5cd00a6-a782-4d6a-a293-c9b0339fdc3e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/08a5f3723fcb472f978b5f7b37b1ea88', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ветры холодные'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=28%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Взор поднимаю к лазурному небу', 'Спасение', NULL, '[Куплет 1]
Em C
Взор поднимаю к лазурному небу
Am H7
Светлой надеждой сердце горит
Em C
В жизни земной этой где бы я ни был
Am H7 Em
Нежно со мною Иисус говорит.

[Припев]
Em Am H7 Em
Сердцем с Тобою ,Ты вечный и лучший
C D G
Мне улететь бы в бескрайнюю даль
Dm E7 Am
Ты самый верный, Мой Друг неразлучный
H7 Em
Радость несу я Тебе и печаль
Am H7 Em
Радость несу я Тебе и печаль

[Куплет 2]
Em C
Ввысь устремляться умею душою
Am H7
Дивная радость, на небе покой
Em C
Мой Искупитель, Ты всюду со мною
Am H7 Em
Славный и мудрый Иисус дорогой

[Куплет 3]
Em C
А надо мною лазурное небо
Am H7
Синим простором все в вечность зовёт
Em C
Ты неизменный о слава за это!
Am H7 Em
Пусть в моем сердце надежда живёт.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=29 | photo=notion-youth-songbook | notionPageId=14be1917-0dc6-42c8-86f4-d39cf573f73d | notionChordPageId=67402743-2ca0-4960-a85b-cb65d71241a6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/14be19170dc642c886f4d39cf573f73d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Взор поднимаю к лазурному небу'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=29%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вот наш Бог', 'Пасхальные', NULL, '[Куплет 1]
Кто моря все горстью исчерпал?
Кто песок земли пересчитал?
Кто Один над всем имеет власть?
Кто творенью радость может дать?

[Припев]
Вот наш Бог, Трон Его высок,
Будем поклоняться!
Вот наш Царь, несравним ни с чем,
Будем поклоняться!

[Куплет 2]
Кто дает народам Свой устав?
Кто Единый прав во всех делах?
Кто решает что произойдет?
Кто Один все знает наперед?

[Куплет 3]
Кто был свят, но взял вину людей?
Кто подставил руки для гвоздей?
Кто в смиреньи умер на кресте?
Кто воскрес, чтоб грешников спасти?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=30 | photo=notion-youth-songbook | notionPageId=e4c919de-4ab6-496d-8f82-42548f63e1dd | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/e4c919de4ab6496d8f8242548f63e1dd | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вот наш Бог'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=30%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вот он я', 'Пасхальные', NULL, '[Куплет 1]
Am G F C F
Вот он я. Твоим величием смирён,
C G
Благодатью освобождён.
Am G F C F
Вот он я. Нечистый, грешный человек.
C G
Омытый жертвою за грех.

[Припев]
Am G C Am G C
На кресте распятый Божий Сын страдал,
D F
За грех мой умирал,чтоб я свободным стал.
C G Am F
Ты велик, Ты велик.
C G
Меня покрыла милость Твоя,
Am F
К новой жизни воскресила она.

[Куплет 2]
Am G F C F
Вот он я. Твоей любовью, так восхищён.
C G
Прощаю, потому что прощён.
Am G F C F
Вот он я. Знаю, что я нужен Тебе.
C G
Освящён, очищен, в огне.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=31 | photo=notion-youth-songbook | notionPageId=fc08ad30-2c85-4dab-9175-985f389071f0 | notionChordPageId=06494446-b0dd-429f-8167-d093294bbfae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fc08ad302c854dab9175985f389071f0', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вот он я'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=31%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вот прошли тысячелетья...', 'Пасхальные', NULL, '[Куплет 1]
C
Вот прошли тысячелетья…
Am
Над землей, над миром этим
Dm G C
Все по-прежнему нам светит солнца свет.
C
Но настанет это время:
Am
День суда и воскресенья,
Dm G C
Чтоб открыто нам пред Богом дать ответ.

[Припев]
C F G C
О, день суда! За все года,
Am Dm G C
Дашь тогда за жизнь прожитую отчёт.
C F G C
О человек, твой краток век,
Am Dm G C
Торопись сейчас спастись!

[Куплет 2]
C
Образ смертного приемля,
Am
Божий Сын пришел на землю,
Dm G C
Чтобы грешных всех от гибели спасти.
C
От греха и преступленья
Am
Совершил Он искупленье,
Dm G C
Всякий может в Нем спасенье обрести.

[Куплет 3]
C
Бог зовет, и неизвестно,
Am
Сколь продлится зов небесный
Dm G C
Над землёй, над миром грешным, друг, спеши!
C
Жизни вечный дар вещая,
Am
Бог не завтра обещает,
Dm G C
Но сегодня предлагает для души.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=32 | photo=notion-youth-songbook | notionPageId=a21255a5-82ca-4a2c-b393-ac7dd3837ddd | notionChordPageId=cf02ed42-7772-4933-a227-de2e8defa95c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a21255a582ca4a2cb393ac7dd3837ddd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вот прошли тысячелетья...'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=32%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Все небеса да хвалят Воскресшего', 'Пасхальные', NULL, '[Куплет 1]
G C D G
Все небеса да хвалят Воскресшего
G C D G
Сравнится ль кто с сияньем красоты Его?
G C G Em
Ведь Агнец, Божий Сын - Небесный занял трон,
C D G
Поклонимся пред Ним, Достоин славы Он!

[Куплет 2]
G C D G
Превозношу, несу хвалу Воскресшему,
G C D G
Кто был распят, Святому и Предвечному.
G C G Em
Отец всё дал Ему, а мы чем воздадим?
C D G
Колени преклоню я только перед Ним.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=33 | photo=notion-youth-songbook | notionPageId=19bf4e19-c6d7-41bd-a001-35e1c0dfca8a | notionChordPageId=155ab88a-5ec0-41dc-9300-1e769bc80efe | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/19bf4e19c6d741bda00135e1c0dfca8a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Все небеса да хвалят Воскресшего'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=33%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Встает заря', 'Прощение', NULL, '[Куплет 1]
Em D
Встает заря, и солнца луч на небо всходит,
Am H7 Em
Засияв в бескрайней синеве.
Em D
За новый день хвалу Творцу поет природа,
Am H7 Em
Мы воспрянем в радостной хвале!

[Припев]
Em G
Слава Богу! Слава Богу!
Am D G H7
За милость, за прощение грехов!
Em G
Слава Богу! Слава Богу
Am H7 Em
За дивную Его любовь!

[Куплет 2]
Em D
Как дивно все, что сотворил наш Бог великий,
Am H7 Em
Да звучит и слава, и хвала!
Em D
Прекрасно все, что создано Творцом Владыкой,
Am H7 Em
Славим Бога за дивные дела!

[Куплет 3]
Em D
Великий Бог в любви Своей к нам, людям грешным,
Am H7 Em
Отдал в жертву Сына Своего,
Em D
И нас омыл Он Кровию Своей Пречистой,
Am H7 Em
Будем вечно славить мы Его.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=34 | photo=notion-youth-songbook | notionPageId=bdd0ce16-c2ed-42db-9412-57022a5604f7 | notionChordPageId=024e644e-0d6b-4ba1-ab76-5c83e6d025c6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bdd0ce16c2ed42db941257022a5604f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Встает заря'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=34%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вся земля полна славы', 'Рождественские', NULL, '[Куплет 1]
Вся земля полна славы и хвалы
Любовь Отца нам явилась в Сыне
И зажглась в небе яркая звезда
Она, мой друг, светит ярко и доныне

[Припев]
Иисус! Иисус!
Ты родился в этот мир
Чтобы жизнь мне дать
Чтоб всегда со мною быть
Спасителем мне стать
Ты любовию Своей
Изменил меня, изменил весь этот мир
Иисус! Мой Иисус!

[Куплет 2]
Подними к небу руки и тогда,
Льется пусть слава и хвала Иисусу,
Ликуй Земля, ведь открыты Небеса,
Родился Царь и грех мира разрушен', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=35 | photo=notion-youth-songbook | notionPageId=50dfd8c1-a23f-4321-9906-b39cc217a6b2 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/50dfd8c1a23f43219906b39cc217a6b2 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вся земля полна славы'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=35%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вся земля хвалу поет', 'Небо', NULL, '[Куплет 1]
D A Hm G
Вся земля хвалу поет лишь Тебе, наш чудный Бог.
D A
И во всей вселенной нет
Hm G
Кто б с Тобой сравниться смог.
Em D
Ты превосходнее всего на свете,
G A
И нет подобного Тебе!
Em D
Ты наш Господь, Ты царствуешь вовеки,
G A
Превознесем Тебя в хвале!

[Припев]
Hm G D
Небеса Тебе поют: «Святый! Святый!»
Hm G D
Вся земля Тебе поет: «Достоин Ты!»
Hm G D
Всё творенье воздает Тебе хвалу, Господь:
Em A
«Благословен наш Бог, Творец всего!»

[Куплет 2]
D A Hm G
От престола Твоего течёт поток живой воды.
D A
Для народа всей земли
Hm G
Сияет свет Твоей любви.
Em D
Своим присутствием покрой всю землю,
G A
Пусть свет прольется в жизнь людей,
Em D
И все народы преклонят колени,
G A
И воспоют хвалу Тебе!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=36 | photo=notion-youth-songbook | notionPageId=13b70973-e9ba-4e1d-bfaa-f10aaf895bfe | notionChordPageId=022bac89-cb62-49a1-a83f-b96d429f6f8a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/13b70973e9ba4e1dbfaaf10aaf895bfe', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вся земля хвалу поет'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=36%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Выбрали мы узкую дорогу', 'Божья любовь', NULL, '[Куплет 1]
Em C D G
Выбрали мы узкую дорогу
C Am H
Нам не жалко юные года;
Em C D G
Ведь с каждым днём мы становимся ближе к Богу
C Am H7
И эта радость у нас в сердцах.

[Припев]
Am D H7 Em
Нам так хочется с Иисусом быть там, на небесах,
C D G E
Ведь не даром пролилась святая кровь;
C D
Где не будут слёзы на глазах,
H7 Em
Только песнь хваленья на устах,
C H7 Em
Ведь там вечно царит любовь.

[Куплет 2]
Em C D G
На земле дух не найдёт причала,
C Am H
Только ты не унывай;
Em C D G
Жизнь даёт короткое начало,
C Am H7
А конец - небесный край.

[Куплет 3]
Em C D G
А пока, с надеждою живою
C Am H
Будем мы здесь проходить свой путь;
Em C D G
День придёт, расстанемся с землёю,
C Am H7
Чтобы нам там в небе отдохнуть.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=37 | photo=notion-youth-songbook | notionPageId=47d1d217-afd3-48f8-b014-f4c7e0b80172 | notionChordPageId=bc5f9fed-e4e0-4a8c-aaeb-46e71dc39feb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/47d1d217afd348f8b014f4c7e0b80172', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Выбрали мы узкую дорогу'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=37%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Где вы, друзья мои', 'Небо', NULL, '[Куплет 1]
Em Am H
Где вы, друзья мои? Я вас люблю.
Am D Am H
Бог приготовил дорогу мне мою,
Em Am H
Но память приносит вас, и сквозь года
Am D Am H
Я обнимаю вас, а в душе звучат слова:

[Припев]
Am H Em
Милые мои, вы Богом данные
Am H Em E
Разошлись пути, но в небо званны мы.
Am D G C
Если суждено уже не встретиться нам,
Am H Em
Я в небе расцелую всех вас.

[Куплет 2]
Em Am H
Я не заплачу, тихо скажу:
Am D Am H
«Господи Боже, об одном Тебя прошу:
Em Am H
Пусть Твои Ангелы друзей моих хранят,
Am D Am H
Да не преткнутся, не дай им обернуться назад»', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=38 | photo=notion-youth-songbook | notionPageId=2e598b1d-3f98-4122-af63-9aa553cfaefd | notionChordPageId=dc7f8357-5762-47a8-bb9c-02d84129c1e8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2e598b1d3f984122af639aa553cfaefd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Где вы, друзья мои'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=38%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Где ты прекрасная', 'Молитвенные', NULL, '[Куплет 1]
A Dm Gm
Где ты прекрасная, светлая, ясная,
A Dm A
Родина вечная — Отчизна моя.
Dm Gm
Мысли к тебе летят, в высь устремляются,
A Dm
В синее небо направляю свой взор.

[Припев]
Gm Dm
А надо мною синее небо,
A Dm D7
Стайкою тёмной летят журавли.
Gm Dm
В крике их птичьем радости много,
A Dm
К родине вечной возвратились они.

[Куплет 2]
A Dm Gm
Там в вышине небес, в краю безоблачном,
A Dm A
Пастырь Иисус Христос ждёт уж меня.
Dm Gm
Скоро достигну я той красоты небес,
A Dm
И поднимаю снова к небу глаза.

[Куплет 3]
A Dm Gm
Знаю, Спаситель мой, скоро придёт за мной,
A Dm A
И в белоснежную церковь возьмёт.
Dm Gm
Только прошу Тебя, дай устоять в пути,
A Dm
Чтобы без пятнышка в небо войти.

[Куплет 4]
A Dm Gm
Родина вечная, чистое небо,
A Dm A
Край мой чудесный - Отчизна моя.
Dm Gm
Прими моё сердце, цвет моей юности,
A Dm
В руки Иисуса отдаюсь навсегда.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=39 | photo=notion-youth-songbook | notionPageId=239c968f-827d-490e-857d-8b5dc5205d78 | notionChordPageId=1249248b-9315-41ac-8d2e-9a2ff5bd626d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/239c968f827d490e857d8b5dc5205d78', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Где ты прекрасная'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=39%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Гефсиманский сад', 'Пасхальные', NULL, '[Куплет 1]
Dm
Гефсиманский сад, Гефсиманский сад…
Gm A
Спят цветы в саду, и деревья спят…
Gm C F A#
||: Слышит сад слова и молитвы стон
Gm A# A
Слышит он, слышит он. :||

[Куплет 2]
Dm
Звёзды смотрят вниз, звёзды смотрят вниз,
Gm A
Как Иисус Христос до земли поник.
Gm C F A#
||: Почему Он здесь? – звёзды не поймут,
Gm A# A
Почему, почему? :||

[Куплет 3]
Dm
В этот скорбный час, в этот скорбный час
Gm A
Не делил никто со Христом печаль.
Gm C F A#
||: Чаша мук Его так была горька,
Gm A# A
Нелегка, нелегка! :||

[Куплет 4]
Dm
Тайну сад открыл, тайну сад открыл,
Gm A
Для чего Иисус на коленях был.
Gm C F A#
||: Чтобы крестный путь до конца свершить,
Gm A# A
Победить, победить!!! :||

[Мост]
И в молитве я, и в молитве я
Говорю: Господь, научи меня
||: На коленях так, как Твой Сын, стоять,
Побеждать, побеждать!!! :||', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=40 | photo=notion-youth-songbook | notionPageId=b705466a-8e38-4cf9-9f56-6d51a42cb061 | notionChordPageId=406c0e71-5f5d-431c-abee-1a1ff19cd366 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b705466a8e384cf99f566d51a42cb061', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Гефсиманский сад'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=40%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Глубока, подобно морю', 'Пасхальные', NULL, '[Куплет 1]
D G D A
Глубока, подобно морю, совершенная Любовь
D G D A D
Как поток, поящий горы, жизнь даёт Христова Кровь.
D Em A D
Царь вселенной, Искупитель умирал за нас с тобой.
Hm G D A D
Там Его Любовь излита, где пролита Божья Кровь.

[Куплет 2]
D G D A
На горе Его распятья Бог Источник нам открыл.
D G D A D
Чтоб болезни и проклятья Он с детей Своих омыл.
D Em A D
Чрез Его любовь забудем навсегда про смерть и ад!
Hm G D A D
И в восторге вечно будем Милость Божью воспевать.

[Куплет 3]
D G D A
Благодать, Любовь и Милость - Божья мощная река.
D G D A D
Из Источника явилась на Голгофе у Креста.
D Em A D
Царь вселенной, Искупитель, умирал за нас с тобой.
Hm G D A D
Там была Любовь излита, где пролита Божья Кровь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=41 | photo=notion-youth-songbook | notionPageId=262ed320-85b7-41da-9de6-8402c2e9f769 | notionChordPageId=0025d45d-d12d-4c58-b4c0-39e43104f4db | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/262ed32085b741da9de68402c2e9f769', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Глубока, подобно морю'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=41%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Говори ко мне', 'Разное', NULL, '[Куплет 1]
C#m H
От гласа Твоего содрогаются горы
A G#m C#m
От гласа Твоего сотрясается земля
C#m H
От гласа Твоего разверзается море
A G#m C#m
От гласа Твоего расступается тьма
C#m A H E
Но ко мне Ты говоришь в тихом веянии ветра
A F#m G#m C#m
Ты приходишь в жизнь мою, предваряя рассвет
C#m A H E
Ты ко мне говоришь, когда я жду ответа.
A G#m C#m
И нежней, чем голос Твой в мире нет!

[Припев]
C#m H
О! Говори! Говори ко мне! Говори! Говори ко мне!
A G#
Говори! Говори ко мне, мой Господь!
C#m H
О! Говори! Говори ко мне! Говори! Говори ко мне!
A G#m C#m
Говори! Говори ко мне, мой Господь!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=42 | photo=notion-youth-songbook | notionPageId=229ce5db-c8bb-4814-b49b-b392f378c2e4 | notionChordPageId=4259388c-05cc-4fc3-ac3b-e236200e8cd3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/229ce5dbc8bb4814b49bb392f378c2e4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Говори ко мне'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=42%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Горы сдвинутся', 'Молитвенные', NULL, '[Куплет 1]
Dm Am
Его мысли не наши мысли, и пути Его не наши пути.
Gm A
Сам Господь их записал однажды, по которым нам должно пройти.
Gm A Dm Gm A Dm
Но как небо выше земли, выше наших Боже мысли Твои.
A#m Dm Gm A Dm A
Я склоняюсь у святых Твоих ног, ибо Ты есть неизменный Бог.

[Припев]
Dm Am
Горы сдвинутся, холмы поколеблются,
Gm A Dm Gm A
А милость Твоя не отступит.
Dm Am
Твое Слово назад не возвращается,
Gm A Dm
Ты исполнишь, что обещал, я верю в Слово Твое.

[Куплет 2]
Dm Am
Он дает утомленному силу, изнемогшему крепость дает.
Gm A
Говорит всегда: «Я с тобою», и за руку тебя ведет.
Gm A Dm Gm A Dm
А надеющиеся на Господа обновятся в силе всегда.
A#m Dm Gm A Dm A
О, душа успокойся, рядом Бог, не бойся.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=43 | photo=notion-youth-songbook | notionPageId=d40e4798-8cc4-47c6-9b45-b797ec40493d | notionChordPageId=97643278-8dca-4b0e-98fd-1cb92cdbee9c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d40e47988cc447c69b45b797ec40493d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Горы сдвинутся'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=43%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господи, как странно', 'Благодарение', NULL, '[Куплет 1]
Em D
Господи, как странно, что я жил Тебя не зная
C D H7
Жил без благости Твоей Святой и без Твоей любви
Em D
Ныне я с Тобой, меня в семью Своих детей Ты принял
C D H7
Я благодарю Тебя и прославлять Тебя хочу я.

[Припев]
Em C D G
Славьте, славьте Бога, прославляйте Бога,
C Am D H7
Прославляйте Бога всё больше день за днём.
Em C D G
Славьте, славьте Бога, прославляйте Бога,
C Am H Em
Прославляйте Бога в сердце своём.

[Куплет 2]
Em D
Господи, благодарю я за любовь Твою и милость,
C D H7
И за слово, что в пути моем меня всегда хранит,
Em D
Господи, благодарю, что с братьями и сестрами хвалу
C D H7
Тебе пою всегда и прославлять Тебя хочу.

[Куплет 3]
Em D
Господи, как страшно было, когда жил совсем один я
C D H7
В темноте, греховном мире, без любви к тебе.
Em D
Но Ты помог свет Твой увидеть, и в грехе мне не погибнуть
C D H7
Слава вечная, хвала, и прославлять хочу Тебя я.

[Куплет 4]
Em D
Я не знал, что есть такая жизнь и друзья такие.
C D H7
За спасение моё Христа благодарю.
Em D
С Ним сумею сделать всё, снесу я трудности любые
C D H7
Потому что славлюБога и Его люблю.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=44 | photo=notion-youth-songbook | notionPageId=acdea7df-dc0a-47af-8985-fea2661be7f6 | notionChordPageId=4a659e20-7b01-4605-af41-a93f93962de3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/acdea7dfdc0a47af8985fea2661be7f6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господи, как странно'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=44%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господь - пастырь мой', 'Хлебопреломление', NULL, '[Куплет 1]
Em D G C
На злачных пажитях меня покоит Он,
G D Em
Водит к тихой воде наслаждаться.

[Припев]
Em D G
Господь - пастырь мой,
C G D
Я ни в чём не буду нуждаться:

[Куплет 2]
Em D G C
Каждый день подкрепляте Он душу мою,
G D Em
На путь правды меня направляет.

[Куплет 3]
Em D G C
И долиною смертной пойду
G D Em
Пред Тобой - я не буду бояться.

[Куплет 4]
Em D G C
Умастил Ты елеем голову мою,
G D Em
Преисполнена моя чаша.

[Куплет 5]
Em D G C
Пребывать вечно буду я в доме Твоем,
G D Em
В чудный образ Твой преображаться.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=45 | photo=notion-youth-songbook | notionPageId=843f43e7-9f21-40b6-a40b-d2ce1d54d550 | notionChordPageId=cec5a1fd-09b9-48f2-b55a-7624bbfab7a1 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/843f43e79f2140b6a40bd2ce1d54d550', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господь - пастырь мой'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=45%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господь есть мой Пастырь', 'Божья любовь', NULL, '[Куплет 1]
G C
Господь есть мой Пастырь, не буду тужить,
D G
На пажитях злачных пасет.
G C
Дает насыщенье моей Он душе
D G
И водит к потокам вод.

[Припев]
C D Hm Em C
А в небе не будет слёз - там чарствует Христос,
D G
Там Иисус сотрет слезу с очей.
C D Hm Em C
Уж скоро окончим путь и сможем отдохнуть
D G
В чудесных бесконечных небесах!

[Куплет 2]
G C
Долиной ли смерти придется идти,
D G
Не буду нуждаться с Тобой.
G C
Твой жезл и Твой посох отрада в пути,
D G
Усталому сердцу покой.

[Куплет 3]
G C
Так благость и милость, мой Боже святой,
D G
Идут со мной по всей земле.
G C
Храни меня в мире могучей рукой
D G
Пока не прибуду к Тебе.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=46 | photo=notion-youth-songbook | notionPageId=0f92c987-641d-493b-9b2c-2be4ddf1e083 | notionChordPageId=81dfa1fb-a39c-4fe3-93f4-72df8159ca78 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0f92c987641d493b9b2c2be4ddf1e083', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господь есть мой Пастырь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=46%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господь моя сила', 'Вера и упование', NULL, '[Куплет 1]
// Господь моя сила и щит. //
Господь упованье моё и помощь мне.

[Припев]
И потому я ликую,
Сердце моё ликует
И песнь моя славит Господа.

[Куплет 2]
// Господь моя радость и мир //
Господь утешенье мое и мой покой.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=47 | photo=notion-youth-songbook | notionPageId=5499f738-a54a-41ec-bfa5-1c1b5e5444fa | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/5499f738a54a41ecbfa51c1b5e5444fa | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господь моя сила'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=47%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Давно погасли огни', 'Спасение', NULL, '[Куплет 1]
Am F C E Am
Давно погасли огни туманных надежд
Am F C E Am
Давно затихли слова безумных невежд
Am F C E Am
И только мысли летят в полночную даль
Am F C E Am
Туда, где зреет рассвет, разгоняя печаль.
Am F C E Am
Ведь где-то есть она, другая страна
Am F C E Am
Там, где царит любовь, там, где всегда весна
Am F C E Am
Где звуки арф и труб, где ангелы поют
Am F C E Am
Где Богу и Христу хвалу все воздают.

[Припев]
F C E Am
Он был, Он есть и снова грядет
F C E Am
Блажен, кто свят, кто верит и ждет.

[Куплет 2]
Am F C E Am
А завтра снова в бой, снова туда
Am F C E Am
Куда ведет побед тернистая тропа
Am F C E Am
Туда, где горя нет, нет боли и слёз
Am F C E Am
Туда, где ждет своих Спаситель наш Христос.
Am F C E Am
О, как ты нам нужна, другая страна
Am F C E Am
Там, где царит любовь, там, где всегда весна
Am F C E Am
Где звуки арф и труб, где ангелы поют
Am F C E Am
Где Богу и Христу хвалу все воздают.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=48 | photo=notion-youth-songbook | notionPageId=4d1f7889-d830-4444-b112-3da7ba50f7ac | notionChordPageId=4d3c5c81-6216-4bca-910b-438fffada889 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4d1f7889d8304444b1123da7ba50f7ac', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Давно погасли огни'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=48%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Далеко, далеко', 'Спасение', NULL, '[Куплет 1]
Cm G#
Далеко, далеко, далеко, далеко,
A# D#
Там за гранью небес голубых.
Fm Cm
Там так нежно, прекрасно, там так мило, легко,
Fm G Cm
Наслаждаться в общеньи святых.

[Куплет 2]
Cm G#
Глубоко, глубоко, глубоко, глубоко,
A# D#
Я мечтаю о Родине той,
Fm Cm
Где нет слёз, нет тревог, там свободно, легко,
Fm G Cm
Где Отцовский мой дом дорогой.

[Куплет 3]
Cm G#
Верю я, верю я, верю я, верю я,
A# D#
Что Ты скоро, Спаситель, придёшь.
Fm Cm
Лишь надежда одна утешает меня -
Fm G Cm
Что увижу я в небе Тебя!

[Куплет 4]
Cm G#
О, Господь, о, Господь, о, Господь, о, Господь,
A# D#
Дай мне силы идти за Тобой.
Fm Cm
Побеждать этот мир лишь любовью Твоей,
Fm G Cm
Ожидая отрадных тех дней!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=49 | photo=notion-youth-songbook | notionPageId=e2c47307-d972-49d1-9de9-d830c376234d | notionChordPageId=73f55c34-d77a-4901-932d-e0b6c0c88869 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e2c47307d97249d19de9d830c376234d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Далеко, далеко'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=49%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Держит Он меня!', 'Пасхальные', NULL, '[Куплет 1]
G C D G
Если грех меня страшит, Держит Он меня!
G C D G
Вера в Бога победит: Держит Он меня.
C D G C H Em
Чтобы мне не потерять Вечного огня,
C D G C D G
Должен Он меня держать. Держит Он меня.

[Припев]
C D Em
Держит Он меня
Em D G
Держит Он меня.
G Am G C
Охраняя и любя,
C D G
Держит Он меня.

[Куплет 2]
G C D G
В крепких, любящих руках Держит Он меня,
G C D G
Дорог я в Его глазах: Держит Он меня.
C D G C H Em
Он не даст погибнуть мне, Сохранит вполне.
C D G C D G
Обещания храня, Держит Он меня.

[Куплет 3]
G C D G
За меня страдал Христос, Держит Он меня.
G C D G
Наказание понес, Держит Он меня.
C D G C H Em
Я воскресну к жизни с Ним Держит Он меня
C D G C D G
Знаю, буду Им храним До Благого Дня.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=50 | photo=notion-youth-songbook | notionPageId=991ed6ab-0e7b-47ae-ba03-63b4f21634af | notionChordPageId=399ee036-70b3-4efe-959e-7f12ba4c2a22 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/991ed6ab0e7b47aeba0363b4f21634af', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Держит Он меня!'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=50%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Дивный Спаситель, прекрасный', 'Пасхальные', NULL, '[Куплет 1]
C F C
Дивный Спаситель, прекрасный,
Em F G
Наш Искупитель и Друг.
Am F Fm
Кто мог подумать, что Агнец
C G Am
Мог искупить нас от мук,
F C G C E
О, мог искупить нас от мук?

[Припев]
Am G F G
Ты – Тот, Кого прославляем,
Am G F G
Тот, Кого любим всегда.
Am F Fm
Дай исцеление и милость
C G Am
Нашим голодным сердцам,
F C G C
О, нашим голодным сердцам.

[Куплет 2]
C F C
Сторож души и Советник,
Em F G
Дух Твой мы жаждем вдохнуть.
Am F Fm
Новой надеждой Ты светишь,
C G Am
Если теряем мы путь,
F C G C E
О, если теряем мы путь.

[Куплет 3]
C F C
Вечный Отец Всемогущий,
Em F G
Верно Ты любишь Своих,
Am F Fm
В слабости к Трону идущих,
C G Am
Чтобы у ног пасть Твоих,
F C G C E
О, чтобы у ног пасть Твоих.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=51 | photo=notion-youth-songbook | notionPageId=7c4040ad-8119-4299-8431-941e770f4eaa | notionChordPageId=de777582-6048-43d7-89ab-2259b9b10eef | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7c4040ad811942998431941e770f4eaa', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Дивный Спаситель, прекрасный'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=51%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Для тебя, о человек', 'Небо', NULL, '[Куплет 1]
Am Dm
Для тебя, о человек, Бог создал небо и поля,
E Am
Для тебя цветут сады и плод дает земля,
A Dm
Для тебя моря и горы, все живое – для тебя,
Am E Am
Для тебя на небе солнце и луна.

[Припев]
Am Dm Am
Что отдал ты Ему за эту красоту?
Gm A Dm
Что отдал ты за эти чудеса?
E Am F
Подумай, человек, ведь твой недолгий век.
Dm F E
Отдай Ему себя! Отдай Христу себя!

[Куплет 2]
Am Dm
Для тебя звучит мелодия в далекой вышине,
E Am
Для тебя роса на травах на заре,
A Dm
Для тебя моря и горы, все живое – для тебя,
Am E Am
Для тебя все это создала Его рука.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=52 | photo=notion-youth-songbook | notionPageId=0aee615f-f9a3-4135-8066-2599b0ee10e9 | notionChordPageId=ae1489c5-0a4c-4165-b600-e3fce2d53577 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0aee615ff9a3413580662599b0ee10e9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Для тебя, о человек'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=52%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Дни, как звук, отшумят', 'Жизнь христианина', NULL, '[Куплет 1]
Am E Am
Дни, как звук, отшумят и исчезнут вдали.
Dm G C
В синем небе летят над землёй журавли.
C Dm G C
В журавлином пути быстрый бег твоих лет.
Dm Am E
И оставишь ли ты, и оставишь ли ты
E Am
На земле добрый след.

[Куплет 2]
Am E Am
Как пройти этот путь, чтобы что-то отдать,
Dm G C
Людям счастье вернуть, веру не потерять.
C Dm G C
Пусть же юность твоя ярким светом горит
Dm Am E
И крупицы добра, и крупицы добра
E Am
Людям щедро дарит.

[Куплет 3]
Am E Am
Дни, как звук, отшумят и исчезнут вдали.
Dm G C
В синем небе летят над землёй журавли.
C Dm G C
В журавлином пути быстрый бег твоих лет.
Dm Am E
И оставишь ли ты, и оставишь ли
E Am
На земле добрый след.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=53 | photo=notion-youth-songbook | notionPageId=7052ee21-45bc-4abd-993e-d28480e1c62b | notionChordPageId=eb817dd6-9104-4a25-9e39-def5ec966797 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7052ee2145bc4abd993ed28480e1c62b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Дни, как звук, отшумят'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=53%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Долго в сумраке скитался', 'Пасхальные', NULL, '[Куплет 1]
Am Dm G C
Долго в сумраке скитался, на путях греховных я
F Dm E E7
В жизни разочаровался, мир обманывал меня.
Am Dm G C
Я взывал: «Кто мне поможет? Скорбь мою увидит кто?»
F Dm E E7
И услышал голос Божий: «Я люблю Тебя давно».

[Припев]
Am Dm G C
"Так давно, так давно Я люблю тебя давно.
F Dm E Am
О, как сладок Божий голос - Я люблю тебя давно."

[Куплет 2]
Am Dm G C
Он меня с любовью принял и от всех грехов омыл,
F Dm E E7
Я к ногам Его склонился и за всё благодарил.
Am Dm G C
И теперь всегда покоюсь я на пажитях Его,
F Dm E E7
Постоянно слышу голос: «Я люблю Тебя давно»

[Куплет 3]
Am Dm G C
И ни в чём мне нет отрады, мир греха мне чуждым стал
F Dm E E7
Во Христе лишь, Друге дивном, утешенье я познал.
Am Dm G C
О, как чудно жить в объятиях у Того, Кто жизнь даёт
F Dm E E7
Слышать голос утешенья: «Я люблю Тебя давно»

[Куплет 4]
Am Dm G C
О, приди обременённый, лишь доверься, Он простит
F Dm E E7
С верой глянь на крест Голгофский и тебя он оживит.
Am Dm G C
Если искренно покаясь, в сердце примешь ты Его
F Dm E E7
Непременно ты услышишь: «Я люблю Тебя давно»', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=54 | photo=notion-youth-songbook | notionPageId=9b8eb47a-2e74-430a-8d4c-701c377553dd | notionChordPageId=76f4e9b7-97d0-4272-955a-50a4a4f73d1b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9b8eb47a2e74430a8d4c701c377553dd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Долго в сумраке скитался'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=54%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Дорога смерти в Иерусалиме', 'Пасхальные', NULL, '[Куплет 1]
Dm A#
Дорога смерти в Иерусалиме,
Gm C Dm
По ней ступает Человек совсем бессильный
Dm A#
Избит, измучен, весь кровоточит,
Gm C F
И гвоздь заточен, чтобы жизнь Его закончить.

[Припев]
F A# Gm
Его любовь с креста тебе кричала:
Gm C F
“Здесь Мой конец, а для тебя здесь есть начало”.
F A# Gm
Она давно тебя звала, искала,
Gm C Dm
Когда во тьме ты болен был, она стонала…

[Куплет 2]
Dm A#
Как нам легко и как нам просто
Gm C Dm
Идти, мой друг, по Виа Долороса
Dm A#
Вид узких улиц, вслед смотрят косо
Gm C F
Всем, кто пришел найти ответ Его вопросам.

[Куплет 3]
Dm A#
Дорога смерти в Иерусалиме,
Gm C Dm
По ней ступает Человек совсем бессильный
Dm A#
Идет, чтоб вечность дать нам с тобою,
Gm C F
Путь в бесконечность проложить Своею Кровью.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=55 | photo=notion-youth-songbook | notionPageId=a9294273-b26d-4350-b251-b59638ed0bff | notionChordPageId=a8ff8072-3286-4859-a7d0-e044ef134294 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a9294273b26d4350b251b59638ed0bff', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Дорога смерти в Иерусалиме'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=55%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Душу мою к Тебе возношу', 'Божья любовь', NULL, '[Куплет 1]
D A Em Hm
Душу мою к Тебе возношу -
G A
На Тебя уповаю.
D A Em Hm
Веры своей не устыжусь
G A
Боже к Тебе я взываю.

[Припев]
G D A
Пусть Твоя истина и правота
G D A
Ночью и днем охраняет меня.
D A Em Hm
Очи мои устремлены
G A D
К Великому Богу любви.

[Куплет 2]
D A Em Hm
Боже, как долго блуждал я во тьме.
G A
Боже, будь рядом со мною.
D A Em Hm
Боже, прошу, приблизся ко мне.
G A
В святости нежной любовью.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=56 | photo=notion-youth-songbook | notionPageId=404959d9-81ef-483d-8e34-336f40e9cc4b | notionChordPageId=169b3e7e-d29a-45fe-ae1e-b8017926ac6d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/404959d981ef483d8e34336f40e9cc4b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Душу мою к Тебе возношу'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=56%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Если ждет тебя дорога', 'Небо', NULL, '[Куплет 1]
Если ждет тебя дорога в неизвестный край,
На прощанье у порога думы не гадай,
Слово доброе послушай и совет прими:
В этом мире гибнут души, ты свою храни.

[Куплет 2]
Если ждет тебя дорога в неизвестный край,
Спутницей себе тревогу ты не выбирай,
С ней душе одна забота и тоска в пути -
В звездном небе будто кто-то потушил огни.

[Куплет 3]
Если ждет тебя дорога в неизвестный край,
Не суди упавших строго, лучше поднимай,
Может статься, сам в бессилье где-то упадешь,
Ослабеют сердца крылья, веру надорвешь.

[Куплет 4]
Жизнь кипит вокруг, как море, бьет тебя волной,
И в твоем огромном горе ты для всех чужой.
Помощь есть для всех у Бога, ты к Нему взывай,
Если ждет тебя дорога в неизвестный край.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=57 | photo=notion-youth-songbook | notionPageId=a39f5d5d-7b8c-4ece-ac49-ab32d3ce250a | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/a39f5d5d7b8c4eceac49ab32d3ce250a | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Если ждет тебя дорога'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=57%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Есть на небе город', 'Небо', NULL, '[Куплет 1]
Am Dm E Am
Есть на небе город, чудный город света,
Am F G C
Там нужды болезни и печали нету.
Am Dm G C
Там Живут святые, там играют гусли,
Am E
Воспевая славу Господу Иисусу.

[Припев]
Am Dm
Болезни там нет, не гаснет там свет, Иерусалим.
G C E
Там вечно живут, там песни поют, Иерусалим.
Am Dm
Ты город живых, ты город святых, Иерусалим.
Am E Am Dm
К тебе я стремлюсь, с тобой я сольюсь, Иерусалим.

[Куплет 2]
Am Dm E Am
Золотом обложен город тот прекрасный,
Am F G C
Лишь в тебе, Иерусалим, вечно буду счастлив.
Am Dm G C
Жизнь мою преобрази здесь, в земной долине,
Am E
Чтоб покой душе найти в Иерусалиме.

[Куплет 3]
Am Dm E Am
Братья мои, сёстры, там мы будем вместе
Am F G C
Воспевать Иисусу радостные песни.
Am Dm G C
Так давайте ж на земле вместе славить Бога,
Am E
Чтобы стала нам светлей в небеса дорога.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=58 | photo=notion-youth-songbook | notionPageId=4a650950-ebfc-4e24-a91f-2209a5ae6962 | notionChordPageId=09204246-e0b9-4199-92d6-7ffbd20f9321 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4a650950ebfc4e24a91f2209a5ae6962', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Есть на небе город'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=58%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Живущий под кровом Твоим', 'Вера и упование', NULL, '[Куплет 1]
E H
Живущий под кровом Твоим
H A H
Под сенью покоится,
E H
Господу говорит:
H A H
“Ты - мой щит”.

[Припев]
E G#m A H
Он избавит меня от сети ловца
E G#m A H
И от гибельной язвы меня сохранит,
E H A
Потому что уповаю на Творца,
A H E
Потому что я говорю: “Бог мой щит”.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=59 | photo=notion-youth-songbook | notionPageId=4977a864-2386-44a9-8e79-08c7f1b40e41 | notionChordPageId=0aa2b9c6-803b-4326-a72a-0b23ac58f952 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4977a864238644a98e7908c7f1b40e41', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Живущий под кровом Твоим'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=59%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Жизни река бежит', 'Спасение', NULL, '[Куплет 1]
Dm A7 Dm Gm
Жизни река бежит, в вечность она ведёт,
A7 Dm C7 F
Кто грех свой победит, в вечную жизнь войдёт.
D7 Gm
Нужно Иисуса искать, нужно Его найти.
Dm A7 Dm
Вечную благодать, верою обрести.

[Куплет 2]
Dm A7 Dm Gm
Вера – нелёгкий путь, узок он и тернист.
A7 Dm C7 F
Главное не свернуть, главное прямо ввысь.
D7 Gm
Вера нелёгкий наш путь, но нет путей иных.
Dm A7 Dm
Чтобы к Христу прильнуть, в царстве Его святых.

[Куплет 3]
Dm A7 Dm Gm
Верю, Господь Иисус, верю Ты – мой Творец.
A7 Dm C7 F
Верю утрёшь слезу дашь славы мне венец.
D7 Gm
Верю, что день тот придет, примешь меня Иисус.
Dm A7 Dm
Верю, Ты мой Господь, верю не постыжусь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=60 | photo=notion-youth-songbook | notionPageId=1785e4eb-f62f-4b08-9197-92145fca5797 | notionChordPageId=82ea0cfb-0b2e-4737-bcc0-8a3fd1774da2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1785e4ebf62f4b08919792145fca5797', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Жизни река бежит'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=60%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Жизнь – борьба', 'Прославление', NULL, '[Куплет 1]
Am F
Жизнь – борьба Света с тьмой,
Dm E
Надо мной и над тобой.
Am F
Шумит ветер, рвется пламя,
Dm G
Дал нам Бог победы знамя!
F C
Путь назначен нам далекий,
Dm Am
И тернистый, и нелегкий.
F C
Рождены мы все в пустыне,
Dm E
Бог призвал нас быть святыми.

[Припев]
Am F
Столп огня нас ведет среди ночи,
Dm E
Раздвигает моря, если хочет.
F Dm
Столп огня, сила Духа Святого,
C E
Разрушает любые оковы.

[Куплет 2]
Am F
Его сила, Его слава,
Dm E
Бога Сущего от начала,
Am F
Сердце силой наполняет,
Dm G
Духом нас соединяет.
F C
Нас ведет одна дорога,
Dm Am
Истина и жизнь от Бога.
F C
Мы, рожденные в пустыне,
Dm E
Прославляем Его Имя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=61 | photo=notion-youth-songbook | notionPageId=0ceae948-d008-4a32-8b8e-f2928cb0fc2b | notionChordPageId=eaae2921-1742-411d-b3ef-089ea93ec398 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0ceae948d0084a328b8ef2928cb0fc2b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Жизнь – борьба'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=61%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Жизнь это поле', 'Пасхальные', NULL, '[Куплет 1]
Am G
Ты устал в этой жизни от горя и слез,
Dm Am
Ты повсюду встречаешь шипы вместо роз,
F C
Кто-то предал тебя - ты ему не простил,
Dm E
Слов обидных друзьям ты своим не забыл.
F C
Столько раз забывали тебя поддержать,
Dm Am
Когда нужно слова ободренья сказать,
F Am
И теперь, в своем сердце обиду храня,
Dm E
Ты живешь на земле, никого не любя…

[Припев]
Am E G D
Ведь жизнь - это поле, ты сам выбираешь:
F Am Dm E
Семя какое в него погружаешь.
Am E G D
Но только запомни, плоды будут позже,
F Am Dm E Am
Всё на весы Бог когда-то положит…

[Куплет 2]
Am G
Мой уставший, израненный друг, не спеши –
Dm Am
Ты колени склони перед Богом в тиши,
F C
И о ране своей всё Ему расскажи,
Dm E
Исцеленье найдешь у Христа для души.
F C
В твое сердце прольется луч света, добра,
Dm Am
Вдруг увидишь лицо Иисуса Христа.
F Am
Он страдал на кресте, Он людей возлюбил,
Dm E
Хочет Он, чтоб обиды свои ты простил!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=62 | photo=notion-youth-songbook | notionPageId=07af1246-82a6-4ae9-b3ed-32089f1b4d0e | notionChordPageId=f52dc671-4ade-45d7-a9f2-38da46c10594 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/07af124682a64ae9b3ed32089f1b4d0e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Жизнь это поле'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=62%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За всё благодарите', 'Благодарение', NULL, '[Куплет 1]
Праздник жатвы наступил как ты этот год прожил?
Сердце благодарное ли ты Богу принес?
Мы всегда в Его руках, будем же беречь в сердцах
Искру благодатного огня, что хранил меня.

[Припев]
За всё благодарите Его ничто мы в этом мире без Него
В Нем жизни дыханье, в Нем мудрость и знанье.
За все благодарите Творца, за то что Его милость без конца.
В Жатвы День мы благодарим Его,
В Жатвы День мы благодарим Его.

[Куплет 2]
Все здесь проходящее, ветром уносящее,
Как песок рассыпется и все уйдет в никуда.
Только милость вечная, Божья бесконечная
На Земле останется, ведь Он Бог Спаситель твой.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=63 | photo=notion-youth-songbook | notionPageId=15e8794a-cda0-42c9-9ba1-ad76d1e99860 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/15e8794acda042c99ba1ad76d1e99860 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За всё благодарите'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=63%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За все я благодарю', 'Пасхальные', NULL, '[Куплет 1]
F A Dm
За все Тебя, Господь, я благодарю
F A Dm
Ты искупил от смерти душу мою.
Gm D Gm C
И буду возвещать я по всей земле
F C A# C
О том, как милостив и благ Ты ко мне.

[Припев]
F A7 Dm A# C F
Вся слава Тебе, мой Иисус,
F A7 Dm A# C F
Спасенье дал мне мой Иисус,
F A7 Dm A# C F
И сердце во мне – о, Иисус,
A7 Dm C A#
Поет о Тебе всегда, Иисус.

[Куплет 2]
F A Dm
Я посвящаю жизнь свою лишь Тебе,
F A Dm
И благодать Твоя сегодня на мне.
Gm D Gm C
Пусть каждый знает, слыша из моих уст,
F C A# C
О том, что жив Господь, Спаситель Иисус.

[Куплет 3]
F A Dm
С креста стекала кровь Святая Твоя,
F A Dm
Грехи смывая, очищала меня.
Gm D Gm C
Одежду правды мне Иисус подарил,
F C A# C
Простил, очистил и меня искупил.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=64 | photo=notion-youth-songbook | notionPageId=f8279bc8-ed20-4386-baf3-b4f5203bfde3 | notionChordPageId=95889e28-768f-4110-a9bf-8d34961148bd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f8279bc8ed204386baf3b4f5203bfde3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За все я благодарю'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=64%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За Голгофу, за кровь', 'Пасхальные', NULL, '[Куплет 1]
D A Hm G D A
За Голгофу, за кровь я Тебя благодарю.
D A Hm G A D
За Воскресенье Твое, за победу Твою.

[Припев]
D A Hm
Благодарю Тебя, Иисус.
G D A
Благодарю Тебя, Иисус.
D A Hm
Благодарю Тебя, Иисус.
G D
Просто я благодарю.
G D A D
Просто я благодарю.

[Куплет 2]
D A Hm G D A
За прекрасный рассвет, добрый утрений свет.
D A Hm G A D
За творенье Твое, за спасенье Мое.

[Куплет 3]
D A Hm G D A
За чистый воздух с небес, светлый солнечный лес.
D A Hm G A D
За ликование птиц, за Слово с вечных страниц.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=65 | photo=notion-youth-songbook | notionPageId=9f1f4d29-1193-4a45-be7c-a33d604a699a | notionChordPageId=3c55ef66-c092-478e-895e-3506f17ab82a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9f1f4d2911934a45be7ca33d604a699a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За Голгофу, за кровь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=65%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Зажечь лесной пожар', 'Спасение', NULL, '[Куплет 1]
D F#m G A
Зажечь лесной пожар одной довольно искры,
D F#m G A
Огонь не удержать, он вширь помчится быстро.
G D G D Hm
//: Вот так и Божия любовь и Божья благодать,
G Hm G A D
Кто их познал, не может тот в себе их удержать. ://

[Куплет 2]
D F#m G A
Когда кругом весна, поют ручьи и птицы,
D F#m G A
Весь Божий мир поёт и хочется молиться.
G D G D Hm
//: Вот так и Божия любовь и Божья благодать,
G Hm G A D
Ты хочешь петь, ты хочешь их другому передать. ://', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=66 | photo=notion-youth-songbook | notionPageId=602272fe-28a7-45f4-a9d1-716993d8dee1 | notionChordPageId=956365a3-fc26-4568-bc9f-bb8d8cde7a75 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/602272fe28a745f4a9d1716993d8dee1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Зажечь лесной пожар'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=66%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Зачем мой Господь', 'Пасхальные', NULL, '[Куплет 1]
Dm                          F                             Gm              A
Зачем, мой Господь, Ты оставил всех ангелов в небе?
Dm                          F                             Gm            C
Зачем, мой Господь, Ты оставил родного Отца?
Gm                          C         F                                     Bb
И славу оставив всю, родился Ты в смертном теле.
Gm                                 Bb                 A
Зачем Царь всего творенья обнищал?

[Куплет 2]
Dm            F                        Gm            A
На небе Тебе славу дивные ангелы пели,
Dm                       F                          Gm                  C
Ты был там согрет бесконечной любовью Отца.
Gm                           C            F                              Bb
Зачем Ты оставил свой любимый небесный город?
Gm                             Bb                    A
Зачем Ты прийти на землю пожелал?

[Куплет 3]
Dm                     F                               Gm             A
Ты видел с небес как я жил бесполезно греховно,
Dm            F                                             Gm               C
Достоин того что быть брошенным в огненный ад.
Gm                             C           F                         Bb
И Ты тихо в мир сошел и вместо меня покорно
Gm                            Bb                 A
Был мучим, гоним, оплеван и распят.

[Припев]
Dm    Gm                 Dm    Gm
Для меня сошел Ты с небес,
Dm   Gm           F        Bb       A
(Для меня - - а- - - - - - - а-а)
Dm                 F                                      Gm              A
За меня был поднят на крест.
Dm              F                                   Gm            C
(За меня - - - а- - - - - - - а-а)
Gm                           C          F                         Bb
Чтобы грех снять, боль мою унять,
Gm                           Bb                  A
Чтобы мне удел с собою в небе дать.

[Куплет 4]
Dm                F                                       Gm                     A
За что же меня, мой Господь, бесконечно Ты любишь?
Dm               F                            Gm                        C
Ведь я не достоин поднять даже к небу глаза.
Gm                            C         F                          Bb
На миг замолкает все, глаза заливают слезы,
Gm                           Bb                        A
Ведь я Тебе столько боли причинял.

[Куплет 5]
Dm    Gm                 Dm    Gm
Хочу Тебя славить, Господь мой, за дар Твой бесценный.
Dm   Gm           F        Bb       A
Хоть слаб я и нищ и не знаю где взять нужных слов.
Dm
Пусть будут слова просты, но искренние от сердца.
Ведь Ты для меня так дорог, мой Господь.

[Припев]', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=67 | photo=notion-youth-songbook | notionPageId=ec38bccd-02be-4ad8-bc8e-215bb9d1909e | notionChordPageId=6a86c4c9-d546-469b-b1fb-7769645e1f22 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ec38bccd02be4ad8bc8e215bb9d1909e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Зачем мой Господь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=67%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За шагом шаг', 'Божья любовь', NULL, '[Куплет 1]
Мы пытаемся найти в жизни разные пути.
Кто укажет нам дорогу в светлый мир?
Кто подарит мир сердцам, не оставит до конца?
Нас Господь ведет свой дом на небеса.

[Припев]
За шагом шаг смело мы вперёд пойдём.
Бог дает нам радость жизни,
Он наш путь сквозь тьму и дождь.
День за днем мы его путем идем.
Нам Господь дарует силу
Шаг за шагом день за днем.

[Куплет 2]
Церковь станет нам мостом в замок веры, в светлый дом,
Где надежда и уверенность в грядущем.
Пусть сияет свет Христа. В нём любовь и доброта
И святая неземная красота.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=68 | photo=notion-youth-songbook | notionPageId=c8f0c7b5-eabb-4975-8baf-e16a80148656 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/c8f0c7b5eabb49758bafe16a80148656 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За шагом шаг'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=68%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Здесь, на земле, мы только странники', 'Спасение', NULL, '[Куплет 1]
Am Dm
Здесь, на земле, мы только странники
E Am
И часто путь далекий ждёт.
Am Dm
Порою ноги от усталости болят,
F E
Но в небе Родина нас ждёт!

[Припев]
Am Dm
Там, там, там, в небесах,
G C E
Ангелы поют.
Am Dm
В синих, синих, синих небесах
E Am
Родина нас ждет!

[Куплет 2]
Am Dm
Порою мы друзей встречаем,
E Am
И снова дальний путь зовёт.
Am Dm
Увидимся у ног Спасителя Христа,
F E
Ведь в небе Родина нас ждет!

[Куплет 3]
Am Dm
В дороге дальней, дорогие друзья,
E Am
Вы расскажите людям всем,
Am Dm
Как велика любовь Спасителя Христа,
F E
Что в небе Родина нас ждет!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=69 | photo=notion-youth-songbook | notionPageId=e110d31d-3257-4c3f-bf07-3c438e9cabac | notionChordPageId=e563d8eb-790e-4ff9-9f2e-19caa761abc7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e110d31d32574c3fbf073c438e9cabac', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Здесь, на земле, мы только странники'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=69%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Знаешь, в жизни всё проходит', 'Божья любовь', NULL, '[Куплет 1]
Dm A#
Знаешь, в жизни всё проходит и уходит, уплывает как вода,
C A
А за суетою жарких будней остается лишь пустота.
Dm A#
Каждый день бежишь куда не знаешь, на работу, по делам,
C A
И вокруг себя не замечаешь ту любовь, что ищет нас.

[Припев]
Dm
В чём смысл твоей жизни?
A# Gm A
Пустота… Пустота… Если нету в ней Христа…
Dm
В чём смысл твоей жизни?
A# Gm A
Суета… И пустота… Если нету в ней Христа…

[Куплет 2]
Dm A#
Знаешь, в жизни всё проходит и уходит, уплывает как вода,
C A
А за суетою жарких будней остается лишь пустота.
Dm A#
Сколько раз ты задавал вопросы, находил ли ты ответ?
C A
Для чего пришёл на эту землю и для чего ты ешь свой хлеб?

[Мост]
Dm
:: Есть смысл твоей жизни,
A# Gm A
Лишь с Христом, лишь с Христом, счастье будет только в нём. ::', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=70 | photo=notion-youth-songbook | notionPageId=b9682b7b-50ae-4f80-9457-6d0865157e15 | notionChordPageId=18b335cf-250e-4d40-9662-b3bacb20db83 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b9682b7b50ae4f8094576d0865157e15', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Знаешь, в жизни всё проходит'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=70%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Измени меня', 'Прославление', NULL, '[Куплет 1]
E H7 E
Измени меня, измени меня
A H7
Чтобы я смог сделать то,
E C#m
Для чего Ты меня призвал,
A H7 E
Измени меня!

[Куплет 2]
E H7 E
Укрепи меня, укрепи меня,
A H7
Чтобы я мог быть сильней,
E C#m
Пребывал в любви Твоей.
A H7 E
Укрепи меня!

[Куплет 3]
E H7 E
Испытай меня, испытай меня,
A H7
Чтоб нуждался я в Тебе,
E C#m
Чтобы Ты пребывал во мне.
A H7 E
Испытай меня!

[Куплет 4]
E H7 E
Охраняй меня, охраняй меня,
A H7
Чтоб я чувствовал Тебя,
E C#m
Прославлял Тебя, любя.
A H7 E
Охраняй меня!

[Куплет 5]
E H7 E
Освяти меня, освяти меня,
A H7
Чтобы я мог сделать то,
E C#m
Для чего ты меня призвал.
A H7 E
Освяти меня!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=71 | photo=notion-youth-songbook | notionPageId=b4d218a9-2acc-4547-b627-614fb0f57bd7 | notionChordPageId=64d67bf2-fa7b-4d2e-b3e2-d8d577ff81df | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b4d218a92acc4547b627614fb0f57bd7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Измени меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=71%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, как Ты дорог для меня', 'Молитвенные', NULL, '[Куплет 1]
D Em
Иисус, как Ты дорог для меня
A7 D
Иисус, внемлешь Ты мольбе моей.
Hm Em
О, Иисус, поднимешь Ты, коль упаду;
A7 D
Как Ты дорог, дорог для меня.

[Куплет 2]
D Em
Иисус, Тебя люблю я прославлять.
A7 D
Иисус, Ты без начала, без конца.
Hm Em
Иисус, Ты умер и простил мой грех;
A7 D
Как Ты дорог, дорог для меня.

[Куплет 3]
D Em
Иисус, Ты обещал прийти сюда.
A7 D
Иисус, мы ждем Тебя, открыв сердца.
Hm Em
О, Иисус, услышь Ты наши голоса;
A7 D
Как Ты дорог, дорог для меня.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=72 | photo=notion-youth-songbook | notionPageId=480318d0-5895-42f8-8cdc-6c6900672ece | notionChordPageId=9f2d6af7-a499-4b02-a80e-c1a5f96d0f16 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/480318d0589542f88cdc6c6900672ece', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, как Ты дорог для меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=72%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, превозносим', 'Прославление', NULL, '[Куплет 1]
G Em
Иисус, превозносим
C Am D
Твоё имя, Ты – Царь,
G Em
Пребывающий среди нас,
C D G
И наполняющий сердца!

[Припев]
D Em
Мы поклоняемся Тебе, Господь!
C D G Em
Ты – Бог на небе и на земле,
C D G Em
Ты – Бог на небе и на земле,
C D G
Ты – Владыка во веки веков.

[Куплет 2]
G Em
Иисус, Ты достоин
C Am D
Вечной славы от нас
G Em
Возвещать буду всякий час
C D G
Благословение Твоё!

[Куплет 3]
G Em
Воссел одесную
C Am D
Ты на троне Отца
G Em
Прими славу, величие
C D G
И восхваление без конца', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=73 | photo=notion-youth-songbook | notionPageId=3aa33724-4ed5-4258-8131-3e98e0ecfd38 | notionChordPageId=c597f442-2c74-4549-9f20-4c28124d5a6c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3aa337244ed5425881313e98e0ecfd38', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, превозносим'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=73%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, Ты любовь моя', 'Спасение', NULL, '[Куплет 1]
D A F#
Иисус, Ты любовь моя,
Hm G A
Иисус, не оставлю я Тебя,
D A F#
Из темноты Ты забрал меня,
Hm G A
Дал свободу и теперь знаю я:

[Припев]
D A F# Hm
В Тебе я нуждаюсь,
G A D
Я люблю Тебя, навеки будь со мной.
D A F# Hm
Спаситель, мой лучший друг,
G A D
Прославлять Тебя я буду вновь и вновь.

[Куплет 2]
D A F#
Иисус, ты спаситель мой.
Hm G A
Иисус, лишь в тебе найду покой.
D A F#
Даришь ты жизни полноту,
Hm G A
Ты скала моя и я к тебе иду!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=74 | photo=notion-youth-songbook | notionPageId=49f7d329-452f-440f-9568-e23cf3c8d18d | notionChordPageId=4bc2fdbc-0c46-485f-abc7-b31da83b8f00 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/49f7d329452f440f9568e23cf3c8d18d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, Ты любовь моя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=74%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, Ты моя скала', 'Пасхальные', NULL, '[Куплет 1]
Am E Am
Когда в море бушует волна,
G C
Ветер рвет твои паруса,
Dm Am
И бессмысленной стала борьба,
E
Пой тогда:

[Припев]
Dm G
Иисус, Ты моя скала,
C Am
Иисус, Ты живая вода,
Dm E
И Голгофы завет крови
E Am
Верен Ты,
Dm G
Упованье мое и покой.
C Am
Я однажды вернусь домой
Dm E
И услышу Твои слова:
E7 Am
“Ждал Я Тебя!”

[Куплет 2]
Am E Am
В нашей жизни любая беда,
G C
Словно в море крутая волна,
Dm Am
Губит тех, кто бросил грести,
E
Свой крест нести.

[Куплет 3]
Am E Am
Укрепившись любовью Отца,
G C
Верой в жертву Иисуса Христа,
Dm Am
Силой Духа Святого всегда
E
Пой слова.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=75 | photo=notion-youth-songbook | notionPageId=48be6208-3700-44ae-a808-8afb39ab9ac2 | notionChordPageId=15a3479b-d150-4dd7-89c0-539b9a95b589 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/48be6208370044aea8088afb39ab9ac2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, Ты моя скала'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=75%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, Ты умер на кресте', 'Пасхальные', NULL, '[Куплет 1]
D A Hm
Иисус, Ты умер на кресте
G D A D
Воскрес, чтоб грешников спасти.
D A Hm
Мои все грехи, Иисус, прости,
G D A D
Спаситель, Друг, Господь мой Ты!

[Припев]
G A Hm
Измени меня, прошу,
G D A D
Ведь я Тебе служить хочу.
G A Hm
Измени меня, прошу,
G D A D
Ведь я Тебе служить хочу.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=76 | photo=notion-youth-songbook | notionPageId=101d044d-0291-4a41-a204-b6f0ca7601f1 | notionChordPageId=a072921f-55c7-447d-8f13-73621ff833a5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/101d044d02914a41a204b6f0ca7601f1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, Ты умер на кресте'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=76%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ищите Бога', 'Утешение и ободрение', NULL, '[Куплет 1]
Cm Fm G Cm
Ищите Бога, ищите слёзно,
Fm G Cm C
Ищите, люди, пока не поздно.
Fm A# Cm
И днём, и ночью, в жару и стужу
Fm G Cm
Ищите Бога, Он сердцу нужен!

[Куплет 2]
Cm Fm G Cm
Ищите Бога, ищите каждый,
Fm G Cm C
И вы найдёте Его однажды.
Fm A# Cm
И будет радость превыше неба,
Fm G Cm
Но так ищите, как нищий — хлеба!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=77 | photo=notion-youth-songbook | notionPageId=5a9ca282-7ae7-4255-b6e2-86df7ffc65c3 | notionChordPageId=c4ffd83c-7861-4625-a80a-99d6610c392f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5a9ca2827ae74255b6e286df7ffc65c3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ищите Бога'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=77%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ищите прежде Царства', 'Прославление', NULL, '[Куплет 1]
Ищите прежде Царства Божия
И правды Его,
Все остальное приложится вам,
Аллилуйя, аллилуйя!

[Куплет 2]
Царствие Божие не пища и питье,
А праведность и мир,
И радость во Святом Духе,
Аллилуйя, аллилуйя!

[Куплет 3]
Просите и дано будет вам,
Ищите и найдете,
Стучите и отворят вам,
Аллилуйя, аллилуйя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=78 | photo=notion-youth-songbook | notionPageId=214a2ef2-ad6b-4881-bb4b-5fbdd34400ec | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/214a2ef2ad6b4881bb4b5fbdd34400ec | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ищите прежде Царства'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=78%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Каждый день улетают самолёты', 'Вера и упование', NULL, '[Припев]
Каждый день улетают самолёты,
Каждый час уезжают поезда,
Но, а я - останусь с Иисусом
Навсегда, навсегда, навсегда.

[Куплет 1]
В жизни много суеты,
От неё устанешь ты.
Только Бог даёт покой
Любящей Своей рукой.

[Куплет 2]
Доверяй Ему всегда -
Не покинет никогда.
Он отдал всю жизнь Свою,
Чтобы жил ты с Ним в раю.

[Куплет 3]
Никогда не унывай,
Небо есть заветный край.
Ты в него всегда смотри,
Помощь Господа прими.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=79 | photo=notion-youth-songbook | notionPageId=263c0a1a-4df3-4525-94be-259bd75020d9 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/263c0a1a4df3452594be259bd75020d9 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Каждый день улетают самолёты'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=79%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как вожделенны жилища Твои', 'Дух Святой', NULL, '[Куплет 1]
C G Am7 F
Как вожделенны жилища Твои,
C G
Господи сил!
C G Am7 F
Истомилась душа моя,
C G
Желая войти
C E Am F
Во дворы Господни, дворы Господни,
E Am
Господи Боже сил!
Dm G Em Am
Ибо день один во дворах Твоих
Dm G C
Лучше тысячи.

[Куплет 2]
C G Am7 F
Услышь молитву мою,
C G
Боже, защитник наш.
C G Am7 F
Приникни, призри на лице
C G
Помазанника Твоего.
C E Am F
Ибо Ты даёшь благодать и славу,
E Am
Ибо Ты есть солнце и щит,
Dm G Em Am
Ибо день один во дворах Твоих
Dm G C
Лучше тысячи.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=80 | photo=notion-youth-songbook | notionPageId=3ad616da-f2ce-41f7-99f2-8353184afa37 | notionChordPageId=d13aeb49-5f33-47d4-8ce7-40c62f3c3723 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3ad616daf2ce41f799f28353184afa37', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как вожделенны жилища Твои'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=80%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как вожделенны', 'Дух Святой', NULL, '[Куплет 1]
D Hm
Как вожделенны жилища Твои,
G A D
Господи, Боже сил.
D Hm
Как вожделенны жилища Твои,
G A D
Господи, Боже сил.
G
Так истомилась душа моя,
D
Желая в Господни дворы.
Hm
Сердце мое и плоть моя
Hm D A
Стремятся туда, где Ты, где Ты, где Ты.

[Куплет 2]
D Hm
Господи, Боже, призри на лице
G A D
Помазанника Твоего.
D Hm
Господи, Боже, призри на лице
G A D
Помазанника Твоего.
G
Лучше мне жить у порога в Твой дом,
D
Нежели в замке греха,
Hm
Ибо, Господь, Ты есть солнце и щит,
Hm D A
Блажен тот, кто верит в Тебя.

[Мост]
Я верю в Тебя, мой Бог!
Я верю в Тебя, мой Бог!
Я верю в Тебя, мой Бог!
Я верю в Тебя!
Я верю в Тебя, мой Бог!
Я верю в Тебя, мой Бог!
Имя Твое всегда будет в сердце моем.
Я верю в Тебя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=81 | photo=notion-youth-songbook | notionPageId=0908f372-f2b8-4852-88e1-4ec8011709f8 | notionChordPageId=dfe5f973-7603-423a-af9e-efc789140af5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0908f372f2b8485288e14ec8011709f8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как вожделенны'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=81%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как глубока Твоя любовь', 'Дух Святой', NULL, '[Куплет 1]
Em C
Как глубока Твоя любовь,
Am H7
И прощение – наш покров,
Em G
Ты – наш свет и наш покой,
Am H7
Упование Бог святой.

[Припев]
C Em
Твоя милость велика, Твоя правда высока,
C H7
Твоя сильная рука нас ведёт издалека
Am D
Дух Святой, дорогой,
G C
Драгоценный Дух Святой,
Am H7 Em E7
Наполняй сердца славою Отца!
Am D
Дух Святой, дорогой,
G C
Драгоценный Дух Святой,
Am H7 Em
Освещай и веди за Собой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=82 | photo=notion-youth-songbook | notionPageId=35ea72ae-290c-42bd-a4dc-7893b8391526 | notionChordPageId=051b1862-1405-464c-96e1-c855e08c0134 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/35ea72ae290c42bda4dc7893b8391526', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как глубока Твоя любовь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=82%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как олень стремится к водам', 'Молитвенные', NULL, '[Куплет 1]
C Em Am
Как олень стремится к водам,
F G C F G
Так душа моя к Тебе.
C G Am
Ты один желанье сердца;
F G C
Поклоняюсь я Тебе.

[Припев]
Am F C
Ты - мой щит, крепость Ты моя,
F Dm E
Пред Тобой склоняюсь я,
C Em Am
Ты - Один желанье сердца,
F G C
Поклоняюсь я Тебе.

[Куплет 2]
C Em Am
Свет в ночи и источник жизни,
F G C F G
Это Ты - мой Бог Святой,
C G Am
Словно путник иду к Отчизне,
F G C
Где найду душе покой.

[Куплет 3]
C Em Am
Ты Один мне всего дороже,
F G C F G
Мой покой и жизнь моя,
C G Am
Прославляю Тебя, мой Боже,
F G C
Всей душой любя Тебя.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=83 | photo=notion-youth-songbook | notionPageId=3f531f6f-3751-40cf-8209-c5eb82c98dcf | notionChordPageId=06a709db-8663-461f-92bd-249545d180ae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3f531f6f375140cf8209c5eb82c98dcf', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как олень стремится к водам'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=83%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как прекрасно все то, что Твое', 'Спасение', NULL, '[Куплет 1]
Am
Как прекрасно все то, что Твое,
Dm
Мне повсюду Твой слышится голос,
G
Ветром в листьях звенит и поет,
C E7
В сердце шепчет, как зреющий колос.
Am
Эти горы, покрытые мхом,
Dm
Эти волны, покрытые пеной,
F
Этот берег с горячим песком,
E7
Это солнце в бескрайней Вселенной.

[Припев]
Am
Боже мой, это Ты, это Ты;
Dm
Я с Тобою повсюду встречаюсь,
G
Когда рву мимоходом цветы,
C E
Иль на чей-то поклон отвечаю.

[Куплет 2]
Am
Мне повсюду видна твоя кисть,
Dm
Твой резец и Твой почерк с размахом,
G
В детском взоре, что светел и чист,
C E7
И в цветущих на поле ромашках.
Am
Это Ты нам даруешь друзей,
Dm
Это Ты научил нас трудиться,
F
Потому я хочу все сильней
E7
И все чаще усердней молиться.

[Куплет 3]
Am
Это Ты меня петь научил,
Dm
Потому моя песнь не сполкает.
G
Это Ты в меня свет Свой пролил,
C E7
Он и в вечности не угасает.
Am
Как прекрасно все то, что Твое,
Dm
Пред величьем Твоим я немею.
F
Это Ты мне, Спаситель, даешь
E7
Все то доброе, что я имею.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=84 | photo=notion-youth-songbook | notionPageId=4be82751-2886-41cc-95cc-628b88c41666 | notionChordPageId=85309b48-1a65-4b3e-ad93-f38076a1b855 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4be82751288641cc95cc628b88c41666', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как прекрасно все то, что Твое'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=84%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как сон уходят прочь года', 'Молитвенные', NULL, '[Куплет 1]
Cm Gm
Как сон уходят прочь года
Fm G#
Мне не забыть лица моих друзей
Cm Gm
Несу в своих молитвах я
Fm G#
Их имена и на душе теплей

[Припев]
Cm Fm A# D#
Стрелки на часах, словно миг остановили
Cm G#
И ветер разлук тихо позвал в дальний путь
Cm Fm A# D#
Будем вместе в небесах, а пока где б мы ни жили
Cm G#
Смотри не забудь, лица друзей не забудь

[Куплет 2]
Cm Gm
Скорбей так много на земле
Fm G#
В чуждых сердцах нет места для любви
Cm Gm
Альбом листая в тишине
Fm G#
Прошу: “Господь, друзей моих храни”', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=85 | photo=notion-youth-songbook | notionPageId=7346db90-6079-44d8-a8e3-40ccbd7ca1ea | notionChordPageId=3492c609-af18-4990-ba67-851ebc203768 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7346db90607944d8a8e340ccbd7ca1ea', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как сон уходят прочь года'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=85%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как часто мы блуждаем', 'Пасхальные', NULL, '[Куплет 1]
C Em A7
Как часто мы блуждаем, и просто забываем,
Dm
Что миром правит суета
G E Am Dm
Порой в любовь играем, грехов не замечаем,
G C
А в сердце боль и пустота.

[Припев]
Dm G
Приди к Иисусу и скажи:
C Am
"Я не могу так больше жить,
Dm G
Я больше не хочу грешить,
C
Прости меня!"
Dm G
Приди к Иисусу и поверь,
C Am
Что жизнь изменится теперь
Dm G C
И что святая кровь Христа спасет тебя.

[Куплет 2]
C Em A7
Христос простит любого, Он исцелит больного
Dm
Наполнит сердце добротой
G E Am Dm
Любовь его святая живёт и побеждает,
G C
Приносит радость и покой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=86 | photo=notion-youth-songbook | notionPageId=1c7a5276-75f4-4719-8429-b98a72f8a2e3 | notionChordPageId=8a2cda02-2f11-4802-a702-5c262b51ce38 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1c7a527675f447198429b98a72f8a2e3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как часто мы блуждаем'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=86%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как-то получилось', 'Божья любовь', NULL, '[Куплет 1]
Em Am
Как-то получилось, что сошлись дороги,
H7 Em
Вовсе не похожи, но сошлись в одну.
Em Am
Если вдруг в дороге грусть тебя встревожит.
D H7
Знай, что я с любовью руку протяну.

[Припев]
Em Am
Если вдруг несчастье на тебя нагрянет (а-а-а)
D G
Если на ресницах заблестит слеза.
Em Am
Знай, что сквозь туманы я с любовью гляну
H7 Em
Осторожно в самые глаза.

[Куплет 2]
Em Am
С другом можно плакать, можно и молиться,
H7 Em
С другом можно просто сидя помолчать,
Em Am
Кто сказал, что с другом можно не считаться?
D H7
Друга первым делом нужно уважать.

[Куплет 3]
Em Am
Разве друга ищут, разве выбирают?
H7 Em
Друг к тебе приходит только невзначай.
Em Am
Да и другом разве каждого считают?
D H7
Недруга от друга нужно отличать.

[Куплет 4]
Em Am
Лишь, Христос, с тобою другом станет близким.
H7 Em
Я ищу общенья в быстром беге дней.
Em Am
Ты придешь, я знаю, и склонишься низко,
D H7
Скажешь нежно слово в утешенье мне.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=87 | photo=notion-youth-songbook | notionPageId=ae58ad4f-6c01-4e9b-a4ab-f203a9b40786 | notionChordPageId=484a0f6b-9ed8-4979-82ae-cb989bc1ccb6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ae58ad4f6c014e9ba4abf203a9b40786', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как-то получилось'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=87%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кистью Творца', 'Благодарение', NULL, '[Куплет 1]
C F G Am
Кистью Творца созданы небеса,
F G
Небо и земля созданы Его рукой.
C F E
Я благодарю Тебя, мой Господь,
Am F G
Мой Господь и славлю я Тебя!

[Припев]
Am F Dm G
Краски Твои созданы из любви,
F G C
И душа моя лишь живёт Тобой.
Am F Dm G
Мне подарил этот прекрасный мир,
F G Am
Благодать Твоя, Господи, надо мной.

[Куплет 2]
C F G Am
Кистью Творца созданы ты и я,
F G
По образу Его, как венец творения.
C F E
Я благодарю Тебя, мой Господь,
Am F G
Мой Господь и славлю я Тебя!

[Куплет 3]
C F G Am
Мой Господь, тебе я хочу всегда служить!
F G
Как ещё Тебя я могу благодарить?!
C F E
Я благодарю Тебя, мой Господь,
Am F G
Мой Господь и славлю я Тебя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=88 | photo=notion-youth-songbook | notionPageId=8d23a531-e808-423a-af11-9c49075cac64 | notionChordPageId=abb3dd25-d704-4423-9786-3fa0aeb791cd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8d23a531e808423aaf119c49075cac64', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кистью Творца'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=88%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда бушует жизнь', 'Пасхальные', NULL, '[Куплет 1]
Em Am
Когда бушует жизнь, огнем меня крестя,
H7 Em
Одно твержу всегда себе на память:
G D H7 Em
Зачем же унывать? - Имею я Христа,
Am H7 E7
Что может у меня Его отнять?
Am Am Em C
Зачем же унывать? - Имею я Христа,
Am H7 Em
Что может у меня Его отнять?

[Куплет 2]
Em Am
А если иногда уносят поезда
H7 Em
Друзей моих в далекую разлуку.
G D H7 Em
Зачем же унывать? - Имею я Христа,
Am H7 E7
Что может у меня Его отнять?
Am Am Em C
Зачем же унывать? - Имею я Христа,
Am H7 Em
Что может у меня Его отнять?

[Куплет 3]
Em Am
Я знаю, узок путь и тесны те врата,
H7 Em
Что нас ведут от смерти к жизни вечной.
G D H7 Em
Но мне ли унывать - имею я Христа,
Am H7 E7
Что может у меня Его отнять?
Am Am Em C
Но мне ли унывать - имею я Христа,
Am H7 Em
Что может у меня Его отнять?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=89 | photo=notion-youth-songbook | notionPageId=27a4df2b-c294-44dd-88c8-b5aa91e09b52 | notionChordPageId=bdf06b8f-5b23-43af-b6a0-148d8b14de9c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/27a4df2bc29444dd88c8b5aa91e09b52', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда бушует жизнь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=89%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда в пути душа утомляется', 'Молитвенные', NULL, '[Куплет 1]
Am Dm E Am
Когда в пути душа утомляется
Dm G C Am
Под бременем борьбы и труда,
Dm7 Gm C Am
||: Спешу я в церковь, где не кончается
Dm E Am A
Источник мира, радости никогда. :||

[Куплет 2]
Am Dm E Am
Под звуки псалмов общего пения
Dm G C Am
Я умиляюсь сердцем до слёз.
Dm7 Gm C Am
||: Чрез проповедников откровения
Dm E Am A
Души касается нежно так Христос. :||

[Куплет 3]
Am Dm E Am
И если в сердце боль затаилась,
Dm G C Am
Кем огорчён иль ранен стрелой,
Dm7 Gm C Am
||: Кровью Христа, из ран что струилась,
Dm E Am A
Я исцелён и, счастлив, иду домой. :||

[Куплет 4]
Am Dm E Am
Мой милый друг, душою израненный,
Dm G C Am
Ты посетил молитвенный дом,
Dm7 Gm C Am
||: Прими спасенье в день этот памятный
Dm E Am A
И вместе с нами радостно в путь пойдём! :||', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=90 | photo=notion-youth-songbook | notionPageId=8debf778-d8a6-4a8a-b07a-be8fb4f2037d | notionChordPageId=634aabd3-0447-4155-9448-e730583ece65 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8debf778d8a64a8ab07abe8fb4f2037d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда в пути душа утомляется'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=90%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда в Твои слова вникаю', 'Спасение', NULL, '[Куплет 1]
Dm
Когда в Твои слова вникаю,
A
Христос, Спаситель дивный мой,
Gm A
Тогда всё глубже понимаю,
Dm D
Что без Тебя я – прах земной.
A# C
Ты есть Лоза моя святая,
F A Dm
А я – лишь веточка Твоя,
Gm A
И сок для жизни получаю
Dm A Dm
Я, мой Спаситель, от Тебя.

[Куплет 2]
Dm
Твой сок во мне всё оживляет,
A
Несёт мне радость и покой,
Gm A
Душа так близко ощущает
Dm D
Тебя, Господь, Спаситель Мой.
A# C
Когда ж случается порою,
F A Dm
Что разобщаюсь я с Тобой,
Gm A
Тогда терзаюсь я душою,
Dm A Dm
Нарушен в сердце мир святой.

[Куплет 3]
Dm
И потому моё желанье
A
В Тебе, Христос мой, пребывать,
Gm A
Чтоб в жизни все мои деянья
Dm D
Твоею силой совершать.
A# C
Ты для меня – Лоза святая,
F A Dm
А я – лишь веточка Твоя.
Gm A
Твоими соками питаясь,
Dm A Dm
Дай пребывать в Тебе всегда.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=91 | photo=notion-youth-songbook | notionPageId=8719feb2-b87d-4f7d-b4d6-0f3076fc64a7 | notionChordPageId=ad7ec627-0068-4c39-a692-4502456640d7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8719feb2b87d4f7db4d60f3076fc64a7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда в Твои слова вникаю'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=91%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда весенний ветерок', 'Утешение и ободрение', NULL, '[Куплет 1]
Em A D Hm
Когда весенний ветерок колышет радостно цветок,
Em A D D7
Когда от розы аромат прольется на цветущий сад,
Em A D Hm
Тогда волнуются сердца, тогда волнуются сердца,
Em A D D7
И славят Господа Творца, о да, Творца.

[Припев]
Em A D Hm
//: Цветы полей, цветы полей,
Em D D7
Вас сотворил Сам Царь царей. ://

[Куплет 2]
Em A D Hm
Он орошает луг ручьем, головку лилии - росой,
Em A D D7
А рощу дальнюю - дождем и шлет луч солнца золотой.
Em A D Hm
Не падай духом в скорби, друг, не падай духом в скорби, друг,
Em A D D7
Ведь близок Бог, смотри вокруг, смотри вокруг.

[Куплет 3]
Em A D Hm
Краса цветов - лишь до поры, зной сушит зелени ковры,
Em A D D7
Цветы завянут, но наш Бог пребудет с нами средь тревог.
Em A D Hm
Зимой, в метель, в глухую ночь, зимой, в метель, в глухую ночь
Em A D D7
Мы прославляем Божью мощь, да Божью мощь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=92 | photo=notion-youth-songbook | notionPageId=596ace4b-cf7c-4a74-82a3-f3ccca7ba6f7 | notionChordPageId=3e7337ef-a243-41fe-b0f7-679ebdb869d8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/596ace4bcf7c4a7482a3f3ccca7ba6f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда весенний ветерок'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=92%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда смолкнет всё', 'Прощение', NULL, '[Куплет 1]
D A Em
Когда смолкнет всё, в тиши утонет звук,
Em A
Я к Тебе приду.
D A Em
Принести хочу, из сердца моего
A
Нежную хвалу.

[Припев]
Em D A Em
Тебе я песню спою, Но не просто, чтоб спеть,
Em D A Em
Ведь Ты не этого ждешь.
Em D A Em
Ты видишь мысли мои, Ничего мне не скрыть,
Em D A Em
Ты смотришь в сердце моё.
D A
Я возвращаюсь к сердцу поклоненья,
Em G A D
Поклоненья Тебе, только Тебе, Иисус.
D A
Прости, что я допустил сомненья,
Em G A D
Но теперь для Тебя, всё для Тебя, Иисус.

[Куплет 2]
D A Em
Драгоценный Царь, не выразить в словах
Em A
Чего достоин Ты.
D A Em
Беден я и нищ, и все, что есть -Твоё,
A
Даже просто вздох.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=93 | photo=notion-youth-songbook | notionPageId=7d9a51e4-4f2b-4e8f-a7d9-3d4fd0c3d865 | notionChordPageId=e03188ed-d565-4e38-bfa5-69ef220b040e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7d9a51e44f2b4e8fa7d93d4fd0c3d865', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда смолкнет всё'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=93%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда Христос меня простил', 'Прощение', NULL, '[Куплет 1]
C
Когда Христос меня простил,
Am
Мне землю в небо превратил;
Dm
Среди скорбей, борьбы земной
G E7
Там небо, где Христос со мной.

[Припев]
Am Dm
Хвала Христу! Он спас меня,
G C E7
Простил грехи, открыл Себя!
Am Dm
На суше, в море, над землей -
F E7 Am
Там небо, где Христос со мной.

[Куплет 2]
C
Небесный мир мне был далек,
Am
Меня Христос к нему привлек,
Dm
Вошел Спаситель в жизнь мою,
G E7
С тех пор о Нем всегда пою.

[Куплет 3]
C
Не важно, где теперь живу:
Am
На высоте, внизу, во рву,
Dm
В стране родной, в стране чужой,-
G E7
Там небо, где Христос со мной.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=94 | photo=notion-youth-songbook | notionPageId=f853a9a9-da34-4dfd-b103-7f39fc9aff34 | notionChordPageId=44e22363-c680-4349-a39e-117a4a2bfb67 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f853a9a9da344dfdb1037f39fc9aff34', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда Христос меня простил'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=94%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Косари на лугу', 'Спасение', NULL, '[Куплет 1]
Gm Cm
Косари на лугу размахалися острыми косами,
Gm D Gm
Что им Божий цветок, им бы кончить работу свою.
Cm Gm
Я на милость Твою уповаю, Спаситель мой, Господи,
Dm Gm
На милость, на милость, лишь только на милость Твою.

[Куплет 2]
Gm Cm
Только вера в Тебя, вот моя неизменная спутница.
Gm D Gm
Вера в то, что Ты всем управляешь Своею рукой.
Cm Gm
И я знаю, Господь, что всегда за меня Ты заступишься,
Dm Gm
И спасительным камнем Ты станешь пред острой косой.

[Куплет 3]
Gm Cm
А иначе, зачем Ты поил меня дивными росами?
Gm D Gm
Для чего показал мне любовь и Свою теплоту?
Cm Gm
Для чего Ты наполнил меня чудо песнями, Господи?
Dm Gm
Неужель для того, чтобы бросить под ноги скоту?

[Куплет 4]
Gm Cm
Косари на лугу отмахалися острыми косами,
Gm D Gm
Завершён сенокос, ну а я невредимым стою,
Cm Gm
И как в прежние дни, упиваясь небесными росами,
Dm Gm
Прославляю Тебя за любовь и за милость Твою.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=95 | photo=notion-youth-songbook | notionPageId=959ed66e-cce4-4cd3-8d5a-f21a5ee25aee | notionChordPageId=956903af-137d-47c4-9a34-db32bbbc0911 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/959ed66ecce44cd38d5af21a5ee25aee', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Косари на лугу'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=95%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Крылья зари', 'Божья любовь', NULL, '[Куплет 1]
Em
Господи, Ты испытал меня
Em
И знаешь когда я сажусь,
Em D Em
Когда встаю, иду я, или отдыхаю
Em
Тебе известны мои пути,
Em
Еще нет слова на языке,
Em D Em
Его уже, Ты, Боже, знаешь совершенно

[Припев]
Em C G Am Em
Куда от Тебя я пойду? От Твоего лица не скроюсь,
Em C Am H
На небо взойду – Ты там, сойду в глубины ада,
Em C G Am Em
Возьму ли я крылья зари, переселюсь на край моря –
Em C Am H Em
И там поведет меня Твоя милость

[Куплет 2]
Em
Скажу ли: «Может тьма меня сокроет,
Em
И светлый день превратится в ночь?»
Em D Em
Но ночь – как день, и тьма – как свет перед Тобою.
Em
Славлю Тебя, все дела Твои дивны
Em
И веденье Твое мне не постичь,
Em D Em
Как высоки Твои все, Боже, помышления', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=96 | photo=notion-youth-songbook | notionPageId=805fe242-4406-4dd5-b54a-1e2b540c8c21 | notionChordPageId=1c421e05-8edf-4328-9c03-93c3aedae3f4 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/805fe24244064dd5b54a1e2b540c8c21', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Крылья зари'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=96%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто бы дал мне слезы сокрушенья', 'Дух Святой', NULL, '[Куплет 1]
Gm D7 Gm
Кто бы дал мне слезы сокрушенья,
A# F A#
Плакал бы я день и ночь.
Cm D7 Gm
Где найти для сердца утешенье,
D7 A Gm
Все сомненья б улетели прочь.

[Куплет 2]
Gm D7 Gm
Льются слезы у царя Давида,
A# F A#
Разве мало серебра?
Cm D7 Gm
Но я плачу, потому что вижу:
D7 A Gm
Дух Святой уходит от меня.

[Куплет 3]
Gm D7 Gm
Кто бы дал мне слезы, как
A# F A#
Мария Плакала у ног Христа,
Cm D7 Gm
И слезами их она омыла,
D7 A Gm
Для души отраду там нашла.

[Куплет 4]
Gm D7 Gm
Кто бы дал мне слезы раскаянья,
A# F A#
Что лились из глаз Петра!
Cm D7 Gm
Тяжкую вину его омыли,
D7 A Gm
Грех и горе отречения.

[Куплет 5]
Gm D7 Gm
Посмотри на слезы Иисуса,
A# F A#
Что лились из глаз тогда
Cm D7 Gm
За спасенье Иерусалима
D7 A Gm
И за грех ожесточения.

[Куплет 6]
Gm D7 Gm
Боже, дай мне слезы таковые,
A# F A#
Чтобы был услышан я,
Cm D7 Gm
Чтобы я не плакал за дверями,
D7 A Gm
Где слеза уж больше не нужна.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=97 | photo=notion-youth-songbook | notionPageId=c7cd5991-e6f8-4010-a124-f3fb2e28dab7 | notionChordPageId=289d433a-de7a-4b78-972d-fef87e75ab46 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c7cd5991e6f84010a124f3fb2e28dab7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто бы дал мне слезы сокрушенья'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=97%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто есть на небе у меня?', 'Спасение', NULL, '[Куплет 1]
Em Am C H7
Кто есть на небе у меня? Только Ты!
Em Am C H7
А в жизни только песнь моя: Мой Христос.
E7 Am D
||: Он за меня в горниле был,
G Em
Меня Он кровью искупил
Am H7 Em E
И душу с Богом примирил - Мой Христос! :||

[Куплет 2]
Em Am C H7
Не милы мне богатств дары - Только Ты!
Em Am C H7
Я не хочу их мишуры - Мой Христос!
E7 Am D
||: Мир вечного нам не даёт,
G Em
Все тленья облик в нем несёт,
Am H7 Em E
Моя же радость не пройдёт - Мой Христос! :||

[Куплет 3]
Em Am C H7
Хотя б я бедным плотью стал - Только Ты!
Em Am C H7
Он знает лучше! - я б сказал - Мой Христос!
E7 Am D
||: Пусть в винограднике беда,
G Em
И пусть маслины без плода,
Am H7 Em E
И пусть бичует мор стада - Мой Христос! :||

[Куплет 4]
Em Am C H7
Хоть я среди вражды, огня - Только Ты!
Em Am C H7
И осаждает грех меня - Мой Христос!
E7 Am D
||: Хоть мир готовит грозный бой,
G Em
Хоть все враги идут войной,
Am H7 Em E
Я в Нем силен - прорву их строй - Мой Христос! :||

[Куплет 5]
Em Am C H7
Когда ж расстанусь я с землёй - Только Ты!
Em Am C H7
В Его руках найду покой - Мой Христос!
E7 Am D
||: Когда мне скорби дух стеснят,
G Em
Природы силы замолчат,
Am H7 Em E
Я буду петь сквозь смерти яд: Мой Христос! :||', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=98 | photo=notion-youth-songbook | notionPageId=9b33e469-2286-4527-95ad-32d10276884f | notionChordPageId=c2c656b6-5b04-4b31-8b47-148fc2298820 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9b33e4692286452795ad32d10276884f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто есть на небе у меня?'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=98%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто же я', 'Прощение', NULL, '[Куплет 1]
G Em
Кто же я, что Царя Вселенной всей
D C D C D
Волнует боль моя и мир в душе моей?
G Em
Кто же я, что чудесный Божий свет
D C D C D
Ведет меня всегда, когда мира в сердце нет?

[Припев]
C D Em D
Не за то, что сделал я, но по милости Твоей.
Em D C D
Не за все мои дела Ты любовь даруешь мне.
G Em D C
Я - лишь цветок, что расцветает и мгновенно увядает.
D C D
Пришел в мир и исчезну, как утренний туман.
G Em D C
Но Ты мольбам моим внимаешь. Если упаду, прощаешь.
D C G C Em D
Ты сказал мне, что я Твой, навсегда, навсегда.

[Куплет 2]
G Em
Кто же я, что Всевидящий Господь,
D C D C D
Простив мои грехи, дарует мне любовь?
G Em
Кто же я, чтобы Бог, смиривший шторм,
D C D C D
Дарил мне Свой покой, когда вокруг лишь зло?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=99 | photo=notion-youth-songbook | notionPageId=0a9d92ed-c6ad-4daa-9c61-1f33ed9bc666 | notionChordPageId=80d24c8f-4504-431b-a144-367f90353d58 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0a9d92edc6ad4daa9c611f33ed9bc666', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто же я'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=99%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто из царей', 'Пасхальные', NULL, '[Куплет 1]
A
Идя за звездой в чужие края
F#m
Мы так ожидали увидеть Царя
Hm
Но не младенца…
A
Слабый и малый завёрнутый в плед
F#m
Герой подаривший надежду и свет
Hm E
Мы ждали Спасителя Тот что нас сможет спасти!

[Припев]
A
Но Кто из царей покинет свой трон?
F#m
Кто из господ оставит свой дом?
Hm E
Кто из великих сойдет с высоты до меня?
A
Кто из богов откроет сердца
F#m
Миру который блуждает впотьмах
Hm E
Кто из отцов сына отдаст за меня?

[Куплет 2]
A
Свой дар для младенца Христа принесем
F#m
Славу и честь как царю вознесем
Hm
Мы ждали Его!
A
Ладан Священнику злато Царю
F#m
И смирну несущему жизнь ко кресту
Hm E
Мы верим Он Тот, Кого мы так ждали давно!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=100 | photo=notion-youth-songbook | notionPageId=f28dacd5-5b98-4f02-b329-237f1b379241 | notionChordPageId=f4a80128-d732-40d1-b270-8d07eb9b5bab | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f28dacd55b984f02b329237f1b379241', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто из царей'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=100%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто я без Тебя', 'Божья любовь', NULL, '[Куплет 1]
C F
Хочу я жить под кровом Твоим,
C F
Тонуть в Твоей великой любви,
Am C F
Смотреть лишь на Тебя.
C Dm C Gsus G
Лицо Своё яви, наполни весь мой мир.

[Припев]
Dm E7
Мой Господь, лишь только Тобой дышу я,
Am G F
Словом Твоим живу я. Кто я без Тебя?
Dm E7
Мой океан, в Твоей любви тону я,
Am G F
И сердце моё ликует: «Иисус, Ты жизнь моя!
E
Иисус, Ты жизнь моя!»

[Куплет 2]
C F
Ты всё, что нужно в жизни моей.
C F
Меня наполни славой Своей.
Am C F
Я светом быть хочу
C Dm C Gsus G
И в небеса лечу, чтоб ближе быть к Тебе

[Куплет 3]
C F
Мой каждый шаг всё ближе к Тебе.
C F
Твоя любовь так манит к Себе.
Am C F
Всё то, что есть во мне,
C Dm C Gsus G
И всё, чем я живу, принадлежит Тебе.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=101 | photo=notion-youth-songbook | notionPageId=7455ae64-42ed-41d4-9e5b-adc1e5634c0e | notionChordPageId=47b1f592-14ae-47a8-8d26-f4bcf495fc4a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7455ae6442ed41d49e5badc1e5634c0e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто я без Тебя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=101%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Куда б мы ни ехали', 'Молитвенные', NULL, '[Куплет 1]
Куда б мы ни ехали, куда б ни бежали,
Везде есть проблемы, везде есть печали…
А все потому, чтоб мы понимали -
Мы здесь ненадолго, мы жители рая!

[Припев]
||: Так может, потому и приходят печали,
Чтобы мы с тобой о небе скучали,
Чтобы всей душой стремились в небеса
Куда не постучится больше беда. :||

[Куплет 2]
Когда есть проблемы, когда есть печали…
Мы в громкой молитве к Иисусу взываем:
Гряди же скорей! Мы Тебя ожидаем!
Возьми нас к Себе, где не будет печали!

[Припев]
||: Так может, потому и приходят печали,
Чтобы мы с тобой о небе скучали,
Чтобы всей душой стремились в небеса
Куда не постучится больше беда. :|| Больше беда.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=102 | photo=notion-youth-songbook | notionPageId=4b9a8ff4-24bf-4fc6-a363-6a207efe645a | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/4b9a8ff424bf4fc6a3636a207efe645a | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Куда б мы ни ехали'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=102%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Куда мы идем', 'Пасхальные', NULL, '[Куплет 1]
D A Hm G
Куда мы идем, только Он знает.
D A Hm G
Падает снег, но Он растает.
D A Hm G
Жизнь скоро пройдет, а за ней вечность.
D A Hm G
Что нас всех ждет? Нас ждет бесконечность.

[Припев]
Hm G D A
Бесконечный ад, бесконечный рай.
Hm G D A
Надо выбирать, надо выбирать.
Hm G D A
Скоро жизнь пройдет, скоро жизнь пройдет
Hm G D A
Что тебя там ждет, что тебя там ждет?

[Куплет 2]
D A Hm G
Жизнь это тест, тест на пригодность.
D A Hm G
Вечность летать или вечность ползать,
D A Hm G
Вечность любви без всяких сомнений,
D A Hm G
Вечность в огне средь слез и мученья.

[Куплет 3]
D A Hm G
Божья любовь она бесконечна.
D A Hm G
Пролита кровь, чтоб мы жили вечно.
D A Hm G
Выбери жизнь, выбери счастье.
D A Hm G
Крест свой нести сквозь бури, ненастья.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=103 | photo=notion-youth-songbook | notionPageId=f751b98b-8c4d-4508-9d80-cb277bfcb2c8 | notionChordPageId=c932ccf2-242b-4f55-a180-365f81e37be9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f751b98b8c4d45089d80cb277bfcb2c8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Куда мы идем'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=103%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Лети', 'Небо', NULL, '[Куплет 1]
F G Am
Каждый день смотрю на небеса
F G Dm
Ожидая Твой ответ внутри
F G Am
Дал мне крылья словно паруса
F E
Сказал лети

[Припев]
Am F
Я знаю точно Ты со мной
C G
С Тобою всё пройду Бог мой
Am F
Сквозь бури, ветер, ураган
C E
Лечу в Твой покой
Am F
От бренных дел и суеты
C G
От темноты и пустоты
Am F
Веди меня в Свой чудный свет
F F E
Бог мой

[Куплет 2]
F G Am
Я как почва Ты моя роса
F G Dm
Живою водою напои
F G Am
Покажи мне снова чудеса
F E
Скажи лети', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=104 | photo=notion-youth-songbook | notionPageId=3d15e3cc-a2f3-41fb-a240-cd66d75d097d | notionChordPageId=ed356e62-d658-41ed-b4a0-cc1081ef573c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3d15e3cca2f341fba240cd66d75d097d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Лети'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=104%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Льются слёзы печали', 'Пасхальные', NULL, '[Куплет 1]
[братья]
Льются слёзы печали
На иссохшую землю
И несутся молитвы
Высоко в небеса.
[вместе]
Благодати потоки
Бог дарит неизменно
И очищены ею
Всех спасённых сердца

[Припев]
Благодать Иисуса
Это чаша спасенья,
Это радость прощенья,
Это вечности свет.
Благодать Иисуса
В рай откры-ла нам двери,
Без его благодати
ги
по    бли
Мы                 б навек.

[Куплет 2]
[сёстры]
Не своими делами,
Не своею заслугой,
Благодатью Христовой
Мы навек спасены
[вместе]
Небеса Он оставил
Чтобы стать нашим Другом,
Чтоб поднять на Голгофу
Бремя нашей вины.

[Куплет 3]
Я в восторге сердечном
Пред Христом преклоняюсь
Он вручил мне с любовью
Драгоценнейший дар.
Благодатью Христовой
От греха я спасаюсь
Его царства святого
Я наследником стал.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=105 | photo=notion-youth-songbook | notionPageId=f512fd68-5c85-4075-b74f-a8e6caa926fd | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/f512fd685c854075b74fa8e6caa926fd | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Льются слёзы печали'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=105%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Люби...', 'Божья любовь', NULL, '[Куплет 1]
Em
Люби, когда другой тебя толкает,
C
Люби, когда другой не понимает,
Am
Люби, когда другой тебя подводит,
D H
Люби, когда другой тебя обходит.

[Припев]
Am D
Моя любовь в словах границ не знает,
G Em
Но жаль, на свете нету громких слов,
Am H
Любовь Христа на деле отражает,
Em E
Что Бог один есть вечная любовь.
Em H Em
(Что Бог один есть вечная любовь.)

[Куплет 2]
Em
Люби, когда увидишь лицемерье,
C
Люби, когда заметишь недоверье,
Am
Люби, когда фальшивость в сердце встретишь,
D H
Люби, когда любовь Ты не приметишь.

[Куплет 3]
Em
Люби – и ты не будешь лицемерить,
C
Люби – и ты поймёшь, как всё доверить,
Am
Люби – пусть сердце Бога отражает,
D H
Люби – любовь любовью отвечает.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=106 | photo=notion-youth-songbook | notionPageId=9e83418b-a755-4e8c-9de7-9dfc438faf28 | notionChordPageId=e81368b3-7f28-419a-b57b-57cc81b48cc8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9e83418ba7554e8c9de79dfc438faf28', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Люби...'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=106%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любит Иисус меня', 'Призыв к покаянию', NULL, '[Куплет 1]
D Em
Любит Иисус меня, любит меня,
A D
Песня об этом пусть будет моя.
D Em
И не скрываю я, пусть знают все:
A D D7
Любит Иисус меня, Его люблю я!

[Припев]
Em A
Он любит меня, Его люблю я,
D Hm
Чудесная дружба с Ним у меня.
Em A
Всегда и везде мне с Ним хорошо,
D D7
Он близок в беде, Он рядом со мной.
D A D
(Он близок в беде, Он рядом со мной.)

[Куплет 2]
D Em
Вечная радость Иисусу служить,
A D
И в этом мире с Ним вместе жить.
D Em
Мир предлагает мне дружбу свою,
A D D7
Но говорю я: нет! И песню пою.

[Куплет 3]
D Em
Друг, подойди к Христу, сердце открой,
A D
Руку отдай свою в руку Его.
D Em
Вечную радость ты обретешь
A D D7
И песню новую с Ним запоешь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=107 | photo=notion-youth-songbook | notionPageId=0a5a9e84-2d57-4dbb-b9fd-5b790f223b2e | notionChordPageId=3fc8d47c-ae6d-43e6-9222-4d7c8d483337 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0a5a9e842d574dbbb9fd5b790f223b2e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любит Иисус меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=107%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любовь - Евангельское слово', 'Спасение', NULL, '[Куплет 1]
C#m A E H7
Любовь - Евангельское слово
C#m A H7
Превыше всех на свете слов!
G#m A E
Оно - основа всех основ,
H7 C#m
Оно весь мир спасти готово
A H7
Любовь - Евангельское слово!

[Куплет 2]
C#m A E H7
Оно ни кем не сокрушимо
C#m A H7
Твердыня вечная Христа.
G#m A E
В нем жизни свет и красота,
H7 C#m
Оно лишь сердцем постижимо
A H7
Твердыня вечная Христа.

[Куплет 3]
C#m A E H7
Как много надо умаляться,
C#m A H7
Чтоб Cлово это приобресть.
G#m A E
Оно несет Благую весть,
H7 C#m
И сердце хочет умилятся
A H7
Оно несет благую весть.

[Куплет 4]
C#m A E H7
В нем тайна жизни боготворной,
C#m A H7
В нем корень всех на свете слов,
G#m A E
В нем искупляющая кровь.
H7 C#m
Любовь да будет не притворной
A H7
В нем тайна жизни боготворной.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=108 | photo=notion-youth-songbook | notionPageId=09da7197-572e-404a-be5a-066db2027166 | notionChordPageId=aa4306db-26a6-4665-bb52-e7cb46c283c5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/09da7197572e404abe5a066db2027166', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любовь - Евангельское слово'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=108%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любовь Христа верна и чиста', 'Спасение', NULL, '[Куплет 1]
Em
Мы каждый день встречаемся вновь
Am
С прекрасным словом, словом “любовь”,
H7 Em H7
Мы каждый день за ней летим в мечтах своих,
Em
Но настоящей любви, увы
Am
Мы в этом мире не нашли,
H7
На наш вопрос один ответ:
Em
Любви без Бога нет.

[Припев]
Em
Любовь Христа верна и чиста,
Am
Она и ласкова, и нежна,
D
Она объемлет всех людей
G H7
И покорит силой своей.
Em
Держитесь этой вы любви,
Am
Она вас к небу приведет,
H7 Em
Где Иисус спасенных ждет.

[Куплет 2]
Em
Но настоящая любовь
Am
Приходит с синих облаков.
H7 Em H7
Её дарует вечный Бог, Творец миров.
Em
Она несется и парит,
Am
И каждый может получить
H7
Без денег, злата, серебра
Em
Любовь Христа.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=109 | photo=notion-youth-songbook | notionPageId=085692d9-b323-4bf6-9ad1-33cb2fb0d77f | notionChordPageId=aa4eac71-981f-46ec-b1fd-3fd94c4f5b23 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/085692d9b3234bf69ad133cb2fb0d77f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любовь Христа верна и чиста'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=109%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любоў Хрыстова', 'Спасение', NULL, '[Куплет 1]
Em C
Любоў Хрыстова! Яна, як сонца,
Am H7 Em H7
Што ззяе ў небе над усёй зямлёй.
Em C
Любоў Хрыстова! Што параўнацца
Am H7 Em E
Змагло б у свеце з любоўю той?

[Припев]
Am H7 Em
Любоў святая, любоў Хрыста,
C D G
Яна заўсёды са мной была,
Am H7 Em
Калi я падаў, пяшчотна падымала
C D G
I зноў да Неба мяне вяла.
Am H7 Em
Калi я падаў, пяшчотна падымала
Am H7 Em
I зноў да Неба мяне вяла.

[Куплет 2]
Em C
Любоў Хрыстова! Там на Галгофе
Am H7 Em H7
Страдаў Збавiцель за грэшных нас.
Em C
Любоў Хрыстова! У пакутах цяжкiх
Am H7 Em E
Ад страшнай долi Хрыстос нас спас.

[Куплет 3]
Em C
Любоў Хрыстова, яна і сёння
Am H7 Em H7
Да сябе кліча, прыйдзі цяпер.
Em C
Прыйдзі да Ісуса, спяшайся хутка,
Am H7 Em E
Пакуль адкрыта да Бога дзвер.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=110 | photo=notion-youth-songbook | notionPageId=31d04827-dc7e-4e48-b9e2-d0301b994fce | notionChordPageId=78dab9b4-1ce5-47ac-a4c6-9c1ed12a935b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/31d04827dc7e4e48b9e2d0301b994fce', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любоў Хрыстова'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=110%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Люди ищут вокруг', 'Разное', NULL, '[Куплет 1]
Fm A#m D# G# C
Люди ищут вокруг днём и в полночь идут
Fm A#m C#7 C7
Страх наполнил глаза что принесёт им судьба
Fm A#m D# G# C
С каждым днем жизнь идет одинаково всё
Fm A#m C#7 C7
Стоит просто найти время к Богу прийти

[Припев]
Cm A#m
Помолится и склонится
D# G# C
Он откроет глаза это будет не зря
Fm A#m
Суету брось поверь Богу
C#7 C7 Fm
Он свободу даст

[Куплет 2]
Fm A#m D# G# C
Каждый раз ты забыл к Богу снова прийти
Fm A#m C#7 C7
Волноваться начнешь и в тупик вновь зайдешь
Fm A#m D# G# C
Только Бог может знать жизнь твою наперёд
Fm A#m C#7 C7
Бог наш полон любви ты к Нему поспеши', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=111 | photo=notion-youth-songbook | notionPageId=2c93ac07-50e9-4f83-ae56-77c2e25f67d1 | notionChordPageId=15350e0d-9d12-4465-90ea-0a59c03e9478 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2c93ac0750e94f83ae5677c2e25f67d1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Люди ищут вокруг'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=111%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Манит сердце мечтою', 'Прощение', NULL, '[Куплет 1]
Dm
Манит сердце мечтою
Gm
Высь небес голубая -
A7
Нашей общей мечтою
Dm
Стала вера живая.

[Припев]
D Gm
Он нас сделал родными,
C F
Он нас сделал друзьями,
Dm Gm
Дал нам новое имя -
A7 Dm
Нас зовут христиане.

[Куплет 2]
Dm
Иисус стал нам другом -
Gm
Мы на деле узнали:
A7
Он врачует недуги,
Dm
Удаляет печали.

[Куплет 3]
Dm
Он дарует прощенье,
Gm
Мир и счастье без меры
A7
И второе рожденье,
Dm
Только истинно веруй.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=112 | photo=notion-youth-songbook | notionPageId=4722dbe8-a861-465c-adbc-9df5c1c19004 | notionChordPageId=0879f978-fc76-4930-9ff5-f3f21e4890f1 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4722dbe8a861465cadbc9df5c1c19004', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Манит сердце мечтою'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=112%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мария спешила скорей', 'Пасхальные', NULL, '[Куплет 1]
G Em
Мария спешила скорей
C D
В сиянье первых лучей
G E
Увидеть во гробе Христа
Am D
В то утро она не смогла

[Припев]
C D Hm E
Потому что Он воскрес – это радость до небес
Am D Gsus G
Это счастье и благая весть
C D Hm E
Потому что Он воскрес – это радость до небес
Am D G
Пусть летит над всей землей эта весть.

[Куплет 2]
G Em
И в любящем сердце Петра
C D
Звезда воскресенья взошла
G E
Когда принесли ему весть
Am D
Те ангелы светлых небес

[Куплет 3]
G Em
Расскажут об этом цветы
C D
Споют голубые ручьи
G E
Христос и сегодня живой
Am D
И снова Он рядом с тобой', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=113 | photo=notion-youth-songbook | notionPageId=aa530eb0-fc11-42ed-962e-88eb3e823995 | notionChordPageId=9968fdb4-7925-4589-818a-39beffe7f9ee | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/aa530eb0fc1142ed962e88eb3e823995', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мария спешила скорей'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=113%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Милости Твоей полна вся земля', 'Благодарение', NULL, '[Куплет 1]
Em A A7
Милости Твоей полна вся земля,
D Hm
Милости Твоей полна жизнь моя,
Em F#
Милость Свою Ты превознёс над судом,
Hm A D
Искупил меня и ввёл в Свой дом.

[Припев]
Em A D Hm Em F# Hm
Ты спас меня и оправдал, освободил от вины,
Em A D Hm Em F# Hm
Ты спас меня и оправдал, освободил от вины,

[Мост]
Благодарю Тебя,
Благодарю Тебя,', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=114 | photo=notion-youth-songbook | notionPageId=bd1b6653-b08d-4d46-babd-4db0d7abedc4 | notionChordPageId=3cee34b7-09e9-4f4b-9214-db0c5a0284b4 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bd1b6653b08d4d46babd4db0d7abedc4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Милости Твоей полна вся земля'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=114%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Милость Божья', 'Дух Святой', NULL, '[Куплет 1]
Dm Gm
От погибели спасла меня милость Божья.
C A Dm D
В рве отчаянья нашла меня милость Божья.
Cm D
То, что я ещё живу, что я Господу служу, –
Gm A Dm D
Это милость Божья, это милость Божья

[Куплет 2]
Dm Gm
Что грехи мои Он смыл – это милость Божья.
C A Dm D
И Свой Дух Святой излил – это милость Божья.
Cm D
То, что вера мне дана и ведёт меня она, –
Gm A Dm D
Это милость Божья, это милость Божья

[Куплет 3]
Dm Gm
Вновь и вновь благодарю эту милость Божью
C A Dm D
И желанием горю славить милость Божью,
Cm D
Эту бездну доброты, эту силу чистоты –
Gm A Dm D
Это милость Божья, это милость Божья

[Куплет 4]
Dm Gm
Всё однажды здесь пройдёт, даже милость Божья.
C A Dm D
От земли Бог заберёт свою милость Божью.
Cm D
Там, где место для святых, будет вечно им светить –
Gm A Dm D
Это милость Божья, это милость Божья', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=115 | photo=notion-youth-songbook | notionPageId=839d1652-dd17-4232-ada6-1718886f39cf | notionChordPageId=5b0d2a81-0409-4c7e-8e18-3a4c9a1547d5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/839d1652dd174232ada61718886f39cf', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Милость Божья'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=115%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мимо текла, текла река', 'Божья любовь', NULL, '[Куплет 1]
Dm Gm Dm
Мимо текла, текла река, плыли куда-то облака,
Gm C F D7
Шёл человек, была дорога нелегка
Gm F Dm
И человек мечтал о том, чтобы построить себе дом
Gm A Dm D7
И поселится счастье в нём, в доме одном.

[Куплет 2]
Dm Gm Dm
Часто бывало уставал, но неизменно напевал
Gm C F D7
Песню любимую свою, ту, что пою
Gm F Dm
Дом как известно всем давно, это не стены и окно
Gm A Dm D7
Даже и стулья со столом это не дом.

[Куплет 3]
Dm Gm Dm
Дом - это там, куда готов ты возвращаться вновь и вновь,
Gm C F D7
Яростным, добрым, нежным, злым, еле живым
Gm F Dm
Дом - это там, где нас поймут, там, где надеются и ждут,
Gm A Dm D7
Там, где забудешь о плохом - это твой дом.

[Куплет 4]
Dm Gm Dm
За облаками в вышине дом приготовлен вам и мне,
Gm C F D7
Дом приготовленный Отцом, чтобы жить в нём,
Gm F Dm
Но чтобы в этом доме жить, нужно в сердцах своих хранить
Gm A Dm D7
Мир и тепло, любовь и свет, вечный завет.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=116 | photo=notion-youth-songbook | notionPageId=5b8315eb-8637-48bc-aaa6-c7f4805d9692 | notionChordPageId=c484cb2d-aee1-44bf-b729-7990e0227677 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5b8315eb863748bcaaa6c7f4805d9692', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мимо текла, текла река'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=116%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мир вам', 'Божья любовь', NULL, '[Куплет 1]
Hm Em F#
Мир вам, настал общения час,
Hm Em A
Мир вам, и мы приветствуем вас,
D H7 Em
Мир вам, пусть будет слышен смех детей,
Em G F#
Мир вам, и больше радостных дней.
Hm Em F#
Мир вам, сердца пусть будут добрей,
Hm Em A
Мир вам, вы не судите людей,
D H7 Em
Мир вам и вашим близким, и друзьям
Em F# Hm
Мир братья, сестры вам.

[Припев]
Em Hm
Мир вам, братья, сестры, мир вам, так же просто
Em A D H7
Вы говорите всем друзьям.
Em Hm
Мир вам, и с любовью счастья и здоровья,
Em F# Hm
Мир братья, сестры вам.

[Куплет 2]
Hm Em F#
Мир вам, мы говорим в этот час,
Hm Em A
Мир вам, Господь да будет средь вас.
D H7 Em
Мир вам, пусть крепнет вера каждый час,
Em G F#
Мир вам, недуг оставит пусть вас.
Hm Em F#
Мир вам, огонь любви пусть горит,
Hm Em A
Мир вам, пусть крепче дом ваш стоит,
D H7 Em
Мир вам, конца не будет вашим дням,
Em F# Hm
Мир братья, сестры вам.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=117 | photo=notion-youth-songbook | notionPageId=d0b87b98-9968-4a0c-af1b-f2442ec20186 | notionChordPageId=62b4cd56-7af4-468b-92fe-30f66d4ef10a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d0b87b9899684a0caf1bf2442ec20186', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мир вам'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=117%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мне есть за что благодарить', 'Пасхальные', NULL, '[Куплет 1]
Hm F#m Hm
Мне есть за что благодарить Творца -
Em F#7 Hm
Он снял с меня греховную проказу.
Hm F#7 G
О, пусть теперь польется без конца
Em F#7 Hm
Хвала Ему в поэмах и рассказах.

[Припев]
Em F#7 Hm
Вот почему мне хочется любить
Em A Am H7
Его сильней, и искренней, и чище.
Em F#7 Hm
Мне есть за что Христа благодарить –
G F#7 Hm
Он мне купил небесное жилище.

[Куплет 2]
Hm F#m Hm
Душа взывать к Отцу не устает,
Em F#7 Hm
Где падал я - прощение просил я.
Hm F#7 G
Ведь Он в беде мне руку подаёт,
Em F#7 Hm
Ведь Он моё - прибежище и сила.

[Куплет 3]
Hm F#m Hm
Всё от Него, и всё идёт к Нему,
Em F#7 Hm
Душа поёт небесным отголоском.
Hm F#7 G
Придёт мой день - я ноги обниму
Em F#7 Hm
Того, Кто умер на кресте Голгофском.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=118 | photo=notion-youth-songbook | notionPageId=e686c2cf-a797-47d2-a85e-ae90443349d3 | notionChordPageId=2f3ee12e-701a-406c-9ac1-19dff1c4a5e2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e686c2cfa79747d2a85eae90443349d3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мне есть за что благодарить'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=118%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мне кажется завтра', 'Спасение', NULL, '[Куплет 1]
C
Нам кажется, завтра мы будем прилежней
Am
И лучше, полезней, добрей.
F Fm
Сегодня мы грубы, а завтра мы нежны,
G
И завтра - мы будем мудрей.
C
Мы завтра проведаем старого друга
Am
И завтра напишем письмо
F Fm
И завтра окажем кому-то услугу
G
Не только своим и чужим.
F G C
Не только своим и чужим.

[Припев]
F G
Так в планах на завтра, что скрыто в тумане
Am
За годом проносится год.
F Fm
А что если завтра возьмет и обманет?
G
И завтра совсем не придет.
F G C
И завтра совсем не придет.

[Куплет 2]
C
Мы завтра покаемся в жизни бесплодной
Am
В последнем предсмертном бреду
F Fm
Оденем раздетых, накормим голодных
G
Разделим чужую беду.
C
Мы завтра поймем, что такое Спасенье
Am
И завтра пойдем за Христом
F Fm
Мы завтра пред Богом падем на колени
G
Не ныне, а завтра, потом.
F G C
Не ныне, а завтра, потом.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=119 | photo=notion-youth-songbook | notionPageId=818b46da-8b2c-4cda-bfb8-852f25fd05fc | notionChordPageId=72b5f6c8-8976-4127-a6e4-51ebac8300a5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/818b46da8b2c4cdabfb8852f25fd05fc', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мне кажется завтра'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=119%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Много лет прошло', 'Пасхальные', NULL, '[Куплет 1]
Em Am
Много лет прошло с времен Голгофы,
C H Em
Но Христос оставил ее след,
G D H
А душа все задает вопросы –
Em Am H
Почему Христа распял ты, человек?
Em Am
Но достоин смерти, наказанья
C H Em
Был Варрава убийца и злодей
G D H
А Христос понес все поруганья
Em Am H
За что, скажите, за нас гибнущих людей?

[Припев]
Am H Em D C
Я подошел к ногам Христа, вопросом мучая себя -
Am H Em E7
За что же, Бог мой, люди распяли Тебя?
Am H Em D C
А Он взглянул в мои глаза, любовью ласковой горя,
Am H7 Em
Сказал – «за то, сын Мой, что Я люблю тебя»

[Куплет 2]
Em Am
Вы спросите люди Вартимея
C H Em
Как Христос открыл ему глаза,
G D H
Как вдове Он умершего сына
Em Am H
Возвратил из смертного одра?
Em Am
Так за что же руки пригвоздили
C H Em
Иисусу острием гвоздей,
G D H
Руки те, что всем добро творили
Em Am H
И как любили нежно ласкать детей.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=120 | photo=notion-youth-songbook | notionPageId=8dbd4194-4d00-47be-8d1f-67ad6ead7f4a | notionChordPageId=711e4563-2420-4e6a-a225-7c5ebcb0b2ec | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8dbd41944d0047be8d1f67ad6ead7f4a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Много лет прошло'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=120%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Много лет учили тебя и меня', 'Спасение', NULL, '[Куплет 1]
Am Dm
Много лет учили тебя и меня:
E Am E
Чтобы лодка жизни удачно плыла,
Am Dm
Главное - не бросить вёсла свои,
Am E Am
Но, Иисус, однажды открылся мне Ты.

[Припев]
Am Dm G C
Ты мой белый парус, моя ладья,
Am Dm E Am
Рассекая волны, плывёт в небеса.
Am Dm G C
Иисус мой парус, бросил вёсла я,
Am Dm E Am
Ветер благодати влечёт меня.

[Куплет 2]
Am Dm
Берега не видно, всё объяла мгла.
E Am E
Яростные волны бьются о борта.
Am Dm
Вёсла переломаны, только надо мной
Am E Am
Всё такой же белый парус мой.

[Куплет 3]
Am Dm
В нашей жизни вёсла - это дела,
E Am E
Что без Бога сделали, чтоб спасти себя.
Am Dm
Спасенье приготовлено Богом моим,
Am E Am
Белым, белым парусом моим.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=121 | photo=notion-youth-songbook | notionPageId=8536df5e-69fd-4e72-b768-a119bf69a1f9 | notionChordPageId=c0da7889-302f-4bc4-b518-bbd9d06808b0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8536df5e69fd4e72b768a119bf69a1f9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Много лет учили тебя и меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=121%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Много много километров', 'Небо', NULL, '[Куплет 1]
D Hm G A
Много много километров земного пути
D Hm G A
Через бури, через ветры предстоит пройти.
G A D Hm
Нам светят в неба звезды, а мы роняем слезы,
G A
Устаем мечтать, устаем идти

[Припев]
D Hm G A
Но надо быть верным, честным сильным, не бояться обид,
D Hm G A
И не жалеть своих усилий чтобы грех победить
G A D Hm
Иди смелей вперед, Господь тебя зовет
G A D
Поднять глаза на небеса

[Куплет 2]
D Hm G A
Время нас не ждет в дороге, торопит решать
D Hm G A
Как забыть свои тревоги и сильнее стать
G A D Hm
И снова светят звезды, а мы роняем слезы
G A
Устаем идти, устаем мечтать', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=122 | photo=notion-youth-songbook | notionPageId=53a99305-01b9-4f87-a971-89c12724b77b | notionChordPageId=54d723b6-7d5e-4319-acf1-d63a04fe6ed8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/53a9930501b94f87a97189c12724b77b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Много много километров'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=122%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мой Господь, в этот час', 'Молитвенные', NULL, '[Куплет 1]
Em C D H
Мой Господь, в этот час я склоняюсь в мольбе,
Em C D H
И все нужды мои приношу я Тебе.
Am H Em C
В жизни бурь и тревог Ты укроешь меня.
Am H Em H
Путь весь знаешь, мой Бог, он не скрыт от Тебя.

[Припев]
Em Am D
Ты, Господь, лишь Ты любовь моя,
G C
Щит мой и Скала,
Am H
Лишь Ты моя защита и опора.
Em Am D
Ты, Господь, лишь Ты любовь моя,
G C
В Тебе укроюсь я,
Am H
Ведь Ты моя защита и опора.

[Куплет 2]
Em C D H
Не страшна мне с Тобой даже смертная тень,
Em C D H
Обрету я покой в небе в солнечный день.
Am H Em C
Знаю, слёзы мои Ты с любовью отрёшь,
Am H Em H
Все ошибки в пути Ты простишь и поймёшь.

[Куплет 3]
Em C D H
А пока на земле буду славить Тебя,
Em C D H
Буду сердцем я петь, ожидая любя.
Am H Em C
Знаю, скоро придёшь, скоро встречу Тебя,
Am H Em H
Свою Церковь возьмёшь от скорбей и от зла.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=123 | photo=notion-youth-songbook | notionPageId=6760712b-d2fc-4447-ac80-4164dc835bdd | notionChordPageId=8f33b773-49a6-412e-9f53-cee1179f537c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/6760712bd2fc4447ac804164dc835bdd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мой Господь, в этот час'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=123%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Молитва — это крик души', 'Молитвенные', NULL, '[Куплет 1]
Em C Am H
Молитва — это крик души, чем искренней, тем тише
Em C Am C H
И так легко когда в тиши, ее Господь услышит.
Am D G C
Она, как самый громкий плач, не пред людьми, пред Богом,
Am Em Am H E
В надежде, что небесный врач, поможет нам во многом.

[Припев]
E C#m
Молитва- это Божий дар,
E H
Одно из средств немногих,
E C#m
Через нее и стар и мал,
E H E
Ведут беседу с Богом.

[Куплет 2]
Em C Am H
Она глоток живой воды, залог успешной битвы,
Em C Am C H
Она преграда от беды, постигшим суть молитвы.
Am D G C
Она орудие труда, она души блаженство,
Am Em Am H E
Через нее везде, всегда, приходят к совершенству.

[Куплет 3]
Em C Am H
Но жаль молитва не для всех, убежище от бедствий,
Em C Am C H
Творивший постоянно грех, теряет это средство.
Am D G C
Как пустоцвет неверных чувств, она тогда бесплодна,
Am Em Am H E
Лукавство, лесть из грешных уст, для Бога не угодны!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=124 | photo=notion-youth-songbook | notionPageId=820d8394-a34b-4e3d-9b9f-21ee605b9856 | notionChordPageId=f5eb307b-f013-46d9-9227-281e8ec414ea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/820d8394a34b4e3d9b9f21ee605b9856', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Молитва — это крик души'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=124%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Молодые', 'Божья любовь', NULL, '[Куплет 1]
Am Dm
Молодые, вы рождённы для Бога жить,
G C E7
Чтобы в мире Иисусу Христу служить;
Am Dm
Молодые, перед вами Господь идёт.
F Dm E7
Он - надёжная опора и наш Друг во всём.

[Припев]
Dm G
Посвятим же Христу годы жизни нашей,
C Am
Отдавшись Ему до конца,
Dm E7
Ведь знаем все мы, что наградой нашей,
Am
Будут небеса!
Dm E7 Am
(Будут небеса!) – за вторым разом

[Куплет 2]
Am Dm
В этом мире, где вокруг есть злоба и боль,
G C E7
Молодые, вы должны быть как свет и соль,
Am Dm
Чтобы люди, увидав в вас Иисуса любовь,
F Dm E7
Обернулись и вернулись блудным сыном домой.

[Куплет 3]
Am Dm
Молодые, да хранит вас Господь во всём,
G C E7
В этом мире, где вокруг есть злоба и боль!
Am Dm
Молодые, будьте верны Иисусу Христу,
F Dm E7
Чтобы в мире этом лютом победить сатану.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=125 | photo=notion-youth-songbook | notionPageId=9842986c-3fae-4eb6-9ac7-4e858679250f | notionChordPageId=86be5c09-12ba-4850-98b3-b8bcaacd19c8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9842986c3fae4eb69ac74e858679250f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Молодые'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=125%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Моя молитва да стремится', 'Молитвенные', NULL, '[Куплет 1]
Em C
Моя молитва да стремится
Am H7 Em
К Тебе как-будто фимиам
Em C
И мое сердце обратится
Am H7 Em
В прекрасный Твой небесный храм

[Припев]
D G D
Боже я молюсь заБеларусь!
Em H7
Боже молю Тебя за людей
C D
Ты их прости, Ты их спаси
Hm Em
И милость Свою нам яви
D G D
Боже я знаю, что Ты будешь с нами
Em H7
В храме Своем под небесами
C D
Радость и мир Ты даровал
H7 Em
И жизнь за людей отдал
C H7
И в Книгу Свою нас записал

[Куплет 2]
Em C
Ты в Своем Слове обещаешь
Am H7 Em
Всем, кто Тебя ни призовет,
Em C
Что Ты услышишь в день печали
Am H7 Em
С души греховной снимешь гнет!

[Куплет 3]
Em C
Пошли, Господь, нам силу свыше
Am H7 Em
Людей любить и звать к Тебе
Em C
Когда мы молимся – услышь нас
Am H7 Em
И помощь дай Свою с небес!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=126 | photo=notion-youth-songbook | notionPageId=108b6f4e-245e-401c-a789-4e3817dcfa08 | notionChordPageId=4de00650-657f-4805-8756-32424d9bb6e2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/108b6f4e245e401ca7894e3817dcfa08', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Моя молитва да стремится'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=126%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мы – лишь мгновенье', 'Семья', NULL, '[Куплет 1]
C G Dm Am
Мы – лишь мгновенье, Ты – сама вечность
F C A# G
Мира Создатель, Царь всех сердец.
C G Dm Am
Мы – дуновенье, Ты – бесконечность
F C A# G
Жизни податель, Бог и Отец.

[Припев]
Am F C G
Святый, святый Бог вседержитель
Am F C G
Славен в небе и не земле
Am F C G
Честь, хвалу, Господь и Спаситель
Dm Am G Dm Am G
Воздаем Тебе, воздаем Тебе!

[Куплет 2]
C G Dm Am
В трудностях наших Ты подкрепляешь
F C A# G
Верный и сильный, чтобы спасать.
C G Dm Am
Слабых упавших Ты поднимаешь,
F C A# G
Даришь обильно нам благодать.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=127 | photo=notion-youth-songbook | notionPageId=8a626bb8-da3f-412e-bd66-062313494097 | notionChordPageId=b4f15d48-8526-441d-afb6-c7c7b053f8e4 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8a626bb8da3f412ebd66062313494097', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мы – лишь мгновенье'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=127%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мы нужны друг другу', 'Семья', NULL, '[Куплет 1]
F C Dm
Мы нужны друг другу, Бог нас спас не зря,
A# C F C
Чтобы с тобою были мы друзья.
F C Dm
Так давай служить теперь ты мне, а я тебе,
A# C F
Чтоб Царство Божье было на земле.

[Припев]
A# C Am Dm
Мы – одна семья, мы – одна семья,
A# C F
Пролилась за нас Иисуса кровь.
A# C Am Dm
Мы теперь друзья, мы теперь друзья,
A# C F
И в сердцах у нас Его любовь.

[Куплет 2]
F C Dm
Мы нужны друг другу Бог нас спас не зря
A# C F C
В Царство Божье мы идем, друзья.
F C Dm
Так давайте сохраним мы веру на земле,
A# C F
Чтоб царствовать нам с Богом во Христе!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=128 | photo=notion-youth-songbook | notionPageId=52af40bc-a24f-4013-bb0f-3a2c2d35946a | notionChordPageId=7be2980c-5349-4114-bd20-7f88d8b1eaf3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/52af40bca24f4013bb0f3a2c2d35946a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мы нужны друг другу'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=128%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'На всяком месте', 'Семья', NULL, '[Куплет 1]
G Em
На всяком месте до краёв земли
C D
Я знаю Ты всегда со мной.
Hm Em
И каждый раз звучат слова Твои:
C D G
«Ведь я люблю тебя давно!»
G Em
Ты заповедал сердцу свято жить,
C D
Мне помогая на пути.
Hm Em
На все обетования Твои
C D G
Надеюсь, чтобы вечно жить.

[Припев]
C D
Я Тебя жду день за днём,
G Em
Солнечным утром, в лунной ночи.
C G
Слиться с Тобою всей душой
C D G
И пребывать в святой любви.

[Куплет 2]
G Em
Мне нравится внимать Твоим Словам -
C D
Они животворят меня.
Hm Em
К ногам Твоим склоняться жажду я
C D G
И их слезами умывать.
G Em
Ты что-то изменил в моей душе,
C D
Призвав меня познать Тебя
Hm Em
И заключив со мной в Крови ЗАВЕТ,
C D G
Чтоб жить с Тобою в небесах!

[Куплет 3]
G Em
Вознёсся в славе, чтоб опять прийти,
C D
Свершить спасенье всей Земли.
Hm Em
Тогда узрят Тебя глаза мои
C D G
И Дух возрадуется мой.
G Em
Ты новый Город создал для меня
C D
И там уже не будет слёз;
Hm Em
И жизнь моя рекою потечёт,
C D G
Там солнцем будет Сам Христос!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=129 | photo=notion-youth-songbook | notionPageId=df2ac51d-54cf-41cd-bc79-d6cd6758e13b | notionChordPageId=a6353397-bc53-45fb-8fdf-06bc2655652e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/df2ac51d54cf41cdbc79d6cd6758e13b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'На всяком месте'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=129%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'На Тебя мы уповаем', 'Пасхальные', NULL, '[Куплет 1]
Dm F C
Наша надежда - Ты Христос.
A Dm
Ты наше счастье, наша любовь,
Dm F C
Ты наша радость, Ты наша жизнь.
Gm A A7
Ведь Ты нас любишь и хранишь!

[Припев]
Gm Dm
На Тебя мы уповаем, на Тебя жизнь полагаем,
A Dm D7
На Тебя взор устремляем, ввысь, в небеса.

[Куплет 2]
Dm F C
Ты пострадал за нас, Христос,
A Dm
Ты на кресте пролил Свою Кровь.
Dm F C
Ты нам спасенье ныне принёс,
Gm A A7
Ты нас избавил от горя и слёз.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=130 | photo=notion-youth-songbook | notionPageId=dd1f40a0-db09-43b3-b071-be5afb61e341 | notionChordPageId=73213b9e-d8be-4ddb-a58e-b7ee09b7047a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/dd1f40a0db0943b3b071be5afb61e341', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'На Тебя мы уповаем'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=130%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'На Христа взирая', 'Небо', NULL, '[Куплет 1]
Em Hm C G
На Христа взирая, жизнь Ему отдай,
Am F#m H
Грешных призывая, даст им рай.
Em Hm C G
За тебя страдая, взял Он грех твой Сам,
Am F#m H
На Христа взирая, верь словам.

[Припев]
Am D G C
Взгляд не своди с Иисуса ты,
Am H Em
Будет он ночью-днём Вождём.
Am D G C
Взгляд не своди с Иисуса ты,
Am H
Он наш Вождь.

[Куплет 2]
Em Hm C G
На Христа взирая, в бой за Ним вступай,
Am F#m H
Будет битва злая, ты не унывай.
Em Hm C G
Пусть душа больная слаба пред врагом,
Am F#m H
На Христа смотря, победа в Нём.

[Куплет 3]
Em Hm C G
На Христа взирая, труд свершай ты свой,
Am F#m H
И свой день кончая, в Нём найдёшь покой.
Em Hm C G
И рука святая приготовит пир,
Am F#m H
На Христа взирая, в Нём твой мир.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=131 | photo=notion-youth-songbook | notionPageId=97616c5e-4b67-4abe-9cb9-5de77a5b1fa4 | notionChordPageId=79ceeb46-b66f-4116-991b-70921f831113 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/97616c5e4b674abe9cb95de77a5b1fa4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'На Христа взирая'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=131%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Над церковными куполами', 'Спасение', NULL, '[Куплет 1]
Am Dm
Над церковными куполами
E7 Am
Небо синее-синее-синее.
C
Я иду под моими ногами
Dm E7
Беларусь пролегла родимая.

[Припев]
Am Dm
Тихим светом далёким светится
G7 C
Небо звёздами озарённое,
F Dm
И легко душе моей верится
F E7 Am
В вечный рай, где живут спасённые.

[Куплет 2]
Am Dm
В чистом небе поют херувимы,
E7 Am
Сердце бъется от счастья и радости.
C
Для меня этот мир - любимый:
Dm E7
Полон света, добра и благодасти.

[Куплет 3]
Am Dm
На земле моя жизнь окончится,
E7 Am
Пролетит незаметно, как птица.
C
И мне очень, очень хочется
Dm E7
За мою Беларусь молиться!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=132 | photo=notion-youth-songbook | notionPageId=7be648d7-8137-426d-a48a-f12168bec8ce | notionChordPageId=26167861-2047-48f8-87e1-695b0f85d6e8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7be648d78137426da48af12168bec8ce', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Над церковными куполами'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=132%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Научи меня', 'Спасение', NULL, '[Куплет 1]
Em Am
Научи меня, мой Господь, во всём
H Em
Волю исполнять лишь Твою.
Em Am
Чтобы мне по слову Твоему доказать,
H Em
Как Тебя я, Спаситель, люблю.

[Припев]
Am D
Научи меня среди тысячи
G Em
Голос слышать лишь Твой,
Am H
Научи меня за Тобой идти
Em E
В край желанный, дорогой.

[Куплет 2]
Em Am
Научи меня в грешном мире жить,
H Em
Чтобы свет Твой сиял во тьме,
Em Am
Где не может скрыться город большой,
H Em
Стоя на высоком холме.

[Куплет 3]
Em Am
Научи меня жизнь свою прожить,
H Em
Чтоб в конце услышать слова:
Em Am
Добрый верный раб скорее войди,
H Em
В радость Господина своего.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=133 | photo=notion-youth-songbook | notionPageId=ff3615bc-4736-4a6a-b8ca-11e83940df6e | notionChordPageId=3dd95900-f309-4719-a7ae-e195a83aa265 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ff3615bc47364a6ab8ca11e83940df6e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Научи меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=133%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Начиная новый день', 'Благодарение', NULL, '[Куплет 1]
Начиная новый день, слышу голос Твой.
Я смотрю на небеса, знаю - Ты со мной.
Пусть, Иисус, Твоя рука поведёт меня.
Я люблю Тебя, Господь, Ты храни меня.

[Припев]
Только Ты радость даёшь,
Каждый день за Cобою ведёшь.
Ты омыл душу мою,
Для Тебя живу и пою.

[Куплет 2]
Я Тебя благодарю за любовь и мир.
Ты от смерти и греха нас освободил.
В город света и любви нам открыта дверь.
Слава, всемогущий Бог, мы с Тобой теперь.

[Куплет 3]
Я хочу, чтоб сегодня горели сердца.
Пусть сияет в них свет от великого Бога - Отца.
Пусть ещё миллионы заблудших людей.
Наконец-то поймут, Кто для них всех нужней.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=134 | photo=notion-youth-songbook | notionPageId=a388cd41-df97-4483-a8c2-70017e780b6a | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/a388cd41df974483a8c270017e780b6a | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Начиная новый день'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=134%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Наш Бог Великий', 'Величие Бога', NULL, '[Куплет 1]
G#m E H
Воду в вино превратил,
G#m E H
Слепые глаза Ты открыл:
C#m F#
Нет таких Бог, нет как Ты!
G#m E H
Ты нас из праха поднял,
G#m E H
Свет Твой во тьме воссиял:
C#m F#
Нет таких Бог, нет как Ты!

[Припев]
G#m E
Наш Бог Великий, Он Всемогущий!
H F#
Бог, Ты превыше всего, что дышит!
G#m E
Наш Бог целитель, всё в Его силе
H F#
Наш Бог, Наш Бог!

[Мост]
И если Бог с нами,
Кто против нас восстанет?
И если Бог с нами,
Кто может против быть?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=135 | photo=notion-youth-songbook | notionPageId=92d99b0c-c6c4-43e2-adb4-635ca3052558 | notionChordPageId=6b086cc3-d547-4da4-8032-bd956014a9eb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/92d99b0cc6c443e2adb4635ca3052558', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Наш Бог Великий'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=135%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Наш Бог так велик', 'Семья', NULL, '[Куплет 1]
G Em7
В сиянии Царя блеск величия
C D
Пусть вся земля поёт, в радости поёт
G Em7
Он в свет одел Себя и в страхе меркнет тьма
C D
От голоса Его, от голоса Его

[Припев]
G
Наш Бог так велик, пой со мной
Em7
Наш Бог так велик, пусть видят все
C D G
Наш Бог, наш Бог так велик!

[Куплет 2]
G Em7
Он стоит века, все дни в Его руках
C D
Начало и конец, Начало и конец
G Em7
Господь наш триедин: Дух, Отец и Сын
C D
Великий Он Творец, Великий Он Творец!

[Мост]
Он превыше всех имён
Всей хвалы достоин Он!
И душа поёт:
Наш Бог так велик!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=136 | photo=notion-youth-songbook | notionPageId=4a33c3ab-85d1-4f5c-86f6-7a9322cedc36 | notionChordPageId=3972c2f1-c591-4621-90aa-87a703a29302 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4a33c3ab85d14f5c86f67a9322cedc36', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Наш Бог так велик'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=136%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Наша жизнь - это путь', 'Спасение', NULL, '[Куплет 1]
Dm Gm
Наша жизнь - это путь на небеса.
A# C Dm
День за днем устремляясь вдаль,
Dm Gm
Вспомни жизнь и Господни чудеса,
A# C Dm
Пусть уйдет роковая печаль
Gm Dm
Пой бодрей, сердцу станет веселей,
Gm A# F
Со Христом пройдем сквозь огонь, смело.
Dm Gm
Наша жизнь - это путь на небеса
A# C Dm
Всех искупленных кровью Христа.

[Куплет 2]
Dm Gm
Наша жизнь - это путь на небеса,
A# C Dm
Где гора средь огнистых камней.
Dm Gm
Там поют неземные голоса
A# C Dm
Песни славы Царю Царей.
Gm Dm
Там вовек солнце правды не зайдет,
Gm A# F
Не увидим больше мы там ночи.
Dm Gm
Наша жизнь - это путь на небеса
A# C Dm
Всех искупленных кровью Христа.

[Куплет 3]
Dm Gm
Наша жизнь - это путь на небеса
A# C Dm
По долам каменистых дорог.
Dm Gm
Он ведет нас в обители Христа,
A# C Dm
Где покой для израненных ног.
Gm Dm
Там наш город из золотых камней,
Gm A# F
Где течет река посреди рая.
Dm Gm
Наша жизнь - это путь на небеса
A# C Dm
Всех искупленных кровью Христа.

[Куплет 4]
Dm Gm
Наша жизнь - это путь на небеса
A# C Dm
Сквозь борьбу забывая покой.
Dm Gm
День придет и усталые глаза
A# C Dm
Засверкают победной слезой.
Gm Dm
Все не зря и победа, как венец
Gm A# F
Увенчает нас только верь свято.
Dm Gm
Наша жизнь - это путь на небеса
A# C Dm
Всех искупленных кровью Христа.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=137 | photo=notion-youth-songbook | notionPageId=f758b27b-2b8d-448e-86ac-09b04363b8ea | notionChordPageId=3504de51-1336-4bdc-a379-5724e0d7ba31 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f758b27b2b8d448e86ac09b04363b8ea', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Наша жизнь - это путь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=137%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Небеса ожидают меня', 'Семья', NULL, '[Куплет 1]
Em Am
Небеса ожидают меня,
H7 Em
Радость ждёт неземная меня,
Em Am
Будет встреча с Иисусом Христом,
H7 Em
Святым Духом, Небесным Отцом.

[Припев]
Em E7 Am
И венец, ну конечно, венец,
D7 G
Тот, что мне приготовил Отец!
C Am
И венец, ну конечно, венец,
H7 Em
Тот, что мне приготовил Отец!

[Куплет 2]
Em Am
Город ждёт неземной красоты.
H7 Em
Всюду ангелы, всюду цветы,
Em Am
Лица милых родных мне друзей,
H7 Em
И Спаситель стоит у дверей.

[Куплет 3]
Em Am
Будет встреча с Иоанном, Петром,
H7 Em
И святых без числа целый сонм.
Em Am
Подойдут и обнимут меня,
H7 Em
Радость будет моя без конца.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=138 | photo=notion-youth-songbook | notionPageId=e62c064c-171b-41a2-a4ca-3fa2658e1106 | notionChordPageId=261a5d25-5baa-4d28-a005-5e812a7871cb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e62c064c171b41a2a4ca3fa2658e1106', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Небеса ожидают меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=138%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Небесная родина', 'Семья', NULL, '[Куплет 1]
Я иду туда, где царит весна,
Где цветут сады и все поля.
Птицы там поют и поет земля,
Я иду туда, я иду туда.
Припев (2 раза):
Небесная родина - там где ждет меня Отец.
Небесная родина - где сияет вечный Божий свет.

[Куплет 2]
Там не будет больше горя слез,
Там царит любовь и доброта.
И в мечтах своих моя душа,
Рвется в Небеса, рвется в Небеса.

[Куплет 3]
И пускай бывает жизнь трудна,
И бушует море, бьет волна.
Все же верю я, что придет весна,
Я дойду туда, я дойду туда.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=139 | photo=notion-youth-songbook | notionPageId=105ca539-dd6f-4d6d-ae67-16deee4076ba | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/105ca539dd6f4d6dae6716deee4076ba | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Небесная родина'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=139%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Небо, небо, небес', 'Пасхальные', NULL, '[Куплет 1]
Am Dm E7 Am
Поднимаю глаза и смотрю в небеса,
Am Dm G C Am
Там я вижу Христа одесную Отца.
Am Dm G C Am
Небо, небо, небес приготовил Он мне,
Am Dm E7 Am
Цель моя и мечта — неба вся красота!

[Припев]
Am Dm
/ Небо, небо, небес,
Dm G
Город вечных чудес,
G C
Я мечтаю о нем, там
C Am
Мечтаю и здесь.
Am Dm E7
Небо, небо, небес,
E7 Am
Путь туда через крест. /2р.

[Куплет 2]
Am Dm E7 Am
Чтобы в небо попасть, нужно жизнь так прожить,
Am Dm G C Am
Чтобы Бог мог сказать: «Ты достоин в нём жить,
Am Dm G C Am
Ты достоин смотреть Иисусу в глаза,
Am Dm E7 Am
Если только войдёшь ты к Нему в небеса».

[Куплет 3]
Am Dm E7 Am
Не слыхал человек, не видал того глаз,
Am Dm G C Am
Как там, в небе небес, что там будет для нас.
Am Dm G C Am
Но я знаю одно — красотой тех небес
Am Dm E7 Am
Будет Тот, Кто понёс на Голгофу наш крест.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=140 | photo=notion-youth-songbook | notionPageId=21ec9972-c61d-4258-a0d8-6382d4c7d09c | notionChordPageId=66365aa4-c2a3-40cf-936c-b4909bcd752e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/21ec9972c61d4258a0d86382d4c7d09c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Небо, небо, небес'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=140%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Нет другой истории', 'Рождественские', NULL, '[Куплет 1]
D A
Нет другой истории прекрасной и знакомой
Hm A G
Истории, проникнувшей в сердца
D A
Как мир был погружён в таинство неземное
Hm A G
В святую ночь рождения Христа
D A
История отсчета жизни совсем новой
Hm A G
История отсчета жизни со Христом
D A
Спасенье дать всем нам было Божьей волей
G A
Мы счастье обрели все в Нём!

[Припев]
D A
Рождение любви, рождение добра
Hm G
Рождение мечты надежды и тепла
D A
Рождение Его, подарок Бога нам
Hm G
Ведь в Сыне Своём Господь явился нам

[Мост]
Родился Тот, чье имя знает каждый
Родился Тот,прославлен Кто в веках
Иисус - Спаситель и смиренный Агнец
Родился Он,Чтоб с Ним нам побеждать
Родился Царь,чтоб царствовать вовеки
Своей любовью изменить мир смог
И чрез Него мы стали Божьи дети
Рожденный от Бога - есть Бог!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=141 | photo=notion-youth-songbook | notionPageId=b22ec591-125f-4a3c-9ee1-fe699ef51e3c | notionChordPageId=02458177-3db1-4d18-b198-dc7edd88029f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b22ec591125f4a3c9ee1fe699ef51e3c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Нет другой истории'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=141%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Нет небу синему конца', 'Божья любовь', NULL, '[Куплет 1]
Em C G H
Нет небу синему конца,
Em H C
Везде видна рука Творца,
G C
Сияют звезды в голубой дали,
G Am H
Сияют звезды в голубой дали,

[Припев]
E A
Любовь прекрасна и любовь нежна,
E A
Она нам Господом с небес дана,
E C#m A Am
Как солнца луч среди заоблачных миров,
A H C D E Em
Пусть никогда не умолкает в вас любовь.

[Куплет 2]
Em C G H
Христос принес огонь любви,
Em H C
Чтоб люди свято жить могли,
G C
Любовью вечной возлюбил весь мир,
G Am H
Чтобы, как Он, любили мы.

[Куплет 3]
Em C G H
Средь грома жизненных невзгод,
Em H C
Среди туманов, непогод,
G C
Под шум дождей и шум ветров
G Am H
Храните нежную любовь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=142 | photo=notion-youth-songbook | notionPageId=4ff83597-1060-412b-9da9-4725ea41510e | notionChordPageId=9e8f9a46-d8cb-48c3-b6ba-5cde2cb6f3c8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4ff835971060412b9da94725ea41510e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Нет небу синему конца'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=142%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Нет, не я, но Христос во мне', 'Прощение', NULL, '[Куплет 1]
Бесценный дар, Иисус, мой Искупитель,
Вся благодать небес сокрыта в Нём.
Моя любовь, и праведность, и сила,
Глубокий мир, и радость, и покой.
И я держусь надежды в Иисусе,
Жизнь Ему доверил я вполне,
И теперь с торжеством, петь могу:
”Я спасён лишь Христом, что живет во мне!”

[Куплет 2]
Сгустилась ночь, но знаю, не покинет,
Спаситель мой останется со мной.
Свершаю труд я в слабости, а силу,
В нужде моей всегда проявит Он.
Уверен я, мой Пастырь - мне защита,
С Ним пройду долиною теней.
И, воспрянув от бед, я увижу рассвет,
Но не сам, чрез Христа во мне.

[Куплет 3]
Смотрю вперёд, без страха и сомненья,
Мой грех прощён, оплачен он сполна.
Ценой Крови мне куплено прощенье,
И смерть навек Христом побеждена.
Всем сердцем я держусь за ту победу,
Иисус - Ходатай мой навек!
Был я скован грехом, стал свободным я в Нём!
Нет, не сам, чрез Христа во мне.

[Куплет 4]
Идти за Ним я с каждым вздохом жажду,
Ведь Он сказал, что приведёт домой.
И обновит, чтоб в радости, однажды,
Ввести туда, где трон Его Святой.
||: И я держусь надежды в Иисусе,
Одному Ему хвала вовек!
И свершив жизни путь, будет песнь моих уст:
”Нет, не я, но Христос во мне!” :||', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=143 | photo=notion-youth-songbook | notionPageId=281b8b55-3bc3-4921-a368-f9b63eb539ad | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/281b8b553bc34921a368f9b63eb539ad | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Нет, не я, но Христос во мне'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=143%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Новый год', 'Утешение и ободрение', NULL, '[Куплет 1]
Am H7
Прошел незаметно весь год
Dm E Am
И новый встречаем мы снова
A7 Dm
Что новый нам год принесёт
F E
И будем ли к встречи готовы

[Припев]
Dm Am
Новый год, пусть радость принесёт
Dm G C A7
Пусть счастье принесёт, Тебе и Мне
Dm Am
Лишь с Христом не страшен путь земной
F E Am
Не страшно жить на этой мне земле

[Куплет 2]
Am H7
Мы ждём новый год и порой
Dm E Am
Не думаем, не ожидаем
A7 Dm
А может он скорби несет
F E
А может разлуку, печали

[Куплет 3]
Am H7
Давайте ж молиться друзья
Dm E Am
И жить, как Христос завещал нам
A7 Dm
Мы будем счастливы тогда
F E
И жизнь проживём не напрасно.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=144 | photo=notion-youth-songbook | notionPageId=5b13d5e9-00af-4c99-a7fa-c727e156a53f | notionChordPageId=37668f59-7eb2-4805-907f-72cca1224a3a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5b13d5e900af4c99a7fac727e156a53f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Новый год'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=144%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ныне поздравляют', 'Спасение', NULL, '[Куплет 1]
D Em
Ныне поздравляют все друзья тебя,
A7 D
И тебе желают счастья и добра.

[Припев]
D Em
Пусть пребудет Божий мир с тобой всегда
A7 D
Пусть пребудет Божий мир с тобой всегда
H7 Em
И хранит тебя на многие года
A D
И хранит тебя на многие года.

[Куплет 2]
D Em
Вот уж (много) лет Господь тебя хранил
A7 D
Хочет Он, чтоб ты Ему всегда служил.

[Куплет 3]
D Em
Пусть Господь Спаситель Сам тебя ведет
A7 D
В вечную обитель, где Он Сам живёт.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=145 | photo=notion-youth-songbook | notionPageId=3fa70b77-ec50-4332-a212-62ab54849d1b | notionChordPageId=a14c45f8-f422-4ff9-a017-2d95294848fd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3fa70b77ec504332a21262ab54849d1b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ныне поздравляют'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=145%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'О, молитва', 'Благодарение', NULL, '[Куплет 1]
Em Am Em H Em
О молитва, о молитва! В жизни Богом ты дана.
Em Am Em H Em
В скорбной жизни среди битвы Поднимала ты меня.
E Am D G Em
Темной ночью я не спал, На коленях все стоял
Am D G Am D
И душою с Богом говорил: "Ты услышь меня, мой Бог,
G Em Am H Em
Среди жизненных Тревог Помоги, я выбился из сил!"

[Куплет 2]
Em Am Em H Em
За окном бушует ветер, Хлещет снегом ледяным,
Em Am Em H Em
И такой же бурей в сердце В этот вечер я томим.
E Am D G Em
Но, смирившийся во прах, Со слезами на очах
Am D G Am D
Я в скорбях Иисуса умолял: "О мой Бог! Ты знаешь все,
G Em Am H Em
На душе так тяжело, Я измучен и почти упал".

[Куплет 3]
Em Am Em H Em
О молитва, о молитва! Благодарностью горю,
Em Am Em H Em
Прославляю Божью силу, Благодати глубину.
E Am D G Em
Боже! Ты в любви святой Укреплял дух слабый мой,
Am D G Am D
Когда в бурю падал я без сил. К небесам сердечный вздох
G Em Am H Em
Возносился средь тревог, Я в молитве радость получал.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=146 | photo=notion-youth-songbook | notionPageId=a9a70757-1ce1-489f-ac5f-6fd776514549 | notionChordPageId=6f44cf5d-5996-487c-accc-b027c4a0ec3f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a9a707571ce1489fac5f6fd776514549', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'О, молитва'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=146%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'О, Ты велик', 'Божья любовь', NULL, '[Куплет 1]
Прихожу к Тебе я с хвалою -
Чудеса Твои велики
И любовь Твоя сильна.

[Припев]
О, Ты велик,
Ты прекрасен и велик,
И другого нет как Ты.
И другого нет как Ты.

[Куплет 2]
Буду петь Тебе я вечно
За Твою любовь и милость,
Что даришь Ты нам с небес.

[Куплет 3]
Ты один достоин всей хвалы,
Превозносим к небу руки -
В Тебе радуемся мы.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=147 | photo=notion-youth-songbook | notionPageId=fd57e227-e505-44b5-baca-5be1526fc133 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/fd57e227e50544b5baca5be1526fc133 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'О, Ты велик'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=147%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Одиноко смотрят звезды', 'Пасхальные', NULL, '[Куплет 1]
Dm C A# A7
Одиноко смотрят звезды, Одиноко плачет небо,
Dm C A# A7
Одиноко ветер носит листья за окном.
Dm C A# A7
В сердце раненом обидой Навсегда уходит совесть.
Dm C A# A7
Где же радость, где же правда, Где же та любовь?

[Припев]
Gm A7 Dm A#
Можешь жить другой судьбой, Потому что Бог нас любит.
Gm A7 Dm D7
Можешь, потому что Он святой И не разлюбит.
Gm A7 A# F
Ты посмотри на кровь Христа, На Его страданья.
Gm A Dm D7
Он не оставит никогда, Он не оставит тебя.

[Куплет 2]
Dm C A# A7
Видел в жизни ты так много, Перепробовал немало.
Dm C A# A7
Знаешь, что с волками жить, Так по-волчьи вой.
Dm C A# A7
Ты не веришь даже тем, кому ты Доверял так много.
Dm C A# A7
И не веришь, что ты можешь Жить другой судьбой.

[Куплет 3]
Dm C A# A7
Все проносится так быстро И над временем нет власти.
Dm C A# A7
Как бы ты хотел вернуть прошлое назад.
Dm C A# A7
И ты мечешься по жизни, Хочешь вырвать куш свободы,
Dm C A# A7
Но я знаю, бесполезно, Если нет Христа.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=148 | photo=notion-youth-songbook | notionPageId=043847d8-b0cf-4c87-9c92-7c7ba2b90646 | notionChordPageId=6b3815bd-305a-4cd7-8f89-e4dfe8170c8c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/043847d8b0cf4c879c927c7ba2b90646', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Одиноко смотрят звезды'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=148%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Однажды я сказал', 'Божья любовь', NULL, '[Куплет 1]
Am F C G
Однажды я сказал, что сохраню тебя,
Am F C G
Однажды Я сказал – солгу ли Я?
Am F C G
Горы содрогнутся и сгорит земля
Am F C G
Но с тобою вечно будет милость Моя

[Припев]
Am F
Я не человек Я не предам тебя
C G Em7
Я не брошу за порог во время дождя
Am F
Камень не подам вместо хлеба Я
C G
Если слезы на глазах Я успокою тебя

[Куплет 2]
Am F C G
Если раны кровоточат у Меня есть елей
Am F C G
Для израненного сердца для души твоей
Am F C G
Но сегодня на мгновенье Я оставлю тебя
Am F C G
Испытать и переплавить средь страданий и зла

[Куплет 3]
Am F C G
Я хочу чтоб ты был сильный закаленный солдат
Am F C G
Не дрожал перед врагами пусть трепещет ад
Am F C G
Ты еще расправишь крылья и взлетишь высоко
Am F C G
Кто сказал что побеждать так просто и легко?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=149 | photo=notion-youth-songbook | notionPageId=0422a625-287c-48ac-ad86-36d79ed84f9d | notionChordPageId=abc2bbd1-a1d8-4479-bbdb-5b9bafa64ea9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0422a625287c48acad8636d79ed84f9d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Однажды я сказал'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=149%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он здесь', 'Величие Бога', NULL, '[Куплет 1]
D Em A D D7
Он здесь, Он здесь,
G A D D7
Хочет встретиться с тобой, Он здесь.
G A
Пред Тобою, мой Господь,
F#m Hm
Преклоняются сердца,
Em A D D7
Знаю, Всемогущий Бог, что Ты здесь.

[Куплет 2]
D Em A D D7
Он здесь, Он здесь,
G A D D7
Хочет встретиться с тобой, Он здесь.
G A
Нежно глас Его звучит,
F#m Hm
Для тебя Он говорит,
Em A D D7
Свет любви Его святой всегда горит.

[Куплет 3]
D Em A D D7
Он здесь, Он здесь,
G A D D7
Хочет встретиться с тобой, Он здесь.
G A
Хочет встретиться с тобой,
F#m Hm
Чтобы дать душе покой,
Em A D D7
Двери сердца для Иисуса ты открой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=150 | photo=notion-youth-songbook | notionPageId=6d2e759a-43aa-4976-b5e8-4176660c5b9e | notionChordPageId=f6296510-eeaf-4c61-87f9-077ac158e2a9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/6d2e759a43aa4976b5e84176660c5b9e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он здесь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=150%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он не сошёл с креста', 'Пасхальные', NULL, '[Куплет 1]
Dm F Gm A
Тебя распяли, мой Господь, а Ты с креста благословлял,
Dm F A# C
Тебя хулили и кляли, а Ты им, Боже, всё прощал.
F Dm Gm A
Они с Тобою на кресте свои надежды хоронили
A# Gm A
О царстве славы на земле, о небесах же позабыли…

[Припев]
Dm F Gm A
Он не сошёл с креста, распятый Царь Своим твореньем!
Dm F Gm A
Он не сошёл с креста! Он принял смерть без сожаленья!
F A# Gm A
Он не сошёл с креста! И в муках боль превозмогая,
A# Gm A
Он взывал: «Прости им, как Я прощаю!»

[Куплет 2]
Dm F Gm A
Им нужно было всё и здесь, им нужен был земной правитель,
Dm F A# C
Они не поняли Тебя и не признали, Искупитель.
F Dm Gm A
Стекала струйкой кровь из ран, собою землю орошая,
A# Gm A
И содрогались небеса, за ходом действий наблюдая.

[Куплет 3]
Dm F Gm A
Слеза упала на ладонь, пронзенную руками грешных,
Dm F A# C
То небо плакало о Нём, рыдая тихо, безутешно.
F Dm Gm A
Отвергнут, брошен и забыт… Толпа ушла не понимая,
A# Gm A
Что в этот миг там, на кресте, Твои страданья их спасали.

[Куплет 4]
Dm F Gm A
Воскрес из мёртвых, победил ценою жизни смерти жало!
Dm F A# C
С Отцом Собою примирил Он нас — и пропасти не стало.
F Dm Gm A
Он на Себе замкнул войну добра и зла, во веки сущих,
A# Gm A
И победил! О, мой Господь! Ты — Царь царей, Бог Всемогущий!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=151 | photo=notion-youth-songbook | notionPageId=76d33fe7-0549-424b-95bd-06c60b1ca59d | notionChordPageId=faa37a59-0ed6-47eb-bce1-609bca817dac | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/76d33fe70549424b95bd06c60b1ca59d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он не сошёл с креста'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=151%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он пришёл, спасая всех', 'Пасхальные', NULL, '[Куплет 1]
Dm C
Он пришёл, спасая всех от земных тревог
A# Am Dm
Настоящий человек, настоящий Бог.
A# F Gm Dm
Самарянкой найден свет у Христовых ног
Gm Dm Am Dm
Плакал Он как человек, а прощал как Бог.

[Куплет 2]
Dm C
Буря, шторм – не виден брег. Волны бьют челнок.
A# Am Dm
На корме спит человек, шторм смиряет Бог.
A# F Gm Dm
Ад и смерть, злобу и грех победить Он смог
Gm Dm Am Dm
Умер Он как человек, а воскрес как Бог.

[Куплет 3]
Dm C
Кто к Нему свой смертный груз с верой не принёс
A# Am Dm
Тем известен Иисус, не знаком Христос.
A# F Gm Dm
Он для них философ, лекарь, гений, вождь, пророк
Gm Dm Am Dm
Им известен человек, но не ведом Бог.

[Куплет 4]
Dm C
Он пришёл, спасая всех от земных тревог
A# Am Dm
Настоящий человек, настоящий Бог.
A# F Gm Dm
Вознесён во славе вверх, Тот, Кто в яслях был
Gm Dm Am Dm
Он пришёл как человек, Богом уходил.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=152 | photo=notion-youth-songbook | notionPageId=ec59b91f-b8c2-44e4-856c-30ee2ee0f6a9 | notionChordPageId=a3f9a8eb-798e-48b2-8d34-ee455c91e990 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ec59b91fb8c244e4856c30ee2ee0f6a9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он пришёл, спасая всех'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=152%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он родился для меня', 'Рождественские', NULL, '[Куплет 1]
D F# G D
Тишина, ночное небо в домах тепло и светло
D A G
Иисус, Сын неба родился и настало в сердцах торжество
D F# G D
Вдруг Ангел явился с неба сказал всем “Радуйтесь”
D A G A
В этот день на всей планете разнеслась весть о Христе

[Припев]
D A Em Hm
Он родился для меня в ночь когда взошла звезда
G D Em A
Все заняты были своими делами но пастухам Он явился тогда
D A Em Hm
В эту чудную ночь Он пришел чтобы каждый мир с Богом нашел
G D Em A D
Сегодня есть шанс для тебя и меня Иисус ожидает всех нас.

[Куплет 2]
D F# G D
Его рождение сердце греет тебе дарит и радость и мир
D A G
С озарённым сердцем ты принеси к ногам Иисуса дары', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=153 | photo=notion-youth-songbook | notionPageId=7268a4f6-6fda-4f46-a595-c4a655e5dc61 | notionChordPageId=d822bc2e-9a68-427f-b7a8-6c2d99e9638b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7268a4f66fda4f46a595c4a655e5dc61', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он родился для меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=153%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Острое жало', 'Пасхальные', NULL, '[Куплет 1]
Острое жало коснулось ладони,
Слился со стоном удар молотка.
Брызнула кровь и мучительной болью
Сердце огнем захлестнула волна.

К древу креста уже руки прибили,
Глухо у ног молоток застучал.
Воины алчно одежды делили,
Кто то из них уже жребий бросал.

[Припев]
||: Подняли крест и повис обреченно
Царь Иудейский Иисус Назорей.
Мягкая ткань голубого хитона
Кровью залита в руках палачей. :||

[Куплет 2]
Там на Голгофе Он принял мученья,
Кровью невинной за нас заплатил.
Царь Иудейский, Сын Божий, Мессия
Двери спасенья нам, грешным открыл.

Люди, вы слышите, все это было
Там на Голгофе с Иисусом Христом,
Но смерть Иисуса не победила -
Ведь Он воскрес и на небо взошел.

[Припев]
||: Подняли крест и повис обреченно
Царь Иудейский Иисус Назорей.
Мягкая ткань голубого хитона
Кровью залита в руках палачей. :||

[Куплет 3]
Острое жало коснулось ладони,
Слился со стоном удар молотка.
Брызнула кровь и мучительной болью
Сердце огнем захлестнула волна...
Припев (модуляция):
Подняли крест и повис обреченно
Царь Иудейский Иисус Назорей.
Мягкая ткань голубого хитона
Кровью залита в руках палачей.

Только не гнев был в ответ и не мщенье,
Для искупленья лилась эта Кровь
Кротко над миром звучало прощенье
И обнимала планету Любовь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=154 | photo=notion-youth-songbook | notionPageId=50b8fefe-ed3b-4bdc-a7df-2102851374e9 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/50b8fefeed3b4bdca7df2102851374e9 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Острое жало'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=154%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отец мой, я люблю Тебя', 'Семья', NULL, '[Куплет 1]
Dm
Отец мой, я люблю Тебя
A# F
Сильней, Чем что-нибудь на свете,
F C
Ты нужен мне.
Dm
О, Иисус, Спаситель мой,
A# F
Тебе обязаны всей жизнью мы,
F C
Обязаны Тебе.
Gm A# C
Все ангелы Тебя возносят,
Gm A# C
И мы возносим лишь Тебя!

[Припев]
F C
Ты мой Господь, Ты жизнь моя,
Gm C
И я живу лишь для Тебя,
F C
Ты мой Господь, люблю Тебя,
Gm A#m Dm
Будешь со мною Ты всегда!

[Куплет 2]
Dm
И всё, что есть, Тебе отдам,
A# F
Вся жизнь в руках Твоих,
F C
Господь мой, живу для Тебя.
Dm
Все дни мои Тобой даны,
A# F
Используй их, Господь, молю Тебя,
F C
Используй для Себя.
Gm A# C
Все ангелы Тебя возносят,
Gm A# C
И мы возносим лишь Тебя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=155 | photo=notion-youth-songbook | notionPageId=0c52815f-6bce-4f28-bb2d-ce29334b1efb | notionChordPageId=b2e3f74c-292c-4122-9be3-a675bca216da | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0c52815f6bce4f28bb2dce29334b1efb', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отец мой, я люблю Тебя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=155%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Откликнется душа моя', 'Божья любовь', NULL, '[Куплет 1]
Снова по небу скучаю я,
Но знаю, Ты видишь, что в сердце моём.
Часто в мольбе призываю я
“Останься со мною. Введи в Отчий дом”

[Припев]
Откликнется душа моя на зов Небесного Отца
И голос долгожданный, я услышу, наконец.
По-новому увижу я весь мир, что окружал меня
И в сердце зазвучит тогда, мелодия небес…

[Куплет 2]
Руки Твои берегут меня -
Меня направляют, упасть не дают
Отче, святая любовь Твоя
Открыла мне двери в обитель Твою.

[Куплет 3]
Снова по небу скучаю я,
Но верю Ты примешь меня в небеса.
Буду я там, где любовь Твоя,
С Тобой я останусь в раю навсегда!
После последнего припева:
Снова по небу скучаю я…', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=156 | photo=notion-youth-songbook | notionPageId=fcbea3f5-757c-4eaf-85d5-a8a0e2843e6e | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/fcbea3f5757c4eaf85d5a8a0e2843e6e | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Откликнется душа моя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=156%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отцы', 'Семья', NULL, '[Куплет 1]
Cm Dsus D
Отцы, вы надежды на нас возлагали.
Gm F D#
Отцы терпеливо детей наставляли.
Cm Dsus D
Отцы — это мужество веры и сила,
D Gm G
Ваша любовь неизмерима.
Cm Dsus D
Отцы, мы за помощью к вам прибегали.
Gm F D#
Отцы, вы всегда нас детей понимали,
Cm Dsus D
От стрел мира злобного нас закрывали,
D Gm G
День и ночь на коленях стояли.

[Припев]
Cm D7
Молясь за счастливые крепкие семьи,
D7 Gm G
Не жалели ни силы, ни время.
Cm F
Храня огонь христианской веры,
F A#
Стали детям примером.
Cm D7 D#
Мы вам благодарны безмерно!
Cm D7 Gm
Мы вам благодарны безмерно!

[Куплет 2]
Cm Dsus D
Отцы, ваши руки в мозолях от боли,
Gm F D#
Ваш труд совершённый с огромной любовью.
Cm Dsus D
Мы чтим и в душе понимаем и ценим
D Gm G
Вашу любовь, долготерпенье.
Cm Dsus D
Отцы, как же хочется долгой вам жизни,
Gm F D#
Дойти по следам вашим прямо к Отчизне
Cm Dsus D
И стать миру этому ясной звездою,
D Gm G
Идти только узкой тропою.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=157 | photo=notion-youth-songbook | notionPageId=329487dc-7145-406f-8844-b570d39a2864 | notionChordPageId=9cb502dc-c50c-4f74-95fe-2f02720cd209 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/329487dc7145406f8844b570d39a2864', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отцы'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=157%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отчаянья дожди', 'Пасхальные', NULL, '[Куплет 1]
Вновь дом Твой пуст, торжественный канон
Сменился тихой утренней молитвой.
Но сила вечных слов, что я Тобой спасён,
Жизнь делает немыслимо счастливой.

[Припев]
Отчаянья дожди ещё идут окрест
И как свеча моя надежда тает
Но вот завесу тьмы пронзает старый крест
Где боль моя навеки умирает

[Куплет 2]
И пусть свинцом по небу разлились
Неведомые миру треволненья
Твоя любовь меня на крыльях веры ввысь
Вновь поднимает вопреки сомненьям

[Куплет 3]
Не властна смерть над светлою душой
Хотя сквозь мрак ещё не видно солнца
Мне и среди невзгод с Тобою хорошо
Я буду петь доколе сердце бьётся', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=158 | photo=notion-youth-songbook | notionPageId=9f351ae4-3dae-4f2b-a819-a4871d37dd61 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/9f351ae43dae4f2ba819a4871d37dd61 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отчаянья дожди'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=158%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отче мы просим', 'Исцеление', NULL, '[Куплет 1]
D A F#m Hm
Отче, мы просим: "Ты приди,
G A G A
Землю исцели" мы сердцами вместе,
F# Hm
Пусть слава Твоя будет в нас,
G Em A A7
И узнает мир, что Иисус – Господь!

[Припев]
D F#m G A7
Мы в один голос прославим все Тебя
D F#m G A
Мы в один голос всем расскажем что ты Царь
F# Hm G
Мы в один голос, гармонией любви,
Em A D
И мы молим, Бог, Ты нас объедини.

[Куплет 2]
D A F#m Hm
Время настало чтоб сердца
G A G A
Объединить в хвале. Имя Иисуса
F# Hm
Прославим мы на всей Земле,
G Em A A7
И узнает мир, что Иисус – Господь!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=159 | photo=notion-youth-songbook | notionPageId=fd30492e-8990-4a28-8317-413924d623db | notionChordPageId=ab6d4a31-6387-47dc-b57c-9a29d4e2c827 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fd30492e89904a288317413924d623db', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отче мы просим'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=159%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отче Небесный, стою пред Тобою', 'Прощение', NULL, '[Куплет 1]
G Em C D
Отче Небесный, стою пред Тобою
G
Такой, как есть.
G Em C D
Руки к Тебе возношу я покорно,
Em
Прости мой грех.
C Em D
Сердце измени, я жажду быть таким, как Ты,
C G
Таким, как Ты.

[Припев]
D C
Ты есть свет, Ты есть святость,
D G
На веки я буду Твой.
D C
Ты – любовь, Ты даришь милость,
D G
Навеки я буду Твой.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=160 | photo=notion-youth-songbook | notionPageId=c6ac7caa-5794-4add-937e-82c737cd400a | notionChordPageId=52042bff-a3ae-41f4-be24-42537b6a3c43 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c6ac7caa57944add937e82c737cd400a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отче Небесный, стою пред Тобою'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=160%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Первый вздох', 'Семья', NULL, '[Куплет 1]
D G D
Первый вздох — ты родился, Я был там,
F#m G A
Ты впервые плакал — Я внимал слезам,
D F# G
Хоть ты Меня не видел, но Я рядом был,
D A D
Хочу, чтоб ты об этом не забыл.

[Припев]
D G D
Ты в руках Моих всегда, как дитя,
F#m G A
Вся любовь Моя лишь только для тебя,
D F# G
Когда ты повзрослеешь, даже и тогда
D A D
Ты в руках Моих всегда, как дитя.

[Куплет 2]
D G D
Первый раз на коленях ты стоял —
F#m G A
Я был рядом и словам твоим внимал.
D F# G
«Прости, Отец, я каюсь», — в молитве ты просил,
D A D
Я снял твой грех, обнял и всё простил.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=161 | photo=notion-youth-songbook | notionPageId=5cad1add-0faf-4fa1-9c18-e814afe90e1f | notionChordPageId=5d4f8e27-8d2f-488d-acb4-44644fd3fc1e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5cad1add0faf4fa19c18e814afe90e1f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Первый вздох'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=161%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'По ночам', 'Утешение и ободрение', NULL, '[Куплет 1]
C G C
По ночам часто город мне снится,
F G Em Am
Пораженный его красотою,
F G Em Am
Начинаю я Богу молиться,
F G C
Чтоб однажды увидеть такой.

[Припев]
F G Em Am
Там ворота двенадцать жемчужин,
F G Em Am
У ворот куда входит народ,
F G Em Am
Стынет жемчуг в весенних лужах
F G C
И никто его не берет.

[Куплет 2]
C G C
Топчут ноги земных пилигримов,
F G Em Am
Золотых тротуаров литье
F G Em Am
И никто не хватает зубило,
F G C
Чтоб отбить и иметь свое.

[Куплет 3]
C G C
Я уверен что боль исчезнет,
F G Em Am
Когда встретимся мы с тобой,
F G Em Am
Ты введешь меня в этот город
F G C
По дороге его золотой.

[Куплет 4]
C G C
Можно там, как бы это не странно,
F G Em Am
Безнаказанно делать добро.
F G Em Am
А пока я, устав от обмана
F G C
И от боли твержу одно:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=162 | photo=notion-youth-songbook | notionPageId=e1657004-8cad-4361-bb19-8a8b18baeff6 | notionChordPageId=358a9ba2-8b3a-4328-bd02-92132210a073 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e16570048cad4361bb198a8b18baeff6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'По ночам'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=162%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'По преданью отцов', 'Божья любовь', NULL, '[Куплет 1]
Am F
По преданью отцов человек охранял
Dm E Am
На скрижалях Твое откровенье.
Am F
Год за годом его ветер в пыль превращал,
Dm H E
Чтоб забыло о Боге творенье.

[Припев]
Am F
На скрижалях сердца напиши
C G C G
Алой кровью для моей души,
Am F
Чтобы помнил о любви Твоей
C E Am
Вспоминая раны от гвоздей.

[Куплет 2]
Am F
Но не букву Закона Господь подарил
Dm E Am
Благодати никто не разрушит.
Am F
Те, кто искренне Богу всем сердцем служил,
Dm H E
Не на камне писали, а в души.

[Куплет 3]
Am F
Боже мой, сотвори веру твёрдой, как камень
Dm E Am
Дабы жизнью своей о Тебе рассказать
Am F
Мною правь изнутри и душой и руками,
Dm H E
Чтобы в нужный момент все, что есть, мог отдать

[Куплет 4]
Am F
Никакая беда почерк Твой не сотрет,
Dm E Am
Даже если гоненье вернется
Am F
Воду жизни душа и в пустыне найдет,
Dm H E
И любовью Твоей напьется.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=163 | photo=notion-youth-songbook | notionPageId=eed61b49-4dd3-4b6b-b089-0e9f831b50df | notionChordPageId=af3117d3-71a4-4180-bf54-7eb06124f8c8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/eed61b494dd34b6bb0890e9f831b50df', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'По преданью отцов'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=163%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'По страницам Библии старой', 'Утешение и ободрение', NULL, '[Куплет 1]
G C G D
По страницам Библии старой я шагаю в город святой.
G C Am D
И хотя мои ноги устали я по прежнему весел душой.
Em Hm C G
Не смущают меня ураганы, даже сильные бури в пути.
C D G C Am C G
Отдохну и снова встану в город святой идти.

[Припев]
G D
Идти в слякоть и дождь,
Em D C
Идти не уставать,
G Am
Идти туда где Господь,
C D
Он там меня будет ждать.

[Куплет 2]
G C G D
Искушения испытания не заставят меня позабыть
G C Am D
День когда я давал обещание Иисусу всегда верным быть.
Em Hm C G
Я под знаменьем Божьим встану Его посох меня укрепит.
C D G C Am C G
Я пойду и не устану Бог мой мне говорит.

[Куплет 3]
G C G D
И когда я Господа встречу я пойму - это было не зря.
G C Am D
Он мои мозоли излечит примет нежно в объятья меня.
Em Hm C G
Там не буду я больше томиться от невзгод и болезней земных.
C D G C Am C G
Там увижу родные лица дошедших друзей родных.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=164 | photo=notion-youth-songbook | notionPageId=40d20bab-087a-4054-b1a6-fc5b0cb530ba | notionChordPageId=5fd0db32-2e7d-4cb6-bc9e-77382a098842 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/40d20bab087a4054b1a6fc5b0cb530ba', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'По страницам Библии старой'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=164%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Под защитой твоих крыл', 'Спасение', NULL, '[Куплет 1]
Буду жить под защитой Твоих крыл,
Буду я в мире Божией любви,
Ночь настанет, и я не убоюсь,
Когда я под защитой Твоих крыл

[Припев]
Под защитой, под защитой,
Под защитой Твоих крыл.
Под защитой, под защитой,
Под защитой Твоих крыл.

[Куплет 2]
Я спасен под защитой Твоих крыл,
Мой покой под охраною Твоей
Пусть летят стрелы, я не устрашусь,
Когда я под защитой Твоих крыл.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=165 | photo=notion-youth-songbook | notionPageId=e12331b6-168b-4911-baf1-51c1961bccde | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/e12331b6168b4911baf151c1961bccde | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Под защитой твоих крыл'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=165%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Подобно библейским пророкам', 'Молитвенные', NULL, '[Куплет 1]
G C
Подобно библейским пророкам
G D G
Хотим Слово Божье нести
G C
О праведности возвещая смело,
G D G
Как в дни Моисея, Ильи
H Em
Порою нас ждут испытанья,
C D
Нелегок наш путь в небеса,
G C
Но все же, как голос Иоанна, взываем:
G D G
«Готовьте все путь для Христа!»

[Припев]
G C
Ведь Он грядет к нам на облаках,
G D
Как солнце восстает любовь в Его лучах,
G C
О друг, воспой! Прощенье Бог дает!
G D G
Спасение с горы Сион придет!

[Куплет 2]
G C
Подобно библейским пророкам
G D G
Мы будем в проломе стоять.
G C
Построим молитвами стену с верой
G D G
И будем Творца прославлять.
H Em
Взгляните! Поля побелели,
C D
Уж жатва созрела давно.
G C
Трудитесь же так, как велел Он, смело,
G D G
Неся людям Слово Его!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=166 | photo=notion-youth-songbook | notionPageId=c467709d-106c-43a3-aec7-bb71ee2d3692 | notionChordPageId=62af9fe7-c025-4dce-b9a8-e8dba1d7cbcd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c467709d106c43a3aec7bb71ee2d3692', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Подобно библейским пророкам'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=166%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пока огонь любви чудесной', 'Исцеление', NULL, '[Куплет 1]
A#
Пока огонь любви чудесной
A# Cm
Горит в груди волной живой,
F
Мы силы юные совместно
F A#
Употребим на труд святой.

[Припев]
A# Cm F A#
//: Юность прекрасная, молодость ясная!
A# D#
Сил, здоровья не жалей, ( для людей )
F A#
К Богу духом пламеней! ( всё сильней ) ://

[Куплет 2]
A#
Пока сильны стремленья к небу
A# Cm
И много сил, здоровья в нас,
F
Друзья, распределим умело
F A#
Для славы Божьей всякий час!

[Куплет 3]
A#
Ведь даже старцы вспоминают
A# Cm
С улыбкой светлой на устах
F
Порывы юности святые,
F A#
О всех друзьях и о трудах.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=167 | photo=notion-youth-songbook | notionPageId=68e26ee3-e791-4ada-81be-404afb9f3425 | notionChordPageId=0fa86bb3-03b2-4ff7-9934-2d8846208dd9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/68e26ee3e7914ada81be404afb9f3425', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пока огонь любви чудесной'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=167%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Покажите мне любовь без Иисуса,', 'Пасхальные', NULL, '[Куплет 1]
Em Am
Покажите мне любовь без Иисуса,
H7 Em H7
Где она бы на земле жила одна,
Em Am
Ведь любви на свете нет без Иисуса,
H7 Em H7
Ведь она Его за нас, на крест вела.

[Припев]
Am D G C
Бог есть любовь – совокупность совершенства.
Am H7 Em E
Бог есть любовь – полнота и глубина.
Am D G C
Бог есть любовь – и наивысшее блаженство.
Am D Em
Бог есть любовь – Он все во всем!

[Куплет 2]
Em Am
Ведь Отец на небе так людей всех любит,
H7 Em H7
Что Единственного Сына в мир послал.
Em Am
Ты приди к Нему сейчас, Он не погубит:
H7 Em H7
За тебя уже Иисус, Его Сын, страдал.

[Куплет 3]
Em Am
Не найдешь, ты милый друг, любви без Бога,
H7 Em H7
Нет её нигде на свете без Христа.
Em Am
Ложных чувств здесь, на земле, стремлений много,
H7 Em H7
Но а истинна любовь лишь у Христа.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=168 | photo=notion-youth-songbook | notionPageId=febf0039-214d-46a7-85e5-9a50152f5ef4 | notionChordPageId=951d6231-b295-4966-9d9b-e6b2db5d4ac9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/febf0039214d46a785e59a50152f5ef4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Покажите мне любовь без Иисуса,'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=168%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Полдороги в небо', 'Вера и упование', NULL, '[Куплет 1]
Cm
Мы с вами столько вёрст уже прошли,
Fm G Cm
Пусть мало было в них тепла и неги,
D# C
Зато теперь осталось позади
Fm Cm
По полдороги в небо, по полдороги в небо,
G Cm C
По полдороги в небо.

[Куплет 2]
Cm
Тревожно, что замедлили шаги,
Fm G Cm
Что в ком-то тает робкая надежда,
D# C
А ведь у нас осталось впереди
Fm Cm
По полдороги в небо, по полдороги в небо,
G Cm C
По полдороги в небо.

[Куплет 3]
Cm
Кому-то надо руку протянуть,
Fm G Cm
Кого-то надо бережно заметить,
D# C
Как страшно потерять кого-нибудь
Fm Cm
На полдороги в небо, на полдороги в небо,
G Cm C
На полдороги в небо.

[Куплет 4]
Cm
Не дай, Господь, кому из нас вздремнуть,
Fm G Cm
Не дай запачкать белые одежды.
D# C
Осталось, может, несколько минут
Fm Cm
От полдороги в небо, от полдороги в небо,
G Cm C
От полдороги в небо.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=169 | photo=notion-youth-songbook | notionPageId=e145283c-e29f-4d0f-a9aa-44c3a3e872bb | notionChordPageId=0debae40-6295-4e1e-98c5-2b4528a65466 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e145283ce29f4d0fa9aa44c3a3e872bb', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Полдороги в небо'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=169%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Помоги мне, Боже', 'Семья', NULL, '[Куплет 1]
Em Am
Помоги мне в этой жизни благодарной, Боже, быть,
H C H
Даже если очень больно будут волны жизни бить,
Am D G C
Если сердце истомится, переполненно скорбей,
Am G C H
Не роптать хочу — молиться и любить Тебя сильней.

[Припев]
Em G
Через все мои скитанья, через раны и всю боль
Am H Em C
Вера шаткаю была, но Ты не прошёл меня,
Am G C
Своей любящей рукою подымал
Am H Em E
И в отчаяньи погибнуть не давал.
Am H Em C
Ты за Собой меня звал, меня так долго Ты ждал
Am H Em E
И так нежно в моё сердце Ты стучал.
Am H Em C
Ты меня не забыл, Ты меня не забыл,
Am H Em
Ты поднял меня и жизнь вновь подарил.

[Куплет 2]
Em Am
Если будет взор слезами затуманен вдруг в пути,
H C H
Дай сердечными очами видеть милости Твои,
Am D G C
Уразуметь Твою дай волю и за всё благодарить,
Am G C H
Будет радостно иль больно, помоги мне верной быть.

[Куплет 3]
Em Am
О Твоей любви великой рассказать хочу я всем,
H C H
Ты один — моя отрада, и Тобой лишь я живу.
Am D G C
И когда так непонятна Твоя воля мне порой,
Am G C H
Всё же следовать я буду неуклонно за Тобой.

[Мост]
О, Христос, лишь в Тебе нашла я счастье,
Быть с Тобой всегда, пусть и горе, и ненастье,
Не страшна беда. Чего душе моей бояться?
Ты никогда, Отец, мне не дашь поколебаться.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=170 | photo=notion-youth-songbook | notionPageId=2146b5d9-af09-4605-82b1-45af9dfbf5e2 | notionChordPageId=19c921c5-e2f9-4b87-a094-ad5e82439c32 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2146b5d9af09460582b145af9dfbf5e2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Помоги мне, Боже'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=170%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Помолись обо мне', 'Пасхальные', NULL, '[Куплет 1]
Dm
Помолись обо мне, мой друг.
Gm7
Помолись, когда я в дороге,
C F7
Чтобы где-то когда-то вдруг
Gm A7
Я совсем не забыл о Боге.
F D
Помолись обо мне вдали,
Gm C
Помолись, когда мы в разлуке,
F7 A#
Чтобы здесь на краю земли
Gm A7
Как Пилат не умыл я руки.

[Куплет 2]
Dm
Помолись обо мне у креста,
Gm7
Чтоб как Петр на скрещении улиц
C F7
Не отрекся я от Христа
Gm A7
Под кудахтанье здешних куриц…
F D
Помолись половодьем слов,
Gm C
Помолись, без единого слова,
F7 A#
Чтоб гвоздями своих грехов
Gm A7
Я не впился в тело Христово.

[Куплет 3]
Dm
Помолись обо мне в тиши,
Gm7
Помолись обо мне и в шуме,
C F7
Чтоб на радость врагам души
Gm A7
Злым разбойником я не умер.
F D
Устремляясь глазами ввысь
Gm C
Прохожу я над самым адом…
F7 A#
Молча, шепотом или взглядом,
Gm A7
Где бы ни был я, помолись, помолись…..', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=171 | photo=notion-youth-songbook | notionPageId=96544a04-5b5d-4860-9f7f-796008defdca | notionChordPageId=720aaecc-d5f4-47e3-bfff-1dad5d0236c2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/96544a045b5d48609f7f796008defdca', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Помолись обо мне'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=171%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Посмотри на Небо', 'Пасхальные', NULL, '[Куплет 1]
Am                                      Dm
Если ты в пути продрог и не знаешь где ты.
G                                    C                            E
Если силы не сберёг и не видишь света
Am                                    Dm
Если страшен этот час и тревога гложит.
F                                             Dm                      G
К Богу обратись сейчас - Он тебе поможет.

[Припев]
Am                              Dm
||: Посмотри на Небо, посмотри на Небо.
G             C  E
Никогда ты не был один. :||

[Куплет 2]
Am                                            Dm
Труден к Богу первый шаг, но Отец Небесный
G                                          C                                      E
На Своих несёт плечах тяжесть смерти крестной.
Am                               Dm
А тебя в Своей руке Он с любовью держит,
F                                    Dm                          G
Приготовил Он тебе радость и надежду.

[Припев]
Am                              Dm
||: Посмотри на Небо, посмотри на Небо.
G             C  E
Никогда ты не был один. :||
Am Dm G C E
// Проигрыш //
Am Dm F E
Мост (ускоренно):
Am                              Dm
||: Посмотри на Небо, посмотри на Небо.
G             C  E
Никогда ты не был один. :||
Am Dm F E
// Проигрыш //
Am Dm F E
Припев (замедленно):
Am                              Dm
Посмотри на Небо, посмотри на Небо.
G             C  E
Никогда ты не был один.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=172 | photo=notion-youth-songbook | notionPageId=6f7e1f3b-5265-49cb-a521-2b680f7931de | notionChordPageId=d7b5f494-b67f-4c84-ba31-74f181270666 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/6f7e1f3b526549cba5212b680f7931de', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Посмотри на Небо'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=172%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Праздник жатвы', 'Благодарение', NULL, '[Куплет 1]
Am Dm
Снова год пролетел, День Жатвы настал…
E Am
Перед Богом Отцом ты снова предстал.
Am Dm
Что ты скажешь Ему, как хвалу вознесешь?
E Am
И какие слова в этот день ты найдёшь?

[Припев]
Dm Am
И в праздник жатвы славу Богу воздай
E Am
Благодарением жизнь свою наполняй
Dm Am
И в праздник жатвы взгляни на свои пути
E Am
Господь, помилуй помилуй нас грешных прости

[Куплет 2]
Am Dm
Вспомни милости, что Бог тебе посылал,
E Am
На молитвы когда Он, твои, отвечал.
Am Dm
Каждый миг на путях сберегал и хранил
E Am
Не однажды тебя Он от зла защитил

[Куплет 3]
Am Dm
Когда вдруг, получил больше, чем ты просил,
E Am
Когда враг стороною тебя обходил -
Am Dm
“Это - Бог за тебя!” - говорили вокруг…
E Am
Он за нас, потому, что Он наш лучший Друг!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=173 | photo=notion-youth-songbook | notionPageId=41247341-4f45-4b19-ac75-47474cadfce8 | notionChordPageId=120a32a3-2593-4b08-aed4-dadba12615fa | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/412473414f454b19ac7547474cadfce8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Праздник жатвы'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=173%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Превыше силы', 'Пасхальные', NULL, '[Куплет 1]
C D G
Превыше силы, превыше царств,
C D G
Превыше славы и всех земных богатств,
C D Em
Превыше мудрости и всех путей людских
Am C D
Великий Бог, Владыка всей земли.
C D G
Превыше солнца и всех планет,
C D G
Превыше всех чудес, какие видел свет,
C D Em
Превознесён над небом и землёй,
Am C H
И нет пути прекраснее, чем Твой.

[Припев]
G Am D G
Мира грех Ты вознёс на крест,
G Am D G
Был распят, но в третий день воскрес,
Em D C G
Как цветок, растоптанный в пыли,
C D
Отвержен был, но всё простил,
G Am D G
В небесах - Всемогущий Бог,
G Am D G
На земле - отверженный цветок,
Em D C G
Я люблю смотреть в глаза Твои,
C D G
Бесценный дар для меня – это Ты!

[Куплет 2]
C D G
Ты над всеми и во всём
C D G
Вечной славой и светом озарён,
C D Em
Выше всех престолов и царей,
Am C D
Каждый миг Ты помнишь обо мне.
C D G
Ты надежду подарил,
C D G
Ты навеки, и я в руках Твоих,
C D Em
Каждый день восходит, как заря,
Am C H
Милость безграничная Твоя.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=174 | photo=notion-youth-songbook | notionPageId=816eec2e-d32e-4ab6-9d95-5cc789a99f4b | notionChordPageId=46733da3-a311-4747-bd57-feab7f1353e5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/816eec2ed32e4ab69d955cc789a99f4b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Превыше силы'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=174%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Придите к Иисусу', 'Рождественские', NULL, '[Куплет 1]
Em Hm C G C D G H
Все вокруг заняты были своим, и только лишь три мудреца
Em Hm C G C D
Пришли поклониться ребёнку в яслях, посланники Бога Отца.
Em Hm C G C D G H
Милый малыш сладко дремал на материнских руках,
Em Hm C G C D
А в небе тогда сияла звезда, пели Ангелы на небесах.

[Припев]
G D
Придите к Иисусу любовь обрести,
C Am D
Он наш Спаситель, Сын Бога любви.
G C Am
Придите к Иисусу, Царю Царей,
G D G
Он ожидает, чтоб дать вам любовь, придите скорей.

[Куплет 2]
Em Hm C G C D G H
Там в небольшом городке Вифлеем малыш Иисус был рождён.
Em Hm C G C D
Мама Мария растила Его, с любовью заботясь о Нём.
Em Hm C G C D G H
В яслях в ту ночь Иисус сладко спал под нежным покровом небес,
Em Hm C G C D
И в Рождество, в день рожденья Его, услышишь ты Ангелов песнь.

[Мост]
Войди в моё сердце, любовь подари,
Иисус мой Спаситель, Сын Бога любви.
Войди в моё сердце, Иисус — Царь с небес,
Ты — наша жизнь и Ты истинный путь, Ты любишь нас всех.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=175 | photo=notion-youth-songbook | notionPageId=fa205362-f23e-4d7e-8447-878f011f35a2 | notionChordPageId=b36a4fc3-f0e0-4c08-8a98-b54ef23d8cda | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fa205362f23e4d7e8447878f011f35a2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Придите к Иисусу'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=175%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Прославим Бога', 'Семья', NULL, '[Куплет 1]
Em Am H Em
Прославим Бога одной семьёю,
Am D G E
Направим взор свой к небесам.
Am Em
Кто любит Господа, кто любит Господа
Am H Em E7
Соединяйтесь, песня одна.

[Куплет 2]
Em Am H Em
Когда-то были совсем чужие,
Am D G E
Теперь для Бога уже свои.
Am Em
Кто любит Господа, кто любит Господа
Am H Em E7
В белых одеждах встретитесь вы!

[Куплет 3]
Em Am H Em
Нас утешает святое Слово,
Am D G E
Иисус сказал, к тому придёт,
Am Em
Кто любит Господа, кто любит Господа
Am H Em E7
Обитель чудную в сердце найдёт

[Куплет 4]
Em Am H Em
Проходят годы, стареют люди,
Am D G E
Но улыбнитесь, звучат слова:
Am Em
Кто любит Господа, кто любит Господа
Am H Em E7
Готовы встретить вас небеса', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=176 | photo=notion-youth-songbook | notionPageId=1e114234-a094-4ed1-8550-b0b1278aac17 | notionChordPageId=00c7a531-8e05-4a0d-8874-e359fe287355 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1e114234a0944ed18550b0b1278aac17', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Прославим Бога'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=176%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Прости меня, Боже', 'Пасхальные', NULL, '[Куплет 1]
Em Am H7 Em
Прости меня, Боже, прости, я молю,
Em Am D G
Прости, что так поздно к Тебе прихожу,
Am D G Em
Прости, что я раньше Тебя не познал
Am Em E7
И друга иного тогда я избрал.
Am D G Em
Прости, что я раньше Тебя не познал
Am H7 Em
И друга иного тогда я избрал.

[Куплет 2]
Em Am H7 Em
Прости, что мой разум с Тобой воевал,
Em Am D G
Прости, что Тебя я страдать заставлял,
Am D G Em
Прости, что я скорби Тебе причинял
Am Em E7
И дерзко Любовь на кресте распинал.
Am D G Em
Прости, что я скорби Тебе причинял
Am H7 Em
И дерзко Любовь на кресте распинал.

[Куплет 3]
Em Am H7 Em
Но Ты пробудил меня к жизни иной
Em Am D G
И сердца коснулся Своею рукой,
Am D G Em
Глаза мне открыл Ты на пройденный путь,
Am Em E7
В неверье, в грехах мне не дал утонуть.
Am D G Em
Глаза мне открыл Ты на пройденный путь,
Am H7 Em
В неверье, в грехах мне не дал утонуть.

[Куплет 4]
Em Am H7 Em
И вот я в молитве стою пред Тобой,
Em Am D G
Веди меня, Боже, Своею рукой!
Am D G Em
Я всю свою жизнь посвящаю Тебе,
Am Em E7
Ты только не дай мне погибнуть в борьбе.
Am D G Em
Я всю свою жизнь посвящаю Тебе,
Am H7 Em
Ты только не дай мне погибнуть в борьбе.

[Куплет 5]
Em Am H7 Em
И я обещаю Тебя прославлять
Em Am D G
И словом и делом Тебя восхвалять,
Am D G Em
Чтоб люди увидели свет Твой во мне
Am Em E7
И, светом влекомые, шли все к Тебе.
Am D G Em
Чтоб люди увидели свет Твой во мне
Am H7 Em
И, светом влекомые, шли все к Тебе.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=177 | photo=notion-youth-songbook | notionPageId=82339dfc-6459-424d-92b3-5e3b1a229569 | notionChordPageId=1c990b02-96b4-4afb-b90b-66461f8e3a8e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/82339dfc6459424d92b35e3b1a229569', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Прости меня, Боже'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=177%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Просыпаюсь на заре', 'Вера и упование', NULL, '[Куплет 1]
D G
Просыпаюсь на заре
A D
И стремлюсь, мой Бог, к Тебе.
D G
Верю, слышишь Ты меня,
A D
Иисус, люблю Тебя.

[Припев]
G A D Hm
//: Я ищу Твои пути и хочу по ним идти,
Em A D D7
Надо мной, Господь, Твоя рука. ://

[Куплет 2]
D G
Вижу все Твои дела
A D
И поёт душа моя.
D G
Каждый день к Тебе ведёт,
A D
В сердце праведность живёт.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=178 | photo=notion-youth-songbook | notionPageId=7c9f5f35-ac63-43b3-a5f2-1d2218b65a7d | notionChordPageId=4ecb1b2d-63a7-4362-8f54-c5511181e0bb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7c9f5f35ac6343b3a5f21d2218b65a7d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Просыпаюсь на заре'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=178%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пусть Он войдет', 'Рождественские', NULL, '[Куплет 1]
О взгляни! Открыты покровы небес —
Детский плач, над девой звезды яркий блеск!
И ожили пророка слова
О надежде, что в ясли сошла.
О, распахни врата, впусти Царя Христа!

[Припев]
||: Пусть Он войдет, Христос войдет!
Приготовьте место для Царя! :||

[Куплет 2]
С нами Бог! Мессия для нас рожден.
Наш Творец исполнил пророчества в Нем.
Яркий свет во тьме ночной,
Тем, кто жаждет — Источник живой.
Услышь и обратись: Он истина и жизнь!

[Припев]
||: Пусть Он войдет, Христос войдет!
Приготовьте место для Царя! :||

[Куплет 3]
Слышишь стук, пронзивший холодную ночь?
Он пришел! Не гони Царя славы прочь!
Ясли, крест и гроб в скале –
Божий путь любви к Земле.
Он воскрес и вновь придет! Царь Царей вовек живет!

[Припев]
||: Пусть Он войдет, Христос войдет!
Приготовьте место для Царя! :||
Приготовьте место для Царя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=179 | photo=notion-youth-songbook | notionPageId=6b3d73a4-9721-4e20-bd6e-34aaa0c59f5e | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/6b3d73a497214e20bd6e34aaa0c59f5e | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пусть Он войдет'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=179%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пусть светит солнце', 'Пасхальные', NULL, '[Куплет 1]
F C Dm
Пусть светит солнце и дождь идёт,
A# C F
Душа моя дышит и сердце поёт.
C Dm
Меня любит Бог, Господь всей земли,
A# C F
Он ждёт и тебя, но где же ты?

[Припев]
F C Dm
Услышьте все: Господь – любовь
A# C F
С Голгофы льётся святая кровь
C Dm
Он любит меня и Он любит тебя,
A# C F
Он наш Отец, а мы – семья.
F C
Мой Бог - праведный, святой!
C Dm
Мой Бог – не идол, Он живой!
Dm A#
Мой Бог удалил боль и грусть!
C F
Мой Бог – Господь Иисус!!!

[Куплет 2]
F C Dm
Со мною Он везде и всегда,
A# C F
Он не покинет меня никогда.
C Dm
И если имя Его призовёшь,
A# C F
То счастье, любовь и мир обретёшь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=180 | photo=notion-youth-songbook | notionPageId=d4aac228-88d0-46a4-ace9-8828b3698426 | notionChordPageId=f36f0541-3003-494e-8c84-1bfe88ae81c7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d4aac22888d046a4ace98828b3698426', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пусть светит солнце'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=180%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пусть угасло небо', 'Божья любовь', NULL, '[Куплет 1]
Am F Am F
Пусть угасло небо, пусть померк рассвет.
Am F Am F
Пусть умолкли люди, пусть молчат в ответ
F G
На любовь Твою.

[Припев]
Am F C
Но шелестом дождя, песнею ручья
G Am
Для Тебя, Господь,
Am F C
Из сердца в небеса льется песнь моя.
G Am
Песня без конца.

[Куплет 2]
Am F Am F
Да, кругом раздоры, да, и Ты забыт.
Am F Am F
Люди прочь уходят в путь, что тьмой покрыт.
F G
Где и Ты забыт.

[Куплет 3]
Am F Am F
Ты придёшь, и навсегда исчезнет грех.
Am F Am F
Там, где темнота была, сияет свет.
F G
Вечный Божий свет.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=181 | photo=notion-youth-songbook | notionPageId=5fb33616-75f9-4fd7-8bb2-e9d970b27972 | notionChordPageId=de9aec53-1aa8-4a46-9672-9840f794e074 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5fb3361675f94fd78bb2e9d970b27972', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пусть угасло небо'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=181%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Путь на Голгофу далёк', 'Пасхальные', NULL, '[Куплет 1]
Путь на Голгофу далёк,
Путь на Голгофу так труден
Жаркое солнце печёт,
"Распни"- злобно требуют люди

[Припев]
Смотрите, смотрите, небесный народ,
Как люд на распятье Иисуса ведёт,
И кровь Его, святую, проливает,
Хоть Он им всем прощение даёт

[Куплет 2]
Весь изувечен толпой,
К месту, где будет распятым,
Всходит Он, словно на трон,
К миру любовью объятый

[[Припев]]

[Куплет 3]
Нам Бог свою жизнь отдал,
Всех Он с любовью прощает
Но и по сей день Его
Люди в сердцах распинают
[Припев - 2 раза]
И кровь Его, святую, проливает,
Хоть Он им всем прощение даёт...', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=182 | photo=notion-youth-songbook | notionPageId=8da57a79-957d-45c9-8c4e-39e4562c8cf6 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/8da57a79957d45c98c4e39e4562c8cf6 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Путь на Голгофу далёк'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=182%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пшеница и плевелы', 'Пасхальные', NULL, '[Куплет 1]
Dm A
Пшеница и плевелы, так мало времени
A# A G A
Осталось вместе вам расти.
Dm
Бог видит ваши сердца, ваши пути,
C F Gm Asus A
Ничего не скрыть, настанет час вас отделить.
Dm
Приготовил палач свои гвозди,
A
Режет нож виноградные грозди,
A# A
И ручьём потекла из ладоней кровь.
A# Asus A
Там, на Голгофе, пред толпою людей
A# Gm A
Божий Сын в небо к Богу взывает:

[Припев]
Gm F
«Да пребудет воля Твоя, Боже, воля Твоя!
Gm G A
В этот день, страшный день услышь Меня!
A# Gm A G A
Я проливаю за них в этих муках
A# Gm A
Кровь Мою, кровь Мою!»

[Куплет 2]
Dm A
Пшеница и плевелы, так мало времени…
A# A G A
Вот Божий серп пожнет поля.
Dm
От страха вздрогнет земля, эта земля,
C F Gm Asus A
Час суда придёт, когда Господь с небес грядёт.
Dm
Бог отделит пшеницу от плевел,
A
И спасен будет тот, кто доверил
A# A
Своё сердце Христу на пути земном.
A# Asus A
Кто жил беспечно, тот сожжется огнём.
A# Gm A
Стань зерном, чтобы с Богом быть вечно.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=183 | photo=notion-youth-songbook | notionPageId=28b19b44-6364-4b0f-a2b5-c3c6994de10e | notionChordPageId=c71ec666-396c-4d27-8ba1-690b45eac365 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/28b19b4463644b0fa2b5c3c6994de10e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пшеница и плевелы'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=183%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Радость находится', 'Спасение', NULL, '[Куплет 1]
E C#m
Радость находится в сердце у того,
A H
Чьим Спасителем стал Иисус.
E C#m
Истинный мир для души своей нашел
A H7
Тот, которого спас Иисус.

[Припев]
E C#m
О, чувство самое драгоценное,
A E
Что может дать Господь.
A H7 E
Это любовь того, которого спас Иисус.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=184 | photo=notion-youth-songbook | notionPageId=5fe8d04b-5701-466f-ba50-8f613ec53d78 | notionChordPageId=d5c83588-2a1b-49af-9c96-ad73ecbbed60 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5fe8d04b5701466fba508f613ec53d78', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Радость находится'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=184%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Раньше жил я во грехах', 'Свадебные', NULL, '[Куплет 1]
Dm Gm Dm
Раньше жил я во грехах, в горе, болях и скорбях,
Dm A
Никогда не думал я о вечности.
Dm Gm Dm
Но Иисус нашел меня, разорвал все узы зла,
Dm A Dm
Полон я теперь небесной радости!
Dm Gm C F
Я свободен, я свободен, я свободен от неправды и греха!
Dm Gm Dm
Иисус нашел меня, разорвал все узы зла.
Dm A Dm
Полон я теперь небесной радости!

[Куплет 2]
Dm Gm Dm
Слово Божье учит нас: Дух Господень не погас,
Dm A
Силу даст Он возвещать всем о Христе.
Dm Gm Dm
Тот Божественный огонь, с неба посланный Отцом,
Dm A Dm
Наделяет силой слабых на земле.
Dm Gm C F
Он пылает, да пылает, Дух Святой зажег огонь в моей душе.
Dm Gm Dm
Тот Божественный огонь, с неба посланный
Dm A Dm
Отцом, Наделяет силой слабых на земле.

[Куплет 3]
Dm Gm Dm
Если болен ты, друг мой, обратись к Христу с мольбой,
Dm A
Удалит Он немощь и печаль твою.
Dm Gm Dm
Что угодно пусть болит. Он здоровье возвратит.
Dm A Dm
Кровь Христова исцеление дарит.
Dm Gm C F
Кровь Христова, Кровь Христова и сегодня исцеляет всех больных.
Dm Gm Dm
Что угодно пусть болит. Он здоровье возвратит,
Dm A Dm
Кровь Христова исцеление дарит.

[Куплет 4]
Dm Gm Dm
Вот смоковница цветет, скоро наш Господь придет,
Dm A
Чтоб забрать свою невесту в небеса.
Dm Gm Dm
И конец придет скорбям, что за радость будет там!
Dm A Dm
Друг, готов ли встретить Господа Христа?
Dm Gm C F
Ты готов ли, ты готов ли? Друг, готов ли ты покинуть этот мир?
Dm Gm Dm
И конец придет скорбям, что за радость будет там!
Dm A Dm
Друг, готов ли встретить Господа Христа?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=185 | photo=notion-youth-songbook | notionPageId=406c794c-b775-46d4-ba2d-e9c74ee5779c | notionChordPageId=4ba758a7-88d1-4b11-b03b-c787dbb40eb5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/406c794cb77546d4ba2de9c74ee5779c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Раньше жил я во грехах'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=185%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Руки опущены', 'Пасхальные', NULL, '[Куплет 1]
Am C
Руки опущены, слезы в очах
Dm E
Люди, прислушайтесь к свисту бича.
E Am G C
Сбылось пророчество, лик Твой в крови,
C Dm E Am E
Смех и пощечины, крики «Распни!»

[Припев]
Am G C
Это моя вина, это мои дела,
Dm E Am E
Это мои слова ранят Христа.
Am G C
Это моя вина, это мои дела,
Dm E Am
Это мои слова ранят Христа.

[Куплет 2]
Am C
Крест поношения, слезы и боль.
Dm E
Щедрой жестокостью платим порой
E Am G C
Вместо награды – зло, вместо хвалы – хула
C Dm E Am E
Божьему Сыну на плечи легла.

[Куплет 3]
Am C
Ветер бушует, луч солнца угас,
Dm E
Веет соблазном дьявола глас:
E Am G C
«Что же на помощь Отца не зовешь?
C Dm E Am E
Или пощады и милости ждешь?»

[Припев]
Это моя вина, это мои дела,
Это мои слова ранят Христа.
Это моя вина, это мои дела,
Это мои слова ранят Христа.
Празднуют небеса
Гимны поет земля
Славим и ты, и я
Подвиг Христа!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=186 | photo=notion-youth-songbook | notionPageId=bf23d7c5-03ed-48ee-aa30-b3df8bee2699 | notionChordPageId=122e541b-1450-4364-bc7d-7fe0fcc95211 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bf23d7c503ed48eeaa30b3df8bee2699', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Руки опущены'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=186%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'С детских лет стремились', 'Божья любовь', NULL, '[Куплет 1]
Em7 C
С детских лет стремились к небесам твои мечты,
D G H
Про любовь Иисуса с колыбели знаешь ты
Em C
Но совсем недавно стал ты чаще замечать,
D G H
Как тебе не просто против мира устоять

[Припев]
Em Am
Соблазнам так легко поддатся и свернуть с пути
D G
Но без Бога невозможно жизнь найти
C Am A
Мир влечет людей красотой огней,
Am H Em
Только с каждым днем он ранит все больней.

[Куплет 2]
Em7 C
Перед тем как выбрать путь которым ты пойдешь,
D G H
Хорошо подумай: что без Бога ты найдешь?
Em C
Вспомни сколько раз тебе Он руку подавал,
D G H
Как Ему быть верным ты всем сердцем обещал…', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=187 | photo=notion-youth-songbook | notionPageId=53b75fe0-383c-487d-b875-675dd13393e7 | notionChordPageId=5dbcc44e-9b40-4535-be22-4e70b1263fc9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/53b75fe0383c487db875675dd13393e7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'С детских лет стремились'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=187%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Светом Своим', 'Пасхальные', NULL, '[Куплет 1]
E H F#m
Светом Своим Ты прогнал сумрак ночи,
E H A
И мне глаза Ты открыл.
E H F#m
Всю свою жизнь я хочу быть с Тобою,
E H A
Надежду Ты мне подарил.

[Припев]
A E H
Здесь я, чтобы славить, пред Тобой склониться
C#m A
И сказать Тебе, что Ты - мой Бог.
E H
Ты один достоин, кто с Тобой сравнится,
C#m A
Кто так возлюбить меня бы смог?

[Куплет 2]
E H F#m
Царь всех царей высоко вознесённый,
E H A
Прославленный в небесах!
E H F#m
С неба сошёл Ты, чтоб дать всем спасение,
E H A
Унижен Ты был ради нас.

[Мост]
Мне не забыть какой ценой
На крест был вознесён грех мой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=188 | photo=notion-youth-songbook | notionPageId=b11f05a2-4868-4738-bc06-6c43d0d908cc | notionChordPageId=327200ae-5f8a-419b-963d-d73b88f0bbe8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b11f05a248684738bc066c43d0d908cc', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Светом Своим'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=188%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Свят Господь', 'Пасхальные', NULL, '[Куплет 1]
Em D G
Ты ярче, чем солнца свет,
Am H Em
Ты - бездна святой любви!
Em D G
Нет! Знаю, другого нет!
Am H Em
Есть! Знаю, есть только Ты!

[Припев]
Em C
Свят Господь, свят Господь!
D G
Славит Господа земля!
Em Am
Свят Господь, свят Господь!
H Em
Славит вся Вселенная!

[Куплет 2]
Em D G
Ты славою облечен,
Am H Em
Ты вечно превознесен!
Em D G
Ты – начало и Ты – конец,
Am H Em
Ты – Бог мой, Ты - мой Отец!

[Куплет 3]
Em D G
Ты – жизнь, ты сама любовь,
Am H Em
Ты - Агнец, проливший Кровь!
Em D G
Ты - славный Спаситель мой,
Am H Em
Иисус, Ты - мой Господь живой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=189 | photo=notion-youth-songbook | notionPageId=e96c8783-fb9a-4c4f-8199-aa0f4b9443b1 | notionChordPageId=72a7817e-39ee-4139-82e2-8a96a230875e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e96c8783fb9a4c4f8199aa0f4b9443b1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Свят Господь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=189%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Святая ночь', 'Рождественские', NULL, '[Куплет 1]
A D A
Святая ночь! Сверкают ярко звезды.
E A
В тиши ночной нам родился Христос.
A D A
Весь мир тонул в грехе и беззаконьи,
C#m G#7 C#m
Но Божий Сын нам спасенье принёс.
E A
Надежда счастьем сердце наполняет,
E A
В дали горит грядущих дней заря.
F#m C#m Hm F#m
О, человек! Внимай певцам из рая!
A E A D A E A
О, ночь, о, ночь, Христова рождества!
E A Hm A E A
О, ночь, о, ночь, Христова рождества!

[Куплет 2]
A D A
Небесный свет рассеял мрак печали,
E A
С огнём в душе мы у яслей стоим.
A D A
Так мудрецы Царя царей искали,
C#m G#7 C#m
Несли дары и склонились пред Ним.
E A
Господь господ лежал в хлеву на сене
E A
Сочувствовать Он может нам во всём:
F#m C#m Hm F#m
Он знает жизнь, Он испытал мученья.
A E A D A E A
Пади пред Ним, признай Его Царём!
E A Hm A E A
Пади пред Ним, признай Его Царём!

[Куплет 3]
A D A
Он нас учил всё покрывать любовью,
E A
Любви закон и Свой мир Он нам дал.
A D A
Наш долг — спасать несчастных и бездольных:
C#m G#7 C#m
За всех людей наш Господь пострадал.
E A
Пусть песни славы льются словно реки,
E A
Пусть каждый к Богу радостно спешит.
F#m C#m Hm F#m
Христос — Господь! Хвала Ему навеки!
A E A D A E A
Ему вся власть и честь принадлежит!
E A Hm A E A
Ему вся власть и честь принадлежит!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=190 | photo=notion-youth-songbook | notionPageId=359db02d-da74-4cae-8cb7-ef4f0a0f535b | notionChordPageId=d0ad38f3-3a45-4ec5-af5f-cebba2c958fc | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/359db02dda744cae8cb7ef4f0a0f535b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Святая ночь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=190%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сердце благодарностью горит', 'Благодарение', NULL, '[Куплет 1]
Em Am
Я благодарю Тебя, мой Бог,
H Em
За год прожитый на земле,
Em Am
За то, что на развилках всех дорог
H Em
Близок Ты всегда ко мне.

[Припев]
Am D
Сердце благодарностью горит,
Em C
Молитва в небеса к Тебе летит.
Am Em
Твоя любовь вечна и не исчезает,
F# H Em
Она нас жизнью наполняет.

[Куплет 2]
Em Am
Я благодарю, что каждый час
H Em
Твоя рука объемлет нас.
Em Am
Ведь над землёй и небом Ты один
H Em
Жизни нашей Властелин.

[Куплет 3]
Em Am
Да не умолкают пусть уста,
H Em
О Тебе пусть говорят людям.
Em Am
Имя Иисуса, Иисуса Христа
H Em
Возвещать мы вечно будем.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=191 | photo=notion-youth-songbook | notionPageId=b8328808-1568-4561-b5d4-97de3fd277f2 | notionChordPageId=851c60cc-aea1-408a-a27d-a5a1ea13ce23 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b832880815684561b5d497de3fd277f2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сердце благодарностью горит'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=191%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сила моя в Тебе', 'Пасхальные', NULL, '[Куплет 1]
E H C#m
Сила моя в Тебе Господь,
G#m A
Ты исцеляешь мою плоть,
H E H
Мой всемогущий Бог.
E H C#m
Где бы я ни был, Ты со мной,
G#m A
Слышу повсюду голос Твой,
H E H
Мой вездесущий Бог.

[Припев]
E H C#m G#m
Иисус, Агнец Божий,
A H E H
Достоин имени Своего.

[Куплет 2]
E H C#m
Взял мой позор, мой грех, мой крест,
G#m A
Благословлю имя Твое,
H E H
Ты для меня все.
E H C#m
Я упал вниз - Ты поднял вверх,
G#m A
Жаждал я - Ты мне дал воды,
H E H
Ты для меня все.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=192 | photo=notion-youth-songbook | notionPageId=fcc8685f-ee59-4f6e-a2c9-d081be361c0a | notionChordPageId=85aa0fbd-c505-44da-aff3-cb28f409e1d9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fcc8685fee594f6ea2c9d081be361c0a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сила моя в Тебе'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=192%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Скоро рассвет', 'Небо', NULL, '[Куплет 1]
G Em C D
Скоро рассвет нового дня: приходит весна,
G Em C D
Увидим Его таким, как Он есть. Да Он встретит меня.
G D G D
Придёт во славе, мы ждем Его.
C G C D
Мы ждем, Господь, прихода твоего!

[Припев]
G Em
Гряди, мы твой народ и позади оставили всё!
C Am D
И впереди на облаках Ты встретишь нас.
G Em
С тобой взойдем на небо, и в покой откроешь двери
C D G
Как домой вернёмся в отчий дом родной

[Куплет 2]
G Em C D
Будем хвалить Господа мы в наших сердцах
G Em C D
Будем петь новую песню там с Ним в небесах
G D G D
Приди в славе мы ждём Тебя
C G C D
Мы ждём, Господь, прихода Твоего!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=193 | photo=notion-youth-songbook | notionPageId=3a95baf7-c650-48de-b51d-e5c07b1af76c | notionChordPageId=466f6606-0153-4818-99d6-da76ac607477 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3a95baf7c65048deb51de5c07b1af76c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Скоро рассвет'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=193%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Скрой меня', 'Семья', NULL, '[Куплет 1]
C G Am F D G
Скрой меня, Своим крылом,
C G Am F D G
Сохрани, под сильною рукой!

[Припев]
F G C
Пусть бушует шторм и гром гремит,
F G Am
Над бурей буду я с Тобой парить,
F G C
Мой Отец Ты Царь над всей Землей,
F G C
Я не боюсь, мой Бог со мной.

[Куплет 2]
C G Am F D G
Найду покой, В Тебе Христос,
C G Am F D G
Верю я, в могущество Твоё!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=194 | photo=notion-youth-songbook | notionPageId=9d60ddae-b369-4d9b-93f0-099359f8948c | notionChordPageId=df96f0cd-08d5-439e-bebf-8ca342bd7e4f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9d60ddaeb3694d9b93f0099359f8948c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Скрой меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=194%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слабый скажет: «Я силён!»', 'Пасхальные', NULL, '[Куплет 1]
C G C
Слабый скажет: «Я силён!»
Am Em
Бедный скажет: «Я богат!»
C G C
Скажет: «Вижу» - тот, кто слеп,
F G C
Всё это сделал Бог во мне.

[Припев]
G Am
Осанна! Осанна!
F C
Будем петь Иисус тебе,
G Am
Осанна! Осанна!
F G C
Ты был распят, но вновь воскрес.

[Куплет 2]
C G C
Пойду к реке живой воды,
Am Em
Где ты омыл грехи мои,
C G C
Буду петь, что во Христе
F G C
К новой жизни я воскрес.

[Куплет 3]
C G C
Поднимусь я из глубин,
Am Em
Найду я жизнь в руках Твоих,
C G C
Буду петь, что для Небес
F G C
К новой жизни я воскрес.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=195 | photo=notion-youth-songbook | notionPageId=0f98bded-646c-47a6-9c6d-afe6558bb7d8 | notionChordPageId=5c518a78-1ad9-4a0e-9563-fc49fb6f0e9f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0f98bded646c47a69c6dafe6558bb7d8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слабый скажет: «Я силён!»'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=195%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слава Всемогущему Богу!', 'Семья', NULL, '[Куплет 1]
A Hm
Отец Небесный мы с любовью,
E A
За все Тебя благодарим
A Hm
Мы Сына Твоего омыты кровью
D E A
Пред Тобой в благоговении стоим.

[Припев]
E A E D
Слава Всемогущему Богу!
E A
Он был, Он есть и вновь грядет!
E A E D E A
Слава Всемогущему Богу, Во веки веков!

[Куплет 2]
A Hm
Отец Небесный любим мы Тебя
E A
Прославить жаждем среди ночи и дня
A Hm
Твое царство пусть же будет внутри сердца нас.
D E A
Свою силу прояви Ты Боже наш.

[Куплет 3]
A Hm
Святое имя возвышаем мы.
E A
Слагаем нужды все пред Ним Одним
A Hm
Ароматы славы Божьей ощущаем мы.
D E A
Преклонитесь и будьте спасены!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=196 | photo=notion-youth-songbook | notionPageId=06795c30-3621-46ac-a6d6-9b68ff593896 | notionChordPageId=12ad2fe3-4acb-45ae-bc69-5256de65af9f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/06795c30362146aca6d69b68ff593896', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слава Всемогущему Богу!'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=196%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слава Христу', 'Божья любовь', NULL, '[Куплет 1]
A Hm
Какой сегодня день чудесный:
E A
С друзьями встретились мы вновь.
A D
Давайте в этот час все вместе
E A
Прославим Божию Любовь.

[Припев]
A D E A
Слава Христу за дивную встречу,
A D
Увидеть снова лица друг друга
E A
Бог нам даровал.

[Куплет 2]
A Hm
Какой сегодня день прекрасный:
E A
Как раньше, снова вместе мы.
A D
И пусть сегодня солнце ясно
E A
Сияет после краткой тьмы!

[Куплет 3]
A Hm
Какой сегодня день счастливый:
E A
О нём мечтали мы давно,
A D
И даже, если он дождливый,
E A
Прославим Бога все равно.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=197 | photo=notion-youth-songbook | notionPageId=4088e091-7f29-428b-be53-3114c5dfd48a | notionChordPageId=22aa8792-536b-4320-9280-3c7714fa2dcb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4088e0917f29428bbe533114c5dfd48a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слава Христу'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=197%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Славлю Тебя, Господи', 'Вера и упование', NULL, '[Куплет 1]
A F#m C#m E
Славлю Тебя, Господи, всем сердцем своим
A F#m C#m E
В свете праведных, в собрании святых,
D A C#7 F#m E
Велики дела Господни, вожделенны для всех
D A E7 A
Любящих Тебя, Господи!

[Припев]
A7 D A
Буду я петь и восхвалять,
C#7 F#m
Сладко мне имя Твоё,
D A
И чудеса Твои возвещать,
E7 A
Бог упованье моё!

[Куплет 2]
A F#m C#m E
Дело рук Его – истина и суд,
A F#m C#m E
Заповеди все в сердце моём живут,
D A C#7 F#m E
Пищу он даёт боящимся Его,
D A E7 A
Вечно помнит Свой завет – Он с тобой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=198 | photo=notion-youth-songbook | notionPageId=68e13abb-e49d-4cdb-aaed-a64d9b191ba5 | notionChordPageId=3899d54d-8185-4a72-8da9-250da532a031 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/68e13abbe49d4cdbaaeda64d9b191ba5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Славлю Тебя, Господи'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=198%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Славь, душа, Господа', 'Божья любовь', NULL, '[Куплет 1]
A E H C#m
Солнце встаёт, новый день приходит,
A E H C#m
Время опять хвалу воздать
A E H C#m
За всё, что Ты мне дал, и за каждый новый вдох мой
A E H E
Я буду петь и на закате дня.

[Припев]
A E H C#m
Славь, душа, Господа, Славь, душа,
A E H
Имя Святое Его.
A C#m A H C#m
Пой Ему, как никогда, пой, душа,
A H
Благослови Господа.

[Куплет 2]
A E H C#m
Велик в любви, и даёшь мне милость,
A E H C#m
Ты справедлив и так благ ко мне,
A E H C#m
За все дары Тебя хочу прославить
A E H E
Их сотни тысяч вижу в жизни я.

[Куплет 3]
A E H C#m
В тот день, когда иссякнет сила
A E H C#m
Настанет час встретить мне Христа
A E H C#m
Душа моя Его будет славить
A E H E
Десятки тысяч лет и навсегда!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=199 | photo=notion-youth-songbook | notionPageId=0d7b62fb-e45a-44fb-a587-1b4c1387da15 | notionChordPageId=96d880b1-39fc-4bf7-9780-17897d2b2e9b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0d7b62fbe45a44fba5871b4c1387da15', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Славь, душа, Господа'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=199%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слова те нельзя стереть', 'Утешение и ободрение', NULL, '[Куплет 1]
Em C D Hm
Напиши Свое Слово на сердце моем,
C Am H
Чтобы я мог исполнить Слово Твое.
Em C D Hm
Ведь чернила с бумагой однажды сгорят,
C Am H
Плотяные скрижали Слова сохранят.

[Припев]
Em D C
Слова те нельзя стереть,
Em D C
Над ними не властна смерть,
G D Em
Их невозможно сжечь,
C Am H
Лучшее место, где их сберечь –
Em D C
В сердце своем храни,
Em D C
Пусть там оживут они,
G D Em
И то, что сказал Господь
Am H
Проявится через плоть.

[Куплет 2]
Em C D Hm
Твоя заповедь стала мне песней в пути,
C Am H
Что чрез боль и усталость поможет пройти.
Em C D Hm
Соблюдать Твое Слово – удел для меня,
C Am H
Пусть же снова и снова будет Воля Твоя!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=200 | photo=notion-youth-songbook | notionPageId=244f3179-eacd-4527-9a9a-7a6bb8383763 | notionChordPageId=a07d635e-4c21-4ed5-8c2b-b66080e08217 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/244f3179eacd45279a9a7a6bb8383763', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слова те нельзя стереть'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=200%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Создатель всей Вселенной', 'Молитвенные', NULL, '[Куплет 1]
Am Em Am Em
Создатель всей Вселенной - Всемогущий Бог,
F E
И жизнь мою другой лишь только Ты соделать смог.
Am Em Am Em
Я петь хочу о том, что подарил мне Ты,
F E
О той любви, что бесконечна, как и Ты.

[Припев]
Am F G C
Тебе, Господь, хвалу я вознесу,
F E Am
Перед Тобой я голову склоню.
Am F G C
Тебе, Господь, любовь и жизнь моя,
F E Am
Прими молитву эту от меня.

[Куплет 2]
Am Em Am Em
Создатель всей Вселенной, Всемогущий Бог,
F E
Среди ночи Ты мне увидеть Свет помог.
Am Em Am Em
С тех пор, как я узнал Твою любовь ко мне,
F E
Хочу служить всем сердцем я Тебе.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=201 | photo=notion-youth-songbook | notionPageId=05b97727-f0ae-4cc8-9670-e4546b9eb1b0 | notionChordPageId=d5190bd8-d9f4-4280-8517-376efa62db8e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/05b97727f0ae4cc89670e4546b9eb1b0', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Создатель всей Вселенной'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=201%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Солнца луч', 'Семья', NULL, '[Куплет 1]
Солнца луч одарит теплом землю.
Небеса возвестят Творцу славу.
День и ночь о Нём говорят,
И Ему гимны звучат
До пределов земли, в наших сердцах.
До пределов земли, в наших сердцах.

[Куплет 2]
Откровение Бога нам даёт мудрость,
И закон Его укрепляет нам душу.
Повеления Божьи верны,
Наставления Божьи точны,
И они веселят наши сердца.
И они веселят наши сердца.

[Мост]
Страх Господень чист, пребывает вовек,
Суд Господень свят, охраняет нас.
Пусть угодны будут Тебе
Помышления наших сердец.
Ты - твердыня для нас, наш Господь и Отец.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=202 | photo=notion-youth-songbook | notionPageId=9f0a8c98-450a-48a7-b0c0-23e676849a25 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/9f0a8c98450a48a7b0c023e676849a25 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Солнца луч'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=202%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'С‍‍олнца свет, за‍‍кат и рассвет', 'Семья', NULL, '[Куплет 1]
F Dm
Оглянись! Посмотри вок‍‍руг себя
A# C
Как прекрасен этот мир, как краси‍‍ва вся земля
F Dm
Облака словно белый с‍‍нег белы
A# C
На бескрайней си‍‍неве необъя‍‍тны и нежны

[Припев]
F Dm
С‍‍олнца свет, за‍‍кат и рассвет
A# C
Соловь‍‍иные трели и подсне‍‍жник в апреле
F Dm
Л‍‍етние ночи, нежный запах цветов
A# C F
Во всем творе‍‍нии з‍‍аметна Божья любо‍‍вь.

[Куплет 2]
F Dm
Человек – Божьей красоты венец
A# C
В совершенствии любви отражаеться Отец
F Dm
Нам образ дан и подобие Творца
A# C
И познанию Его не найти во век конца.

[Куплет 3]
F Dm
Если ты в сердце затаил вопрос
A# C
Где начало всех начал и откуда сколько звезд
F Dm
Знай мой друг есть один простой ответ:
A# C
Бог создал весь этот мир и Ему хвала вовек!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=203 | photo=notion-youth-songbook | notionPageId=c9264797-8200-4788-bd10-81a1a7f4c5f2 | notionChordPageId=9c23d8a3-00cf-406f-97f4-a547ae5629d0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c926479782004788bd1081a1a7f4c5f2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'С‍‍олнца свет, за‍‍кат и рассвет'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=203%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Солнце простилось с землею', 'Прощение', NULL, '[Куплет 1]
D G
Солнце простилось с землею,
A D
Солнце сказало: “До встречи!”.
D G
С первой на небе звездою
A D
Тихо пришел к нам вечер.

[Припев]
H Em
Там, далеко в вышине,
A D F#
Звезды поют и сейчас
Hm G
Друг мой тебе и мне
A D
О Боге нельзя молчать.

[Куплет 2]
D G
Сумрачней стало и глуше,
A D
Птицы заснули в гнездах.
D G
Не уходи, послушай,
A D
Как напевают звезды.

[Куплет 3]
D G
Если тревожит душу
A D
Мысль: “Для чего я создан?” -
D G
Не уходи послушай:
A D
Славят Создателя звезды.

[Куплет 4]
D G
Голос свой влей в их пенье,
A D
Всем о любви скажи,
D G
Чтоб к высоте стремленье
A D
В людях могло бы жить.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=204 | photo=notion-youth-songbook | notionPageId=0a4ce734-0504-4532-a862-84c8ba65e984 | notionChordPageId=a4352688-3d81-4a1a-a38e-674ec3ffa2ae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0a4ce73405044532a86284c8ba65e984', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Солнце простилось с землею'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=204%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Спасенье моё, надежда моя', 'Спасение', NULL, '[Куплет 1]
E C#m
Спасенье моё, надежда моя,
A H7
Лишь в Тебе источник моей жизни.
E C#m
Отрада любви, утешенье моё,
A H7
Лишь в Тебе источник моей жизни.

[Припев]
E C#m F#m H7
Подниму я очи свои
E C#m F#m H7
И прославлю Того, Кто любит меня.
E C#m F#m H7
Подниму я очи свои
C#m A7 A E
И скажу Тебе, Бог мой, как люблю я Тебя.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=205 | photo=notion-youth-songbook | notionPageId=68e06d4f-bf93-4d58-b43a-ffd0bc8f0c27 | notionChordPageId=bf8e0b3c-cc25-4552-9446-9e0cd0782951 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/68e06d4fbf934d58b43affd0bc8f0c27', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Спасенье моё, надежда моя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=205%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Спелых колосьев', 'Спасение', NULL, '[Куплет 1]
G Hm Am
Спелых колосьев, к жатве готовых, поле стоит.
D G D
Серп ожидает, жнеца поджидает, душе говорит:
G Hm Am
“Годы уходят, даты проходят, спешат всё вперёд.
C D
Что собирает, что приготовил Божий народ?”

[Припев]
G H
Как жизнь прожил ты, как её провёл?
E A
Богу служил ли, что приобрёл
Am D G Em
С чем к Спасителю выйдем, что принесём
C G
С дымом чадящим иль с сердечным огнём.

[Куплет 2]
G Hm Am
Поле уж бело, взяться за дело Бог всем велит.
D G D
Лень удаляя, мир пробуждая, труд пусть кипит.
G Hm Am
Кончится лето, но льётся свет нам – пойдём на поля.
C D
Пусть воспевает, к Богу шагает наша Земля.

[Куплет 3]
G Hm Am
Вот уже скоро работники споро сойдут на поля.
D G D
Что не дозреет, уже не созреет, то для огня.
G Hm Am
Отмерено время, живи не в смятенье, готовь добрый плод.
C D
Только подобных, Богу угодных, в небе оплот.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=206 | photo=notion-youth-songbook | notionPageId=775b5c6d-a236-4c67-9991-16675261e00b | notionChordPageId=fdcc5f3a-747b-4a8b-bb5e-50c754ebc381 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/775b5c6da2364c67999116675261e00b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Спелых колосьев'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=206%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Старый крест', 'Пасхальные', NULL, '[Куплет 1]
Am Dm E7 Am
На далеком холме, средь деревьев и скал
Dm G C
Сквозь седые века старый крест простоял.
Am Dm E7 Am
Миллионы людей у подножья креста
Dm F E7
Свое счастье нашли, там однажды был я.

[Припев]
Dm E7 Am
Старый крест, старый крест, неброский, но лишь в нём
Dm G C A7
Сила есть, сила есть, сегодня может он
Dm Am F
Исцелять разбитые, больные сердца,
Dm F E7 Am
Каждому пришедшему открыть небеса.

[Куплет 2]
Am Dm E7 Am
Между небом святым и греховной землей
Dm G C
Пропасть злая лежит, разделяя собой.
Am Dm E7 Am
Хочешь верь, хочешь нет, слушай слово Творца.
Dm F E7
Крест - единственный мост от земли в небеса.

[Куплет 3]
Am Dm E7 Am
Иисус дорогой, на вершине креста
Dm G C
Сквозь седые века я увидел Тебя:
Am Dm E7 Am
На пронзенных руках не застывшая кровь,
Dm F E7
А в прекрасных глазах Божья к людям любовь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=207 | photo=notion-youth-songbook | notionPageId=16a95c9a-32e2-4e93-8296-f71dea423e57 | notionChordPageId=883dd778-fcf2-4bb7-9b8b-cb5a4c5cfb8a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/16a95c9a32e24e938296f71dea423e57', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Старый крест'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=207%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Струн души', 'Спасение', NULL, '[Куплет 1]
Am
Струн души рука Христа касается,
Dm G C Am
И она восторженно поет,
Dm G C Am
Песнь еще одна на свет рождается,
Dm E Am
Песнь о Том, Кто счастье нам дает.

[Куплет 2]
Am
О Тебе поют сады весенние
Dm G C Am
Трелью звонких птичьих голосов.
Dm G C Am
Я хочу воспеть Твое спасение,
Dm E Am
Жаль, что нет таких на свете слов.

[Куплет 3]
Am
Твой привет мне льется ароматами
Dm G C Am
Всех полей цветущих и садов.
Dm G C Am
Навсегда порвав с мирскими взглядами,
Dm E Am
Принял я навек Твою любовь.

[Куплет 4]
Am
Я любовь великую, безбрежную
Dm G C Am
Нахожу во всем, что видит взор,
Dm G C Am
И люблю любовью самой нежною
Dm E Am
Я Того, Кто снял греха позор.

[Куплет 5]
Am
Струн души рука Христа касается,
Dm G C Am
И она восторженно поет.
Dm G C Am
Пусть вовеки песня не кончается,
Dm E Am
Песнь о Том, Кто счастье нам дает!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=208 | photo=notion-youth-songbook | notionPageId=76e761e9-4946-4bc6-b4eb-db32efa8e2a5 | notionChordPageId=602e6adc-e6fe-4357-bed2-efd0c82efaea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/76e761e949464bc6b4ebdb32efa8e2a5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Струн души'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=208%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Суть рождения Иисуса', 'Рождественские', NULL, '[Куплет 1]
C G
Суть рождения Иисуса это дивный Божий план
Dm C
Он послал Его на землю, чтоб явить любовь всем нам,
F G
Чтобы грешников погибших от греха спасти навек,
E G
Чтобы дать им всем надежду ведь без Бога счастья нет!

[Припев]
Am G C
Рождество, Рождество!
F G
Свет и радость нам принёс, в этот мир рождён Христос!
Am G C
Рождество, Рождество
F G
Будем праздновать всегда день Рождения Христа!
C
В Рождество!

[Куплет 2]
C G
В этот праздник очень часто забывают о Христе,
Dm C
Но Его святое имя пусть же слышится везде,
F G
Так давайте обратим наши взоры на Христа
E G
Благодарностью наполним наши души и сердца!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=209 | photo=notion-youth-songbook | notionPageId=8836d91b-a95a-40cf-b411-8e0154848751 | notionChordPageId=6c6b1f2e-60c5-4a9b-92de-76d6fe07e53c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8836d91ba95a40cfb4118e0154848751', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Суть рождения Иисуса'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=209%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сущий', 'Прощение', NULL, '[Куплет 1]
Fm Cm
В начали был и есть, и нет тебе конца,
C# Fm
Ты высота глубина.
Fm Cm
Ты словом делал всё, Ты словом мир создал,
C# Fm
Своё величье доказал

[Припев]
A#m Fm
Пред Тобой трепещет всё весь мир в Твоих руках
A#m C
Ты всемогущий Бог Создатель Ты и Царь
Fm Cm
Великий, всемогущий, у ног Твоих весь мир
C# C
На троне восседаешь могуществом Своим
Fm D#
Великий, вездесущий, над всеми Ты царишь
C# C
И всем Ты управляешь, жизнь всему даришь

[Куплет 2]
Fm Cm
Когда приходишь ты, в своей святой любви,
C# Fm
Приходит свет из темноты
Fm Cm
Ты был и есть прежде всех веков
C# Fm
Твоё имя Саваоф

[Мост]
В Твоём имени свобода
В Твоём имени огонь
В Твоём имени прощение
В Твоём имени любовь', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=210 | photo=notion-youth-songbook | notionPageId=e1ee1e85-f183-44a7-a4fa-6408b4698367 | notionChordPageId=9ad98f15-e7f9-43bf-b494-b1e09bbf7cfa | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e1ee1e85f18344a7a4fa6408b4698367', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сущий'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=210%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сын Божий нам рождён', 'Спасение', NULL, '[Куплет 1]
C F
Сын Божий нам рождён оставив власть и трон
C G
Без славы в мир пришёл Всесильный Царь
C F
Вся силы полнота вся славы красота
C G
Явились в эту ночь в Младенце нам
F G
Приди и поклонись

[Припев]
Am F G C
Христос Господь нас грешных спасёт
Am F G
Божий Сын рождён как мы
Am F G Am
Христос Господь наш Царь принял плоть
F G C
Нам рождён Господь Иисус

[Куплет 2]
C F
Мессия был так мал когда в хлеву лежал
C G
Рождён чтоб искупить позорный грех
C F
В хлеву Он мирно спит но Он соединит
C G
Святого Бога и спасенных всех
F G
Приди и поклонись', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=211 | photo=notion-youth-songbook | notionPageId=0ceab6ef-c520-4149-9f9e-d0f391e0430b | notionChordPageId=ed768b83-fbe8-43e9-940c-088902e8fa8b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0ceab6efc52041499f9ed0f391e0430b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сын Божий нам рождён'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=211%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Так уж бывает летней порой', 'Небо', NULL, '[Куплет 1]
Dm Gm
Так уж бывает летней порой,
A7 Dm
Когда луч солнца радует нас -
Dm Gm
В час испытанья - чёрной будто рукой
C F
Небо закроет от нас.

[Припев]
Gm C
И если не станет овец в загоне,
F Dm
И виноград не даст плода,
Gm Dm
Все равно я буду славить
A7 Dm
Господа Христа!

[Куплет 2]
Dm Gm
Если закружит меня волною
A7 Dm
В водовороте суетного дня,
Dm Gm
Верой поднявшись над суетою
C F
Вновь запоет душа моя:

[Куплет 3]
Dm Gm
Если однажды теряешь что-то,
A7 Dm
Вспомни слова Иисуса Христа -
Dm Gm
«Где ваша ценность – там сердце будет!»,
C F
А, значит, потеря – не велика!

[Куплет 4]
Dm Gm
Если однажды жизненный выбор:
A7 Dm
Ради Иисуса и славы Отца
Dm Gm
Нужно лишиться овец в загоне,
C F
Хочу, чтобы спела душа моя:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=212 | photo=notion-youth-songbook | notionPageId=092d79d3-ded0-44f1-a951-9880bacf0c1b | notionChordPageId=6d831c9a-70d7-459d-8293-eb03dd45a49b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/092d79d3ded044f1a9519880bacf0c1b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Так уж бывает летней порой'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=212%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Таков как есмь', 'Пасхальные', NULL, '[Куплет 1]
D G Em
Таков как есмь, во имя Крови,
G A D
За нас пролитой на кресте,
G Em
Во имя Божьих призываний,
G A Hm G
Христос, я прихожу к Тебе!
A G D
Христос, я прихожу к Тебе!

[Куплет 2]
D G Em
Таков как есмь слепой и бедный,
G A D
Добра не находя в себе,
G Em
За верой, зреньем и прощеньем,
G A Hm G
Христос, я прихожу к Тебе!
A G D
Христос, я прихожу к Тебе!

[Куплет 3]
D G Em
Таков как есмь, меня Ты примешь,
G A D
Дашь жизнь, спасенье, мир Твой мне;
G Em
К Тебе я прихожу, Спаситель,
G A Hm G
Дай мне Тебя познать вполне!
A G D
Дай мне Тебя познать вполне!

[Куплет 4]
D G Em
Таков как есмь, Твоей любовью
G A D
Низвергнул Ты преграды все,
G Em
Я Твой отныне и вовеки,
G A Hm G
Христос, я прихожу к Тебе!
A G D
Христос, я прихожу к Тебе!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=213 | photo=notion-youth-songbook | notionPageId=94d8b659-16e3-4e60-8443-3f9754e17a48 | notionChordPageId=225dbf1f-633a-47fc-a54f-9779950eed73 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/94d8b65916e34e6084433f9754e17a48', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Таков как есмь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=213%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Там, в вышине бесконечной', 'Небо', NULL, '[Куплет 1]
Hm Em
Там, в вышине бесконечной,
F# Hm
Между планет, город стоит, город вечный.
Hm Em G
Как я хочу там отдохнуть и дышать, дышать, дышать
Hm Em F# Hm
И с восторгом наслаждаться прославлять Христа, прославлять.

[Куплет 2]
Hm Em
Здесь постоянно усталый,
F# Hm
Трудно дышать в мире греховном мне стало.
Hm Em G
Только в одном, мне со Христом все вперед, вперед, вперед,
Hm Em F# Hm
Он в небесную Отчизну непременно доведет.

[Куплет 3]
Hm Em
Все предо мною прекрасно,
F# Hm
Кажется мне, чувство мое не угасло.
Hm Em G
Город родной неповторим он живет, растет, цветет.
Hm Em F# Hm
Город чудный, город славный красотой к себе влечет.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=214 | photo=notion-youth-songbook | notionPageId=efa099e1-42a4-4989-9152-e3be8f4af908 | notionChordPageId=10bcc95e-d349-40ef-ab93-29594957ad64 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/efa099e142a449899152e3be8f4af908', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Там, в вышине бесконечной'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=214%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Там, где Один', 'Прощение', NULL, '[Куплет 1]
E A E
Там, где Один пострадал за всех,
E A H7
Там, где разбойник прощен за грех, -
E A E
Там Своей кровью Он смыл мой грех,
E H7 E
О, хвала Ему!

[Припев]
A E C#m A H7
О, хвала Ему! О, хвала Ему!
E A E
Там Своей кровью Он смыл мой грех,
E H7 E
О, хвала Ему!

[Куплет 2]
E A E
Дивно Христос дар любви простер,
E A H7
Дивно с несчастного снял позор,
E A E
Дивно живет Он во мне с тех пор,
E H7 E
О, хвала Ему!

[Куплет 3]
E A E
Чудный свет Божий рассеял тьму,
E A H7
Чудно, что смог я придти к Нему,
E A E
Чудно Христос дает жизнь всему, -
E H7 E
О, хвала Ему!

[Куплет 4]
E A E
К жизни потоку направь свой путь,
E A H7
Духом спеши ко Христу прильнуть,
E A E
Грех свой омой и счастливым будь!
E H7 E
О, хвала Ему!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=215 | photo=notion-youth-songbook | notionPageId=9e9767a6-217a-4b8c-9570-2e7cfa0af56a | notionChordPageId=94d7ba42-0679-4611-92cd-13e12b37993e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9e9767a6217a4b8c95702e7cfa0af56a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Там, где Один'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=215%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Там, далеко, за облаками', 'Вера и упование', NULL, '[Куплет 1]
G Em
Там, далеко, за облаками,
C D
Встретит меня Иисус,
G Em
Нежно обнимет своими руками,
C D
C Ним я навеки сольюсь,

[Припев]
G D Am Em
А пока живу я мире странником
G D Am H
И с тоской смотрю я в небеса.
G D Am Em
С небом связаны мои желания,
G D Am H7 Em
С небом связана моя судьба.

[Куплет 2]
G Em
Мне распахнут райские двери
C D
Радостно скажут: “Входи!”
G Em
Всё это будет, твёрдо я верю,
C D
Но это лишь впереди.

[Куплет 3]
G Em
Там навсегда скорби забуду,
C D
В небе Господь наш царит.
G Em
Там с Иисусом вечно я буду
C D
В сладком общении жить,', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=216 | photo=notion-youth-songbook | notionPageId=669d8c71-70f4-402b-abce-2d4e43049663 | notionChordPageId=a01613c0-eee6-44b8-988d-d92b98c6a229 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/669d8c7170f4402babce2d4e43049663', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Там, далеко, за облаками'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=216%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Творящий чудеса', 'Дух Святой', NULL, '[Куплет 1]
E H
Каждый миг и каждый час
C#m A
Ты царствуешь на небесах,
E H C#m E
Великий Бог, Великий Царь.
E H
И на земле в руках твоих
C#m A
Ты держишь нас, ты нас хранишь
E H C#m E
И чудеса свои творишь.

[Припев]
A H
Творящий чудеса,
E C#m
Творящий чудеса,
A H E
Ты Бог, творящий чудеса.

[Куплет 2]
E H
О, Дух святой, прошу Тебя
C#m A
Приди ко мне, о, верю я –
E H C#m E
Изменишь Ты всю жизнь мою.
E H
Иисуса кровь сильней греха,
C#m A
Отца любовь ведет меня
E H C#m E
В Твои святые небеса.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=217 | photo=notion-youth-songbook | notionPageId=bffc3ed8-ea00-46ff-8ca5-190494925991 | notionChordPageId=f3b20c1a-ddf2-4356-8c54-b4815f01a767 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bffc3ed8ea0046ff8ca5190494925991', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Творящий чудеса'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=217%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Твоя любовь', 'Спасение', NULL, '[Куплет 1]
A E F#m
Твоя любовь границ не знает
D A Hm E
И ярче солнца свет Твой мне.
A E F#m
В Твоем общеньи отдыхаю,
D A Hm E
Тебя люблю, Господь, пою Тебе!

[Припев]
A D
Господь мой, я Тебя прославляю
Hm F#m E
Господь мой, Ты Спаситель души моей
A D
Господь мой, я Тебя воспеваю
Hm F#m E
Господь мой, Ты достоин хвалы
E D A
Только Ты, только Ты!

[Куплет 2]
A E F#m
Вся жизнь моя в Тебе сокрыта,
D A Hm E
Я льну к Тебе, мой добрый Бог.
A E F#m
Твоим теплом душа согрета,
D A Hm E
Мне хорошо с Тобой, навек я Твой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=218 | photo=notion-youth-songbook | notionPageId=8ad13cfb-9d39-459e-9a01-8c4702992c48 | notionChordPageId=20d4bf9a-41a8-4e64-982f-57a2023221ff | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8ad13cfb9d39459e9a018c4702992c48', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Твоя любовь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=218%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Тихо погас в ночи закат', 'Божья любовь', NULL, '[Куплет 1]
G Am Em
Тихо погас в ночи закат,
G Am Em
Сад Гефсиманский сном объят
G Am H7
Всеми оставлен и забыт
Em C
Сын Божий там душой скорбит…
G Am Em
Нет рядом с Ним учеников,
G Am Em
И пот багряный, словно кровь,
G Am H7
С лица Его на камни тёк.
Em C
Поверить трудно, что Он - Бог.
Am H7
Поверить, что Он - Бог.

[Припев]
Am Em C Em
Кто ты? Чтобы так страдать.
Am Em C D
Кто ты? Как же нам понять.
Am Em C Em
Ты - Бог, молишься скорбишь,
Am G D Em
Твой час настал, за всех умирать.

[Мост]
Лишь только камни видя кровь,
Смогли понять, что есть любовь,
Но только сердце у людей
Куда холоднее камней,
холоднее камней.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=219 | photo=notion-youth-songbook | notionPageId=ae645ce9-004a-482c-b9e9-a32c2ae727e0 | notionChordPageId=00d6b202-3668-4e85-8ff4-5cd6bc86b025 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ae645ce9004a482cb9e9a32c2ae727e0', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Тихо погас в ночи закат'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=219%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Тихо у гроба, очень рано', 'Пасхальные', NULL, '[Куплет 1]
Тихо у гроба очень рано,
Жены спешат, предваряя рассвет…
Вдруг Ангел с неба, камень отвален,
Душу согрел воскресения свет.

[Припев]
Он воскрес! Победно воссиял,
Искупителем для многих стал;
Он воскрес! Спасенье всем принес,
Воскресший чудно Иисус Христос!

[Куплет 2]
Кто превозможет, разве возможно
Господа славы в плену удержать?
Кто с Ним воскрес, тот верою может,
Кровью Христовой врага побеждать.

[Куплет 3]
Праздник спасенных, звуки восторга,
Церкви Христовой Пасхальный привет!
Радость Святая всех да наполнит
Места тревогам в душе больше нет.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=220 | photo=notion-youth-songbook | notionPageId=69843e29-936e-4e0e-9781-2f4c9dfde2ad | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/69843e29936e4e0e97812f4c9dfde2ad | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Тихо у гроба, очень рано'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=220%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Только Ты Один', 'Пасхальные', NULL, '[Куплет 1]
F C Dm
Только Ты Один
A# C
Так коснулся сердца моего,
F C Dm
Твоя милость, как живая река,
A# C F
К вечности течёт.

[Припев]
F C Dm
Слава, слава Тебе,
A# C
За Голгофу и за кровь.
F C Dm
Слава, слава Тебе,
A# C F
За жизнь Твою, Иисус Христос.

[Куплет 2]
F C Dm
Только Ты Один
A# C
На Голгофе жизнь отдал за меня.
F C Dm
И стекает драгоценная кровь
A# C F
Агнца Божия.

[Куплет 3]
F C Dm
Только Ты Один
A# C
Мне отдал сокровища Свои,
F C Dm
Небеса открыты передо мной,
A# C F
Я иду домой!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=221 | photo=notion-youth-songbook | notionPageId=5275a87a-39a4-441d-b421-3bcd295baf4b | notionChordPageId=4104048d-2fbc-495b-af15-e54effc0ab83 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5275a87a39a4441db4213bcd295baf4b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Только Ты Один'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=221%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты воскрес и дал нам жизнь', 'Пасхальные', NULL, '[Куплет 1]
D G A
Торжествуют небеса, торжествует вся земля
D G A
Свершилось и любовь Отца искупила нас
Hm A D G
Рано утром в третий день Иисус Христос воскрес,
Hm G A
Узы смерти Он на веки победил.

[Припев]
D A
Ты воскрес и дал нам жизнь
Em Hm
Искупил Своею кровью,
D A
Все грехи наши простив
G A
Ты воскрес и дал нам жизнь.

[Мост]
||: Величественный Царь, Спаситель верный
Благодарю Тебя за эту жертву. :||
Тот кто в мир пришёл с небес,
Царь царей Господь всесильный
Иисус Христос воскрес! Иисус Христос воскрес!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=222 | photo=notion-youth-songbook | notionPageId=86bc0568-47cc-407b-a978-20929b5cc17d | notionChordPageId=c897b374-3efe-4cb4-9457-3119560cea6c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/86bc056847cc407ba97820929b5cc17d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты воскрес и дал нам жизнь'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=222%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты знаешь, Боже', 'Молитвенные', NULL, '[Куплет 1]
Dm
Ты знаешь, Боже, моё желанье,
Dm Gm C F
Мои молитвы слышишь Ты.
Gm Dm
Тебе известно мое страданье,
Dm A Dm
Мои стремленья и мечты.

[Куплет 2]
Dm
Ты знаешь, Боже, что не ищу я
Dm Gm C F
Богатств и почестей земных.
Gm Dm
Моим всем сердцем Тебя люблю я,
Dm A Dm
Хочу с Тобой быть каждый миг.

[Куплет 3]
Dm
Скорблю я часто, душа томится,
Dm Gm C F
Не вижу радости бытья.
Gm Dm
Я одинокий, как в клетке птица,
Dm A Dm
И умолкает песнь моя.

[Куплет 4]
Dm
Никто не знает, не спросит даже
Dm Gm C F
Куда и что меня влечёт,
Gm Dm
И кто утешит, кто путь укажет,
Dm A Dm
Когда на сердце тяжкий гнёт?

[Куплет 5]
Dm
Мне мир чужим стал, и я — для мира.
Dm Gm C F
О, Боже, дай мне Твой покой!
Gm Dm
Устал бороться, слабеют силы,
Dm A Dm
А путь далекий предо мной.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=223 | photo=notion-youth-songbook | notionPageId=019eaf94-0b3f-4fb5-aea5-7a313bd15430 | notionChordPageId=2163f79c-9666-42f9-b7a6-739a8db250d5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/019eaf940b3f4fb5aea57a313bd15430', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты знаешь, Боже'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=223%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты искупил мир от греха', 'Семья', NULL, '[Куплет 1]
G D Em
Ты искупил мир от греха,
Em C
Ты дал ему любовь и свет.
C Am
Зажег потухшие сердца
Am D
И дал надежду.
G D Em
Мы пред Тобою предстоим,
Em C
И каждый дорог для Тебя.
C Am
За все Отец благодарим
Am D
И превозносим.

[Припев]
G D
Слава Тебе и величье,
Em D
Слава в веках и народах.
C G
Сила Твоя безгранична,
Am D
Милость Твоя во все роды.

[Куплет 2]
G D Em
Ты открываешь новый мир,
Em C
Любви, Надежд и чистоты.
C Am
С тобой не трудно мне идти,
Am D
Ведь ты со мною.
G D Em
Твоя любовь меня хранит,
Em C
Дает надежду и покой,
C Am
И потому сердца людей,
Am D
Полны хвалою.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=224 | photo=notion-youth-songbook | notionPageId=2d868f4a-8345-407e-bb81-f7b33375971d | notionChordPageId=c851ae1d-2eb3-4638-a083-cf3c7f66fc77 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2d868f4a8345407ebb81f7b33375971d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты искупил мир от греха'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=224%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты куда идешь, скажи мне', 'Божья любовь', NULL, '[Куплет 1]
C
"Ты куда идешь, скажи мне,
F G
Странник с посохом в руке?" -
F G
"Дивной милостью Господней
C
К лучшей я иду стране.
F G C Am
Через горы и долины, через степи и поля,
F G C G C
Чрез леса и чрез равнины я иду домой, друзья".

[Куплет 2]
C
"Странник, в чем твоя надежда
F G
В той стране твоей родной?" -
F G
"Белоснежная одежда
C
И венец весь золотой.
F G C Am
Там источники живые и небесные цветы,
F G C G C
Я иду за Иисусом через жгучие пески".

[Куплет 3]
C
"Страх и ужас не знакомы
F G
Разве на пути тебе?" -
F G
"Да, но Божьи легионы
C
Охранят меня везде!
F G C Am
Иисус Христос со мною, Он направит Сам меня
F G C G C
Неуклонною тропою прямо, прямо в небеса".

[Куплет 4]
C
"Так возьми ж меня с собою,
F G
Где чудесная страна". -
F G
"Да, мой друг, пойдем со мною,
C
Вот тебе моя рука!
F G C Am
Недалеко уж родная и желанная страна.
F G C G C
Вера чистая, живая нас введет с тобой туда".', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=225 | photo=notion-youth-songbook | notionPageId=97253e46-0aba-4ab2-aefd-396654dad216 | notionChordPageId=4aef0575-93d9-4f54-9963-e4821c88fdf9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/97253e460aba4ab2aefd396654dad216', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты куда идешь, скажи мне'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=225%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты любишь меня', 'Прославление', NULL, '[Куплет 1]
Hm Em
Ты никогда не предашь меня,
F#7 Hm
В тревожные дни не оставишь меня.
Hm Em
Не вырвет никто из Твоей руки,
Hm F#7 Hm
Всё потому, что Ты любишь меня.

[Припев]
H7 Em A7 D
В бурю и ураган, в стужу, дожди и зной
Hm Em Hm F#7 Hm
Рядом Иисус со мной, потому что Ты любишь меня.

[Куплет 2]
Hm Em
В страже ночной пребываешь со мной,
F#7 Hm
Силы даёшь на пути домой,
Hm Em
Плачешь со мной, если беда
Hm F#7 Hm
Всё потому, что Ты любишь меня.

[Куплет 3]
Hm Em
Если в душе забываю Тебя,
F#7 Hm
Молишься Ты день и ночь за меня.
Hm Em
Ведь Ты никогда не предашь меня.
Hm F#7 Hm
Всё потому, что Ты любишь меня.

[Куплет 4]
Hm Em
Всё потому, что Ты любишь меня
F#7 Hm
Сердце моё славит Тебя.
Hm Em
В руки Твои себя отдаю,
Hm F#7 Hm
Всё потому, что Тебя я люблю.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=226 | photo=notion-youth-songbook | notionPageId=f9143efd-b3e1-41d8-9c99-0fc766b9b23c | notionChordPageId=76450584-b4ce-4c02-a212-bd42460b6cd3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f9143efdb3e141d89c990fc766b9b23c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты любишь меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=226%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты меня наполни', 'Спасение', NULL, '[Куплет 1]
E H A H
Ты меня наполни святостью Твоей.
E H A H
Пусть меня исполнит Дух Твой как елей.
C#m A E
Я всего лишь человек – словно пыль перед Тобой,
A H E
Но в Твоих руках я нахожу покой.
E H A H
Ты всегда был рядом, когда я страдал,
E H A H
Посылал надежду, веру укреплял.
C#m A E
И нет слов, чтоб описать полноту любви Твоей
A H E
Как прекрасен Ты, Господь души моей.

[Припев]
E A
Ты скажи мне, Боже, кто я есть
H E
По сравнению с Тобой?
E A
Ты слепящий яркий солнца свет
H E
Можешь скрыть Своей рукой.
C#m A
И сиянье неба и дождя
H E
И росток в сухой земле
C#m A
Мне ответят снова, что нигде
H E
Нет подобного Тебе!

[Куплет 2]
E H A H
Я нашёл свободу, став твоим рабом.
E H A H
Я обрёл спасенье, став Твоим дитём.
C#m A E
Мои сердце и любовь я кладу к ногам Твоим,
A H E
Только Ты достоин Богом быть моим.
E H A H
Твое имя велико по всей земле.
E H A H
Твоя слава не смолкает в вышине,
C#m A E
Пусть ещё одна душа вдруг увидит и поймёт,
A H E
Что её Создатель в небесах живёт.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=227 | photo=notion-youth-songbook | notionPageId=b1c38c38-cad2-4e03-9a59-f3ef24fe5854 | notionChordPageId=2b6324e5-7922-4bbd-9e03-f62102630c70 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b1c38c38cad24e039a59f3ef24fe5854', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты меня наполни'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=227%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты мой Бог', 'Семья', NULL, '[Куплет 1]
Dm Gm A Dm
Тебя люблю, мой Бог, я всей душою,
Dm Gm C F
И с каждым новым днём хочу любить сильней,
D7 Gm A A#
Люблю Тебя за то, что Ты со мною
A# Gm A Dm A
И говоришь со мной с любовью неземной.

[Припев]
Dm Gm A Dm
Ты мой Бог, крепость моя,
A# Gm A Dm
В руках Твоих сила моя.

[Куплет 2]
Dm Gm A Dm
Меня Ты никогда не оставляешь
Dm Gm C F
И голос слышу Твой звучит в душе моей:
D7 Gm A A#
"Благословлю тебя, коль ты благословляешь,
A# Gm A Dm A
И силы не жалей, других люби сильней"

[Куплет 3]
Dm Gm A Dm
И снова слышу голос Твой чудесный:
Dm Gm C F
"Во всём будь совершенным, человек,
D7 Gm A A#
Как совершенный наш Отец Небесный.
A# Gm A Dm A
Надейся, верь, люби и будешь жить вовек"', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=228 | photo=notion-youth-songbook | notionPageId=29bc4497-0452-4b02-9bf9-e787b4160243 | notionChordPageId=434932f5-5d60-4285-97a0-8221c9eb3575 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/29bc449704524b029bf9e787b4160243', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты мой Бог'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=228%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты моя скала', 'Спасение', NULL, '[Куплет 1]
G C D Hm
Нет силы, Господи, не могу я так дальше жить,
Em C D G
Когда враг на пути моем все время стоит.
G C D Hm
Я взываю к Тебе: помоги мне в земной борьбе
Em C D G
Устоять на пути Твоём и служить Тебе.

[Припев]
C D
Я верю, Ты моя скала,
Hm Em
Ты сохранишь меня в пути,
C D G
И когда будет тяжело, поможешь Ты.
C D
С Тобой не страшно мне в пути,
Hm Em
С Тобой пойду на край земли,
C D G
С Тобою обрету покой в земном пути

[Куплет 2]
G C D Hm
Я счастлив, что со мной и в жизни Ты Господи,
Em C D G
Мне так легко с Тобой и хорошо.
G C D Hm
Я так хочу, всей жизнью Тебе служить,
Em C D G
И врага победить с Тобой, Спаситель мой.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=229 | photo=notion-youth-songbook | notionPageId=d1da57c6-31c4-4f96-9965-6eb3712dddd7 | notionChordPageId=aa963a46-a46c-4d84-8ee2-7754a2e33890 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d1da57c631c44f9699656eb3712dddd7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты моя скала'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=229%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты над городом этим', 'Спасение', NULL, '[Куплет 1]
C G
Ты над городом этим, и над этим народом,
Am F
И над этой страною, Господь.
C G
Ты во тьме освешаешь, озаряешь надеждой,
Am F
Утешаешь собою, Господь.
C G F
Нет такого, как наш Бог!
Am G F G
Нет такого, как наш Бог!

[Припев]
F
Грядёт пора больших чудес,
G C F G
Господь прольёт благодать с небес в этот город.
F
Грядёт пора больших чудес,
G C
Господь прольёт благодать с небес здесь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=230 | photo=notion-youth-songbook | notionPageId=1d693207-a395-4212-8ca5-e8a0e69b1d85 | notionChordPageId=f58af63e-aa0a-4fdc-9337-755a30b83dbd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1d693207a39542128ca5e8a0e69b1d85', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты над городом этим'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=230%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты не одинок', 'Утешение и ободрение', NULL, '[Куплет 1]
F
Ты идешь, в душе печаль,
Dm A# C
Ты идешь, не замечая никого вокруг.
F
Утро снова сменит ночь,
Dm A#
Быстро дни уходят прочь и ты один,
C
Но ты поверь, что…

[Припев]
F Dm
||: Ты не одинок, с тобою рядом Бог,
A# C
Знает Он печаль твою, Его глаза полны любви :||
F
Ты не одинок!

[Куплет 2]
F
Посмотри в Его глаза,
Dm A# C
Вспомни, как Христос сказал: «С тобою Я всегда».
F
Не оставлю никогда,
Dm A#
Пронесу сквозь бури, грозы, холода,
C
Ты лишь поверь, что…', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=231 | photo=notion-youth-songbook | notionPageId=1002d3ae-dd74-4365-8b81-5f24ff6080ab | notionChordPageId=e3c4559f-c0a4-4262-9625-964d257dd522 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1002d3aedd7443658b815f24ff6080ab', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты не одинок'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=231%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты не печалься', 'Пасхальные', NULL, '[Куплет 1]
Em C D G
Я постигаю сквозь слезы и боль
C Am H7 Em
Радость встречи и горечь разлуки.
Em C D G
Пью эту чашу, где сладость и соль,
C Am H7 Em
Перемешались надежда и муки.

[Припев]
Em Am D G
Ты не печалься, не беспокойся,
C Am H7 Em
Если Бог с нами - чего бояться?
Em Am D G
Ты не печалься, не беспокойся,
Em Am H7 Em
Если Бог с нами.

[Куплет 2]
Em C D G
Свободу ищу из железных оков,
C Am H7 Em
Тех, что зовутся житейское счастье.
Em C D G
Вся моя жизнь - это несколько слов
C Am H7 Em
В тихой молитве перед причастьем.

[Куплет 3]
Em C D G
И не жалея о прошлом ничуть,
C Am H7 Em
Вижу как катится мир к катастрофе.
Em C D G
Верую в крестный мной избранный путь,
C Am H7 Em
В тайну распятой любви на Голгофе.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=232 | photo=notion-youth-songbook | notionPageId=1ae74b5e-451d-41db-80bb-6d34bae241e6 | notionChordPageId=1e6c4867-9636-43a9-b558-a7782400450e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1ae74b5e451d41db80bb6d34bae241e6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты не печалься'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=232%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты объемлешь меня', 'Небо', NULL, '[Куплет 1]
C Am
Ты объемлешь меня позади, впереди,
Dm G
Полагаешь на мне руку.
C Am
Куда б не пошел, лик Твой будет со мной,
Dm G
Не укроюсь я от Духа.

[Припев]
Am Em F C
Взойду ли я на небо - Ты там, Господь,
Am Em F C
Сойду ли в преисподню - Ты там, Господь.
Am Em F
Поднимусь ли я на крыльях зари -
Dm G Dm G
Даже там ведом Тобою, любящей Твоей рукою, Господь.

[Куплет 2]
C Am
Славлю, Боже, Тебя и твои все дела,
Dm G
Ибо дивно я устроен.
C Am
Отдыхаю ли я или путь свой держу,
Dm G
Ты всегда везде со мною.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=233 | photo=notion-youth-songbook | notionPageId=944bb88a-3df9-4fd3-ae99-f1d6afc4a092 | notionChordPageId=ee67f966-fdde-48cb-a2ed-ed15dfba3abd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/944bb88a3df94fd3ae99f1d6afc4a092', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты объемлешь меня'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=233%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты оплот моего спасенья', 'Спасение', NULL, '[Куплет 1]
Em F#m Hm
Ты оплот моего спасенья,
G A Hm
Сила жизни моей.
Em F#m Hm
Свободу даешь Ты и вдохновенье.
Hm A Hm
Взываю к Тебе Я, Господь.

[Припев]
G A F#m Hm
Верю я в Тебя, верю я,
G A Hm
И люблю, Господь, Тебя!
G A F# Hm
Помощь Ты моя, спасение
Em G F#
К Тебе, Господь, я иду.

[Куплет 2]
Em F#m Hm
Ты утешаешь и вдохновляешь
G A Hm
Душу мою всегда.
Em F#m Hm
Каждый мой шаг в совершенстве знаешь:
Hm A Hm
Откуда иду и куда.

[Куплет 3]
Em F#m Hm
Рядом с Тобою, с Твоею любовью
G A Hm
Песню хвалы я пою.
Em F#m Hm
Сердцем желаю я быть с Тобою
Hm A Hm
В дивном вечном раю.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=234 | photo=notion-youth-songbook | notionPageId=a45c3033-e8c8-4cc9-98d5-7313c1cc408b | notionChordPageId=adffa1bc-6992-48af-ba4d-85df9ac39128 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a45c3033e8c84cc998d57313c1cc408b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты оплот моего спасенья'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=234%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты с нами Бог', 'Спасение', NULL, '[Куплет 1]
Am G
Из глубин души моей льётся песня о Тебе,
Dm Am E
Ты - Господь, кто всех милей в судьбе моей
Am G
Век проходит, время мчится, в сердце Божья благодать
Dm F E
Ну а песню, словно птицу, невозможно удержать.

[Припев]
Am F
Ты с нами Бог, Ты с нами Бог.
G E
Славим имя Христа - нашей веры исток.
Am F
Ты с нами Бог, Ты с нами Бог.
G E
В пылком сердце наша вера прорастет как колосок
Am
Ты с нами Бог.

[Куплет 2]
Am G
Воздух песнею наполнен отовсюду голоса
Dm Am E
Пусть её нам подпоют леса, поля.
Am G
Это песня о спасении, о любви на всей земле,
Dm F E
О великом искуплении, о тебе и обо мне,

[Куплет 3]
Am G
В нашем сердце Бог и в песне, и в росинке, и в слезе,
Dm Am E
В счастье, в горе, с нами вместе, в солнце и грозе.
Am G
Пойте реки, пойте горы и равнины и моря.
Dm F E
Имя Господа и веру снова прославляю я.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=235 | photo=notion-youth-songbook | notionPageId=0983af7f-3542-4656-810a-c525e2795c9d | notionChordPageId=3dcc744f-9e52-4b03-8e51-f9967a458dff | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0983af7f35424656810ac525e2795c9d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты с нами Бог'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=235%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Умчались безвозвратно', 'Утешение и ободрение', NULL, '[Куплет 1]
A E
Умчались безвозвратно дни вчерашние,
Hm E A
Одни следы оставив за собой,
A Hm
А в них вопрос, звучащий без пристрастия:
D E7
«С чем мы вступаем в новый день с тобой?»

[Припев]
A C#7 F#m
Пока не прекратились дни погожие,
D Hm E7
Спешите, ведь откладывать нельзя.
A C#7 F#m
Спешите сделать что-нибудь хорошее
D A E7 A
Во имя Господа, мои друзья.

[Куплет 2]
A E
Спешите ободрить душой уставшего,
Hm E A
Для счастья ближних жертвуйте собой,
A Hm
И пламенные искры сердца вашего
D E7
Зажгут в других большой любви огонь!

[Куплет 3]
A E
Быть может, тяжкой ношей обессиленный,
Hm E A
Ваш брат одолевает жизни тьму.
A Hm
Вы сделайте, что можете посильное,
D E7
Чтоб стало легче хоть чуть-чуть ему.

[Куплет 4]
A E
Сердечное участье бескорыстное
Hm E A
Полно душевной нежной теплоты.
A Hm
И ваша доброта, и ваша искренность
D E7
Помогут ближним счастье обрести.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=236 | photo=notion-youth-songbook | notionPageId=de450ee5-ff11-4ae1-bb5d-efe54d24f146 | notionChordPageId=0b24df87-9d56-44c0-bde1-6e2a21c72bf5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/de450ee5ff114ae1bb5defe54d24f146', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Умчались безвозвратно'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=236%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Упала слеза', 'Пасхальные', NULL, '[Куплет 1]
Am E7 G D
Упала слеза на горячий песок,
F C E
И кровь на ланитах застыла.
Am E7 G D
Полдневное солнце, как красный цветок,
F C E
Казалось в зените застыло.

[Припев]
Am F C G
Так только мог Всемогущий Отец
Am F G
Отдать на заклание Сына.
Am F C G
Такая любовь для отцовских сердец
F G Am
Воистину не постижима!

[Куплет 2]
Am E7 G D
Гремели доспехи, звенели мечи
F C E
Блестели на солнце палящем.
Am E7 G D
И громко смеялись, бранясь, палачи
F C E
Над Агнцем, на древе висящем.

[Куплет 3]
Am E7 G D
Когда Он любил, не любили Его;
F C E
Когда Он прощал, проклинали.
Am E7 G D
Возмездьем за зло не воздал никому
F C E
И тем, кто Его распинали.

[Мост]
За всё человечество кровь пролилась
Ценой бесконечно бесценной.
Голгофа над грешной землёй поднялась
И сделалась центром вселенной.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=237 | photo=notion-youth-songbook | notionPageId=4b68d35b-cfe0-4fe2-9bda-d23c3c9b28bf | notionChordPageId=41cecc96-465d-4783-9812-545b17a079f6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4b68d35bcfe04fe29bdad23c3c9b28bf', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Упала слеза'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=237%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Хвали Творца', 'Пасхальные', NULL, '[Куплет 1]
F C
Хвали Творца лишь день начнётся,
D Gm C
Хвали когда земля проснётся,
Dm A A#
С восходом солнечным хвали,
F C F
Хвалу приемлет Бог любви

[Припев]
F Dm
Хвала Творцу земли, хвала Творцу небес,
Gm C
Хвала Тебе за всё, великий Бог-Отец,
F D
Прими хвалу сердец за Сына и за крест,
Gm A#m F
За щедрый Дух Святой, за милость и покой.

[Куплет 2]
F C
Хвали Творца за все создание,
D Gm C
За пенье птиц и щебетанье,
Dm A A#
И с общим хором слей свой дух,
F C F
Бог близок, Божий всюду слух

[Куплет 3]
F C
Хвали Творца, как солнце светит,
D Gm C
Хвали и ночью, Он заметит.
Dm A A#
И в день, и в ночь твой чистый дар,
F C F
Молитвы шёпот, сердца жар.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=238 | photo=notion-youth-songbook | notionPageId=5c861015-5dd1-4060-b4ee-71fe10b7d1d9 | notionChordPageId=3b22852b-913b-4a56-b79d-c4b14195404c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5c8610155dd14060b4ee71fe10b7d1d9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Хвали Творца'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=238%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Храни своё сердце чистым', 'Детские', NULL, '[Куплет 1]
Много в мире искушений,
Много разного того,
Что предшествует паденью,
Что от Бога далеко.

[Припев]
Храни своё сердце чистым,
Мысли и совесть от зла береги.
Храни своё сердце чистым
Во все земные дни.

[Куплет 2]
Мир без Бога пропадает,
Называет зло добром,
И в оковах погибает,
Что зовёт Господь грехом.

[Куплет 3]
Будем мы всегда во свете
Слова Божьего ходить,
Как Его святые дети,
Под Его охраной жить.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=239 | photo=notion-youth-songbook | notionPageId=773042ed-874e-4ba6-a201-454235315956 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/773042ed874e4ba6a201454235315956 | Fill chord lines in the lead sheet before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Храни своё сердце чистым'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=239%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Христос мой, как о Тебе молчать', 'Благодарение', NULL, '[Куплет 1]
C G
Христос мой, как о Тебе молчать,
Dm G C G
Как Тебя не благодарить.
C G
Ведь Ты дал право Тебя познать
Dm G C
И Твой свет всем людям дарить.

[Припев]
Am Em
Не покидай меня, я быть хочу с Тобой
F G C
Каждый день, и час, и миг земной.
Am Em
Руку подай любя, в вечность веди меня,
F G C
В мир счастья, солнечного дня.

[Куплет 2]
C G
Творец мой, Ты для людей лишь миф,
Dm G C G
Для меня - Спаситель Христос,
C G
Создатель неба, планет и звезд,
Dm G C
Утешитель горя и слез.

[Куплет 3]
C G
Всевышний, Ты нас благослови
Dm G C G
Для труда во имя Христа.
C G
Пошли нам больше дара любви,
Dm G C
Чтоб не смолкли наши уста.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=240 | photo=notion-youth-songbook | notionPageId=0833d9f8-5398-4c05-9ea1-e36c0295c6db | notionChordPageId=82990700-4b26-4c79-b868-bd4b81463d79 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0833d9f853984c059ea1e36c0295c6db', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Христос мой, как о Тебе молчать'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=240%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Христос, для многих', 'Прощение', NULL, '[Куплет 1]
G Am
Христос, для многих Ты людей - легенда,
D G
А для моей Ты жизни - идеал,
G Am
Мне дорога священная минута,
D G
С которой для меня Ты другом стал.
G Am
Ты - жизнь моя и больше жизни нету,
D G
Я без Тебя давно б уже не жил,
G Am
Тебе доверив жизнь, пришёл я к свету,
D G
В Тебе нашёл существованья смысл.

[Куплет 2]
G Am
Держаться за Тебя хочу я крепко,
D G
Ведь Ты для грешников стал постижим,
G Am
А дьявол часто ранит в сердце метко,
D G
И Ты, Иисус, мне так необходим.
G Am
Прости, Иисус, меня, что сил так мало,
D G
В борьбе с грехом теряю я Тебя,
G Am
Я вновь найду тебя во чтоб ни стало -
D G
Ты только лишь не покидай меня.

[Куплет 3]
G Am
Порой мне грустно, скучно, одиноко,
D G
Когда Тебя не вижу впереди,
G Am
Прошу, Иисус, не уходи далёко,
D G
Ты для меня, что сердца стук в груди.
G Am
Ты – жизнь, я жить одним Тобой желаю,
D G
Всем сердцем научи Тебя любить,
G Am
Служить Тебе до смерти обещаю
D G
И посреди неверья верным быть.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=241 | photo=notion-youth-songbook | notionPageId=56a11c3b-b549-44ca-a830-9a437c070e38 | notionChordPageId=ad709fcb-3a85-4679-8997-7e6f7bdf7a67 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/56a11c3bb54944caa8309a437c070e38', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Христос, для многих'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=241%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Христос, кто бы знал', 'Пасхальные', NULL, '[Куплет 1]
Am Dm
Христос, кто бы знал Твое имя здесь,
E Am
На этой планете печальной,
F Dm
Пришел, оказался Ты жертвою,
E E7
Чтоб знал Тебя ближний и дальний.

[Припев]
Am Dm
Христос - это имя мне дорого,
G C E
Христос - это имя мне мило,
Am Dm
Христос, Ты не хочешь ни одного
E Am
Оставить в оковах греха.

[Куплет 2]
Am Dm
Распят… на Голгофу ты взгляд свой брось,
E Am
Постой, посмотри молчаливо,
F Dm
Там Кровь за тебя и меня лилась,
E E7
Чтоб мы были счастливы.

[Куплет 3]
Am Dm
Христос, освяти как всегда Ты нас,
E Am
В любви, чтоб не были пустыми,
F Dm
И тех, кто услышит весть в первый раз,
E E7
Прими в объятья святые.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=242 | photo=notion-youth-songbook | notionPageId=1a0ea6ba-ef18-4ab2-b7b3-b2c4612df49f | notionChordPageId=9caf2352-2b76-4e88-a32d-9d9727f5de92 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1a0ea6baef184ab2b7b3b2c4612df49f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Христос, кто бы знал'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=242%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Чакаем Цябе, наш Ісус,', 'Спасение', NULL, '[Куплет 1]
Dm Gm
Чакаем Цябе, наш Ісус,
A Dm
І молім: прыйдзі Ты да нас.
F C
Мы любім сваю Беларусь,
A# A
І хочам, каб Ты яе спас.

[Припев]
Gm Dm
Прыйдзі ў яе Ты двары,
F C
У вёскі прыйдзі, у гарады,
Gm Dm
Жыві ў яе сэрцы, Ісус,
A Dm
Чакае Цябе Беларусь!

[Куплет 2]
Dm Gm
Засмучана моцна яна,
A Dm
Нялёгкі дастаўся ёй лёс.
F C
І колькі ўжо слёз праліла,
A# A
Суцеш яе, любы Хрыстос!

[Куплет 3]
Dm Gm
У грахах яе гіне народ,
A Dm
Няпраўда, як цемень, лягла.
F C
Знімі ж, Ісус, гэты гнёт,
A# A
І вызваль ад лютага зла.

[Куплет 4]
Dm Gm
Як добра з Табою, Ісус,
A Dm
Як хораша там, дзе Ты ёсьць,
F C
Няхай Табе ўся Беларусь
A# A
Аддасьць сваё сэрца і лёс!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=243 | photo=notion-youth-songbook | notionPageId=432af77c-3248-4865-8e62-7cf90a920340 | notionChordPageId=90bd82aa-5bca-4133-8dcb-5280d6604fea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/432af77c324848658e627cf90a920340', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Чакаем Цябе, наш Ісус,'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=243%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Что вера без дел?', 'Молитвенные', NULL, '[Куплет 1]
Dm A
Что вера без дел? Это звук лишь пустой,
F Dm
Цветок рукодельный, цветок не живой.
A# F
То дерево с пышной листвой без плода,
Gm A
Мираж изобилья где скудость, нужда.
Dm A
Напрасны ученья, напрасны слова,
F Dm
Ведь вера без дел перед Богом мертва.
A# F
Лишь вера несущая плод для Христа,
Gm A
Велика, могуча, пред Богом свята.

[Припев]
F C
Господь с высоты наше сердце проверь,
A# F
Поведай, какая в нас вера теперь.
F C
О вере с плодами, о вере живой
A# C
Тебя умоляем, Создатель благой.

[Куплет 2]
Dm A
И если нет веры, то жизни в нас нет
F Dm
И к Богу напрасно взываем в мольбе
A# F
Лишь с верою дело угодно Отцу
Gm A
Труд сына Господь направляет к венцу.
Dm A
Бог хочет увидеть иные дела
F Dm
Чтоб жизнь твоя Богу угодна была
A# F
Чтоб дело твое было веры полно
Gm A
Начато в молитве и Духе Святом.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=244 | photo=notion-youth-songbook | notionPageId=15d38c9c-3ac4-4417-a84b-ac11e85b88ee | notionChordPageId=e1ada5b7-3f54-4baf-bdd8-1fba055cff6f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/15d38c9c3ac44417a84bac11e85b88ee', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Что вера без дел?'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=244%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Что этот свет', 'Семья', NULL, '[Куплет 1]
Hm
Что этот свет – он созданье Всевышнего,
G
Воля и разум Творца.
D A F#
Это ль не есть выражение Божьей любви?
Hm
Горы, равнины и дали лесистые,
G
Скалы, овраги и травы душистые,
Em
Утра румянец и ночи мерцание –
A F#
Бога создание, Бога дыхание!

[Припев]
Hm G D F#
Звезд дивные алмазы на черный бархат неба
Hm G D F# Hm
Ты поместил Своей рукой, поместил Своей рукой.
Hm G D F#
Нет, я еще ни разу столь к Тебе близок не был,
Hm G D F# Hm
Ты подарил душе покой, подарил душе покой.

[Куплет 2]
Hm
Что этот мрак, силы вражьей сгущение,
G
Вечно скрывает свой лик?
D A F#
Слава, Отец, что не ею дано нам спастись!
Hm
Солнце взойдет, тучи черные скроются,
G
Земли водой дождевою омоются,
Em
Птицы небесные песню Тебе поют,
A F#
Имя Твое облекая в гармонию!

[Куплет 3]
Hm
Что эта жизнь – Божий дар и служение,
G
Радость и мука души.
D A F#
Где ты найдешь совокупность столь разных в одном?
Hm
Пусть из страданий и счастие строится,
G
Лишь после смерти награда откроется.
Em
Чаша скорбей производит терпение,
A F#
Вся наша жизнь на земле – лишь мгновение!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=245 | photo=notion-youth-songbook | notionPageId=93a487f7-9f86-4705-99aa-7ff57bfc1943 | notionChordPageId=d8210e9b-9c22-4770-b515-034c6655697c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/93a487f79f86470599aa7ff57bfc1943', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Что этот свет'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=245%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Чуден Он', 'Пасхальные', NULL, '[Куплет 1]
G C
Чуден Он, наш Господь,
G C
Наш Господь, чуден Он.
G D Em
Царь царей, Божий Сын
G D G
Чуден Он, чуден Он.

[Куплет 2]
G C
Славен Он наш Господь,
G C
Наш Господь славен Он.
G D Em
Утешитель, лучший Друг
G D G
Славен Он, славен Он.

[Куплет 3]
G C
Умер Он наш Господь,
G C
Наш Господь, чуден Он.
G D Em
На кресте взял мой грех
G D G
Умер Он, умер Он.

[Куплет 4]
G C
Он воскрес, наш Господь,
G C
Наш Господь, Он воскрес.
G D Em
Чтоб меня оправдать
G D G
Он воскрес, Он воскрес.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=246 | photo=notion-youth-songbook | notionPageId=72115a4b-ac44-423d-8b78-eab83ac6b643 | notionChordPageId=f612ca0f-c2bf-4506-b59d-a9a02f4789cc | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/72115a4bac44423d8b78eab83ac6b643', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Чуден Он'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=246%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Чудную книгу полюбил я', 'Спасение', NULL, '[Куплет 1]
Dm Gm
Чудную книгу полюбил я
A Dm
Среди многих книг,
Dm Gm
В ней нахожу я утешенье
C F
В самый тяжкий миг.
Gm C
Слово Твое сокрыл я в сердце
F Dm
Слово Твое - светильник в темном месте
Gm A
Слово Твое - вода живая
Dm D
И там , где Слово, все оживает.

[Припев]
Gm C
Слово Твое — оно как молот,
F Dm
Слово Твое — огонь и щелок,
Gm A
Слово Твое — как в сотах мед
A Dm
Все обновляет и силу дает.

[Куплет 2]
Dm Gm
Не сравнится  жемчуг моря
A Dm
С красотой Христа,
Dm Gm
Нет прекрасней слов Христовых,
C F
В них вся полнота.
Gm C
Слово Твое сапфиров краше,
F Dm
Слово Твое — спасенье наше,
Gm A
Слово Твое имен всех выше
Dm D
И только словом Твоим все дышит.

[Куплет 3]
Dm Gm
Не страшны мне бури жизни
A Dm
В этом мире зла,
Dm Gm
Я к святой иду отчизне,
C F
Бог хранит меня.
Gm C
Слово Твое как меч из стали,
F Dm
Слово Твое победу дарит,
Gm A
Слово Твое — вода живая,
Dm D
И там , где Слово, все оживает.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=247 | photo=notion-youth-songbook | notionPageId=bdd385cd-16d1-4af7-9f62-4359bf749dbe | notionChordPageId=6e540925-6a08-4fd9-a7a2-2c7a6d474c5b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bdd385cd16d14af79f624359bf749dbe', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Чудную книгу полюбил я'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=247%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Шалом, мои друзья', 'Небо', NULL, '[Куплет 1]
Em F# H7 Em
Шалом, мои друзья, Храни, Господь, ваш дом!
Em F# H7 Em D
Пусть в сердце к вам войдет Шалом, шалом!
G D Am Em
:,:И хоть не прост порой Тот мир, где мы живем,
Em F# H7 Em D
Пусть окружает нас Шалом, шалом.:,:

[Куплет 2]
Em F# H7 Em
Открыта сердца дверь, живет Дух Божий в нем,
Em F# H7 Em D
И наполняет нас Шалом, шалом.
G D Am Em
:,:Улыбками сиять Давайте день за днем,
Em F# H7 Em D
Приносит радость нам Шалом, шалом.:,:

[Куплет 3]
Em F# H7 Em
С смирением в сердцах мы к Богу воззовем:
Em F# H7 Em D
«Пошли, Господь, всем нам Шалом, шалом!»
G D Am Em
:,:Нас не смутят пути, которыми пойдем,
Em F# H7 Em D
Наградой будет нам Шалом, шалом.:,:

[Куплет 4]
Em F# H7 Em
Войдем мы в град святой, там вечность обретем,
Em F# H7 Em D
И вместе с ней Господь нам дарует шалом.
G D Am Em
:,:Нас не смутят пути, которыми пойдем,
Em F# H7 Em D
Наградой будет нам Шалом, шалом.:,:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=248 | photo=notion-youth-songbook | notionPageId=77950ad4-3d34-4124-b334-0ddbda5ef95d | notionChordPageId=3182688e-d066-46d7-9c30-9bcbc963d4d3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/77950ad43d344124b3340ddbda5ef95d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Шалом, мои друзья'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=248%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Это Бог наш', 'Благодарение', NULL, '[Куплет 1]
G D Em
Ты вседержитель Бог и Царь
C G
В мире подобных нет Тебе
D Em C
Ты справедливый, верный, праведный вовек
G D Em
Создано все Господь Тобой
C G
И в небесах и на земле
D Em C
Всем управляешь мудро – жизнь в Твоей руке
G C
Кто так свят и справедлив?
G C
Неизменен и велик?

[Припев]
G
Это Бог наш - Царь Всемогущий
D
Бог наш – Творец Вездесущий
Em C
Бог наш - Мудрый и Сильный Господь
C
Над нами
G
Это Бог наш - Спасенье для грешных
D
Бог наш - Любовь и Надежда
Em C
Бог наш - Великий и Чудный Господь
C
Над нами

[Куплет 2]
G D Em
Нас от начала возлюбил
C G
И примирил с Собою Ты
D Em C
Благодаря Христу, Его святой крови
G D Em
Ты ввел нас в царствие Своё
C G
Истинный путь нам указал
D Em C
От власти тьмы избавив Ты свободу дал
G C
Кто есть истина и жизнь?
G C
Кто нас спас, грехи простив?

[Мост]
Кто так свят и справедлив?
Неизменен и велик?
Кто есть истина и жизнь?
Кто нас спас, грехи простив?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=249 | photo=notion-youth-songbook | notionPageId=3c7d1d51-eac3-42cc-a699-286cd851a7d7 | notionChordPageId=40829b5c-b3ea-456c-a7fa-d67550e5bb7a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3c7d1d51eac342cca699286cd851a7d7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Это Бог наш'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=249%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Юность белоснежную', 'Спасение', NULL, '[Куплет 1]
G Am
Юность белоснежную береги от зла.
D G
Как фиалку нежную пред собой неся.
H Em C
Миру тьмы лукавому власть не отдавай.
D G
И греху всевластному ты скажи: «прощай».

[Куплет 2]
G Am
Сердце тебе чистое подарил Христос,
D G
Солнышко лучистое, шум морей и гроз.
H Em C
И в одежды святости Он тебя одел,
D G
Не испачкай пятнами недостойных дел.

[Куплет 3]
G Am
Пусть работой чистою годы протекут,
D G
И венцы небесные увенчают труд.
H Em C
И в святых обителях, получивши жизнь,
D G
На алтарь Спасителя молодость сложи.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=250 | photo=notion-youth-songbook | notionPageId=640cf3be-256d-4b0b-a805-8bfd719abf5d | notionChordPageId=44ba5401-b745-44d4-af83-e8ff353804df | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/640cf3be256d4b0ba8058bfd719abf5d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Юность белоснежную'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=250%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Юность пройдет', 'Прославление', NULL, '[Куплет 1]
Am Dm
Сегодня, друзья, мы вместе
G C
И нам юность дана,
F Dm
Но она пройдёт незаметно
E
Когда и куда.

[Припев]
Am Dm
Юность пройдёт,
G C
Оставив лишь память,
F Dm
Память о лучшем
E Am
В нашей жизни, друзья.

[Куплет 2]
Am Dm
Чтоб было, что вспомнить
G C
Нам о юности, друзья,
F Dm
Будем жить мы для Иисуса,
E
Прославлять Его всегда.

[Куплет 3]
Am Dm
Посвятим же, друзья сегодня
G C
Наши юные года
F Dm
Прославлять Отца Всеблагого
E
За дивные дела.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=251 | photo=notion-youth-songbook | notionPageId=eb5c1d5f-aac1-43a4-b0f8-9a2367acc5e8 | notionChordPageId=dd4a151a-15b0-4f6a-90c0-b569523d0bf0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/eb5c1d5faac143a4b0f89a2367acc5e8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Юность пройдет'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=251%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Юность светлая', 'Вера и упование', NULL, '[Куплет 1]
Hm
Юность светлая, весна ранняя -
Em A D
Мы её Христу принесём,
Em G
Молодые мы в золотые дни
F# Hm
Лишь для Господа живём!

[Куплет 2]
Hm
Тьма неверия окружает нас,
Em A D
Туча чёрная впереди,
Em G
Мы Христа огни в эти злые дни
F# Hm
Расставляем на пути.

[Куплет 3]
Hm
Хоть и труден путь и тернистый он,
Em A D
Со Христом его мы пройдём.
Em G
Молодые мы в золотые дни
F# Hm
Лишь для Господа живём!

[Куплет 4]
Hm
О не бойся, друг, не смущайся, брат,
Em A D
Проходя свой жизненный путь!
Em G
Впереди тебя твой Христос прошел
F# Hm
И тебя идти зовет.

[Куплет 5]
Hm
Так спеши же, друг, посвятить Христу
Em A D
Утро юности, жизни дни,
Em G
И Он даст тебе золотой венец,
F# Hm
Будешь царствовать ты с Ним.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=252 | photo=notion-youth-songbook | notionPageId=e96e6d81-5d9b-47ad-aae6-2ae46f0cdb84 | notionChordPageId=711123a2-73e0-433a-9d5a-dce0cedc20dc | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e96e6d815d9b47adaae62ae46f0cdb84', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Юность светлая'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=252%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я без Тебя', 'Спасение', NULL, '[Куплет 1]
D H
Я без Тебя, как солнце без света.
Em A
Я без Тебя, как парусник в море без ветра,
D Hm
Я, как дитя, без материнской ласки.
Em A
Без Тебя, Господь, тускнеют в жизни краски.

[Куплет 2]
D H
Ты для меня, как свежий дождь в знойное лето.
Em A
Ты для меня укрытие от сильного ветра.
D Hm
Ты для меня, как маяк для заблудшего корабля
Em A
Ты, Господь, моя обетованная Земля.

[Куплет 3]
D H
В бурю и шторм твердо я уповаю:
Em A
Кроме Тебя защиты другой я не знаю.
D Hm
Ты - мой покой. Ты - скала. Ты - мое утешение.
Em A
Ты в любой беде, Господь, мое спасение.

[Куплет 4]
D H
Я без Тебя, как солнце без света.
Em A
Я без Тебя, как парусник в море без ветра,
D Hm
Я, как дитя, без материнской ласки.
Em A
Без Тебя, Господь, тускнеют жизни краски.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=253 | photo=notion-youth-songbook | notionPageId=77ce7c1b-1395-407f-9987-172f155fde48 | notionChordPageId=d26861eb-ecb8-4f86-9956-27e7290a96b3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/77ce7c1b1395407f9987172f155fde48', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я без Тебя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=253%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я Бог неба', 'Спасение', NULL, '[Куплет 1]
G C G
Я Бог неба и морей
C G D
Я услышал плач людей.
Em C Am
Всех, кого терзает грех,
C D
Спасу Я тех.
G C G
Я, кто звезды сотворил,
C G D
Бездну светом озарил.
Em C Am
Кто Мой свет им принесет?
C D
Кто к ним пойдет?

[Припев]
D G C G C
Вот я, Боже,здесь я, Боже.
C G C Am D
Я услышал голос Твой в тиши.
D G C G C
Меня вышли, о Всевышний,
C Em C D G
Твой призыв на сердце напиши.

[Куплет 2]
G C G
Я Бог снега и дождей,
C G D
Но других себе вождей
Em C Am
Избирает мой народ.
C D
Кто к ним пойдет?
G C G
Не по их делам воздам,
C G D
Сердце новое им дам.
Em C Am
Кто захочет им сказать?
C D
Кого послать?

[Куплет 3]
G C G
Я, Бог молний и ветров,
C G D
Принять страждущих готов,
Em C Am
Кем гнушается весь мир,
C D
Зову на пир.
G C G
Лучший хлеб Я преломлю,
C G D
Жажду сердца утолю.
Em C Am
Кто захочет им сказать?
C D
Кого послать?', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=254 | photo=notion-youth-songbook | notionPageId=41d8cc95-bea3-4efc-b589-422829c69bea | notionChordPageId=65d08502-46b6-4d4c-b6b1-70498102cdf9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/41d8cc95bea34efcb589422829c69bea', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я Бог неба'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=254%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я в бессмертье иду', 'Вера и упование', NULL, '[Куплет 1]
Dm A Dm
Я в бессмертье иду, наступая на зло,
F C F
Из скорбей и страданий дорога.
A# F D Gm
На душе у меня и тепло и светло,
Dm A Dm
Потому что я верую в Бога.

[Куплет 2]
Dm A Dm
Знаю я, что мне можно и что мне нельзя.
F C F
Знаю, что хорошо и что плохо.
A# F D Gm
Знаю, что на земле существую не зря,
Dm A Dm
Потому что я верую в Бога.

[Куплет 3]
Dm A Dm
Против истины войско ведет сатана.
F C F
Духи зла ополчились как звери.
A# F D Gm
Ждет меня впереди неземная страна,
Dm A Dm
Потому что я в Господа верю.

[Куплет 4]
Dm A Dm
Даже если встречаю следы катастроф.
F C F
Исчезает из сердца тревога,
A# F D Gm
Как подумаю я, что есть любящий Бог,
Dm A Dm
То я счастлив, что верую в Бога.

[Куплет 5]
Dm A Dm
Нет от радости слов, очень мне повезло,
F C F
Мною найдена в небо дорога.
A# F D Gm
На душе у меня и тепло и светло,
Dm A Dm
Потому что я верую в Бога.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=255 | photo=notion-youth-songbook | notionPageId=4ba44c97-dcbf-4c96-8ea3-44676eaa4546 | notionChordPageId=8b4a6156-39b4-4f88-85bf-007b03302996 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4ba44c97dcbf4c968ea344676eaa4546', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я в бессмертье иду'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=255%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я жду Тебя', 'Пасхальные', NULL, '[Куплет 1]
E C#m
Как земля без дождя в знойное лето
F#m A H
Как весна без цветов иль рассвет без россы
E C#m
Без Тебя, мой Господь, нет жизни и света
F#m H E
Я нуждаюсь в Тебе, о Иисус приходи.

[Припев]
E C#m
Я жду Тебя, рассвет предваряя
F#m A H
Я жду Тебя, склоняясь в тиши
E C#m
Я жду Тебя, все сердцем взывая
F#m H E
Я жду Тебя, о Иисус, приходи.

[Куплет 2]
E C#m
На кресте Он страдал, кровь за нас проливая,
F#m A H
Чтоб простить и омыть все людские грехи.
E C#m
О, придите к Христу, Бог вас призывает
F#m H E
У подножья креста есть прощенье для всех.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=256 | photo=notion-youth-songbook | notionPageId=043375d9-d2ea-42fd-9961-f22dfcd15ad6 | notionChordPageId=052f9f03-287d-446b-bd10-8bf1d4227230 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/043375d9d2ea42fd9961f22dfcd15ad6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я жду Тебя'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=256%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я иду земными битвами', 'Рождественские', NULL, '[Куплет 1]
Em Am
Я иду земными битвами,
H7 Em
Как в степи идет пастух,
Em Am
И сердечными молитвами
H7 Em
Укрепляется мой дух.
E7 Am
И сердечными молитвами
D G
И сердечными молитвами
C Am
И сердечными молитвами
H7 Em
Укрепляется мой дух

[Куплет 2]
Em Am
Я иду в страну далекую,
H7 Em
В дом Небесного Отца,
Em Am
Где течет рекой широкою
H7 Em
Славословье без конца.
E7 Am
Где течет рекой широкою
D G
Где течет рекой широкою
C Am
Где течет рекой широкою
H7 Em
Славословье без конца.

[Куплет 3]
Em Am
И когда войду в селение,
H7 Em
Я увижу в тот же миг,
Em Am
Среди ангельского пения
H7 Em
Милосердный Божий лик.
E7 Am
Среди ангельского пения
D G
Среди ангельского пения
C Am
Среди ангельского пения
H7 Em
Милосердный Божий лик.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=257 | photo=notion-youth-songbook | notionPageId=e00e3d8d-6a1d-47c6-822a-3263a7ea70cb | notionChordPageId=75f922f7-3578-4cce-a90f-fc8a055a576c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e00e3d8d6a1d47c6822a3263a7ea70cb', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я иду земными битвами'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=257%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я один из тех', 'Пасхальные', NULL, '[Куплет 1]
Am Dm E Am
Я один из тех, кого Ты заметил,
Dm E Am
Я один из тех, кого Ты не прошел,
G C
Я один из тех, кто зимой и летом
Dm E E7
Твоим солнечным светом греет душу свою.

[Припев]
Am F
Иисус – я один из многих,
Dm E E7
Чьи пути, дороги к Тебе ведут.
Am F
Иисус, Ты готовишь город,
Dm E Am
Нас там будет много, я – один из них!

[Куплет 2]
Am Dm E Am
Я один из тех, чьи грехи забыты,
Dm E Am
Я один из тех, кого Ты простил.
G C
Я один из тех, кто был на Голгофе,
Dm E E7
Видел гроб Твой пустым, Иисус – Ты воскрес!

[Куплет 3]
Am Dm E Am
Я один из тех, кто поет Тебе песни,
Dm E Am
Я один из тех, кто любит Тебя.
G C
Я один из тех, кто с Тобой будет вместе
Dm E E7
В Царстве Небесном вовеки-веков', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=258 | photo=notion-youth-songbook | notionPageId=713a084d-45db-499b-968c-bf3fea6bf258 | notionChordPageId=88c28778-fe83-41e0-848f-af8770859a8e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/713a084d45db499b968cbf3fea6bf258', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я один из тех'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=258%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я опускаюсь на колени', 'Молитвенные', NULL, '[Куплет 1]
C Em
Я опускаюсь на колени,
C D
Перед Тобою мой Господь.
C Em
И вот опять я в изумлении
C D
Как Ты устроил этот мир.

[Припев]
G Em
В своей молитве я прошу,
C D
С надеждою и верой:
G Em
Любви смирения пред Тобой,
C D
Веди нас за Собою,
G Em
Когда мы падаем,
C D
Ты нас не оставляешь -
G Em
Своей крепкою рукою,
C D
Нас снова поднимаешь.

[Куплет 2]
C Em
Бродил я долго в заблуждении,
C D
И вот однажды попросил:
C Em
О, Боже, дай нам вразумление,
C D
И Ты мне истину открыл.

[Куплет 3]
C Em
Мое Ты сердце освятил,
C D
Прекрасною любовью,
C Em
За грешный мир Ты заплатил,
C D
Своей невинной кровью.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=259 | photo=notion-youth-songbook | notionPageId=3a4c8fdb-e08b-4e51-8a34-123370179ddd | notionChordPageId=fc461e54-4a11-416a-b372-835f851bd020 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3a4c8fdbe08b4e518a34123370179ddd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я опускаюсь на колени'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=259%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я прихожу к Тебе пустой', 'Семья', NULL, '[Куплет 1]
Dm A# F
Я прихожу к Тебе пустой,
Dm A# F
Я прихожу к Тебе больной.
Dm A# F
Я знаю, Ты Своей рукой
Dm A# F
Поднимешь вновь и дашь покой.

[Припев]
Dm A# F
В Тебе надежда моя необъятно-вечная!
Dm A# F
В Тебе мой свет, Ты — звезда моя путеводная!
Dm A# F
Ты — моя крепость и песня моя победная!
Dm A# F
В Твоих надёжных руках на века душа моя.

[Куплет 2]
Dm A# F
Я так устал бродить слепой,
Dm A# F
Прошу, глаза мне вновь открой,
Dm A# F
Я будто вновь едва живой…
Dm A# F
Отец, я так хочу домой.

[Куплет 3]
Dm A# F
Ты исцеляешь жизнь мою,
Dm A# F
Ты укрепляешь слабую душу.
Dm A# F
В Твоей любви всегда стою, верен Ты!
Dm A# F
Ты не допустишь в жизнь мою пустоты.

[Мост]
Ты днём и ночью видишь всё, Ты знаешь сердце моё,
Но, не смотря на всё, дитем меня назвал.
Ты раз и навсегда принял, очистил, оправдал,
Поверил в меня больше, чем я сам.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=260 | photo=notion-youth-songbook | notionPageId=3752b018-f657-45d2-9ee4-6639e1e82625 | notionChordPageId=d3bafbf5-f4c1-4b77-838d-2aa13b48cd28 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3752b018f65745d29ee46639e1e82625', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я прихожу к Тебе пустой'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=260%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я радуюсь всесильно', 'Благодарение', NULL, '[Куплет 1]
D A7 D
Я радуюсь, что ты живёшь на свете:
G A7 D
Поёшь, мечтаешь также, как и я,
G A7 D Hm
Что нас не сломит самый сильный ветер,
G A7 D D7
И мы с тобой хорошие друзья.

[Куплет 2]
D A7 D
Я радуюсь тому, что Бог предвечный,
G A7 D
Нам кровью Сына счастье подарил,
G A7 D Hm
Сам в руки дал негаснущую верность
G A7 D D7
И свет её в глазах у нас горит.

[Куплет 3]
D A7 D
Я радуюсь и радуюсь всесильно,
G A7 D
И благодарен Богу моему,
G A7 D Hm
И знаю я, что вера будет вечной,
G A7 D D7
И я тебя на небе обниму.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=261 | photo=notion-youth-songbook | notionPageId=cc753c23-79ce-4509-9d32-d93d442724d7 | notionChordPageId=df35be22-da46-47ba-afa0-9669d16ad936 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/cc753c2379ce45099d32d93d442724d7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я радуюсь всесильно'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=261%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я радуюсь, что Бог...', 'Спасение', NULL, '[Куплет 1]
A F#m D
Я радуюсь, что Бог мимо не прошёл
E A
И спас меня.
A F#m D
И Он теперь ведёт в Свой небесный дом
E A
Меня, храня.

[Припев]
F#m C#m F#m C#m
Я иду за Богом по Его дорогам,
D A E
Преодолевая жизни суету.
F#m C#m F#m C#m
Помоги мне, Боже, нет Тебя дороже,
D E A
Я хочу постигнуть жизни полноту.

[Куплет 2]
A F#m D
Я встречу на пути ураган и шторм,
E A
Но не сломлюсь.
A F#m D
Ведь за руку Отца каждый день крепко
E A
Я держусь.', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=262 | photo=notion-youth-songbook | notionPageId=99cdcddf-751e-4dfb-b345-3effe94ac2b9 | notionChordPageId=5c444f08-554f-4658-a6f8-ef8340891e42 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/99cdcddf751e4dfbb3453effe94ac2b9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я радуюсь, что Бог...'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=262%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lead_sheet, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я смотрю на крест', 'Пасхальные', NULL, '[Куплет 1]
Hm A G Hm A G
Я смотрю на крест, на нём страдал Господь.
Hm A G Hm A G
Он умер и воскрес, в Его глазах любовь.
Em G Hm
Я подойду к Нему в Его глаза взгляну, и поклонюсь всем сердцем.
Em G Hm
Отдав Себя на смерть, Он подарил мне жизнь!
A
И любовь!

[Припев]
D A
Дорогой ценой я искуплен от греха.
Hm G
Дорогой ценой небо открыто.
D A
Дорогой ценой спасена душа моя.
Hm A G
В моём сердце есть надежда и сила!

[Куплет 2]
Hm A G Hm A G
Сокрушаюсь я , в сердце тяжкий груз.
Hm A G Hm A G
Но я приношу, всё Тебе Иисус.
Em G Hm
У креста стою и осознаю: не достоин я.
Em G Hm
Но благодать Твоя, вновь воскрешает меня,
A
Верю я!', NULL, NULL, NULL, 'Seed import', NULL, '[staging:songbook-staging-2026-08-14] oldNumber=263 | photo=notion-youth-songbook | notionPageId=f54327d3-9978-4c3f-86a7-b95dfde28dc4 | notionChordPageId=0a13753a-6a1e-4a2d-81b3-ada61d2ef309 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f54327d399784c3f86a7b95dfde28dc4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я смотрю на крест'
    AND note LIKE '[staging:songbook-staging-2026-08-14] oldNumber=263%'
  LIMIT 1
);

COMMIT;
