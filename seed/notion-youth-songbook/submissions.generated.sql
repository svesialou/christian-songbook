SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'А ты не думай', 'Молодёжный сборник', NULL, 'Куплет 1:
А ты не думай, что тебе тяжело,
А ты не думай, что тебе лишь темно,
А ты забудь, что на сердце печаль.
Ты помни лишь о том:
Припев:
// В жизни надо успеть //
// И на небо посмотреть, //
Другу улыбнуться, сказать “прости”.
// В жизни надо успеть //
// Хоть одну песню спеть, //
Людям радость дать и о Боге рассказать.
И о Боге рассказать.
Куплет 2:
Вспомни: тебе надо любить,
Вспомни: и обиды все простить,
Помни, что другому тяжело.
Подставь ему своё плечо.', 'Куплет 1:
D Hm
Em A
D Hm
Em G A
Припев:
D
Hm
Em A
D
Hm
Em G A
D
Куплет 2:
D Hm
Em A
D Hm
Em G A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=1 | photo=notion-youth-songbook | notionPageId=b7e923e9-208c-423f-9f0c-ab265a5b8983 | notionChordPageId=adb7c20c-b77a-4da4-8491-706696cbd589 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b7e923e9208c423f9f0cab265a5b8983', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'А ты не думай'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=1%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Агнец Пасхальный', 'Молодёжный сборник', NULL, 'Куплет 1:
Над Голгофою тьма нависла, тучи солнце закрыли быстро,
Вся стонет земля от смерти Царя.
Содрогается от рыданий, ибо чувствует боль страданий,
Кровь Божья течёт к ней со креста.
Между небом и землей Агнец Божий умирает,
Он на древо вознесен, ад объятья раскрывает…
Припев:
Но смерть Его не в силах удержать,
Рождён, чтоб побеждать, и принести спасенье!
Он пришёл свободу пленным дать,
Прощать и исцелять, и Свыше дать рожденье!
Куплет 2:
Он народом Своим отвержен, Он страданиям был подвержен,
Но словно овца, безгласен был.
се друзья Его разбежались, Его били, над Ним смеялись,
Но Он до конца чашу испил…
“Совершилось!” - Он сказал, в храме порвана завеса,
Исполняя Божий план, умер в муках и воскрес Он!
Мост:
Он наш Агнец Пасхальный, заклан за нас, заклан за нас.
Претерпел Он страданья, Кровью нас спас, Кровью нас спас!', 'Куплет 1:
Am Dm Am Dm
C G F G
Am Dm Am Dm
C G F G
Dm Am F C Dm Am
F Am F C Dm E
Припев:
A E D A
D A Hm E
A E D A
D A Hm E
Куплет 2:
Am Dm Am Dm
C G F G
Am Dm Am Dm
C G F G
Dm Am F C Dm Am
F Am F C Dm E
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=2 | photo=notion-youth-songbook | notionPageId=7576a9df-f607-4039-936f-bd591ac41938 | notionChordPageId=b0522ea3-c67c-4e0d-a40e-917d56defe31 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7576a9dff6074039936fbd591ac41938', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Агнец Пасхальный'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=2%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ангелы в небе', 'Молодёжный сборник', NULL, 'Куплет 1:
Ангелы в небе Господа славят,
Славу достойную Богу поют, Богу поют:
Вечная слава, вечная слава,
Вечная слава, слава Христу!
Слава Христу!
Куплет 2:
Хочется с ангельским пением слиться
В хоре искупленных спасенных Господом.
И сердце Господу, Богу единому,
Христу Спасителю славу поет.
Славу поет!
Куплет 3:
Здесь, на земле людей, Церковь томится,
К небу стремится, дух к Жениху влечёт.
О, гряди, Господи, видишь, невеста ждёт
Тебе Единому славу поёт.
Славу поет!
Куплет 4:
Чудный прославленный, царственный Божий Сын,
Дивный Христос Господь в небе нас ждёт.
И сердце Господу, Богу Единому,
Христу Спасителю славу поёт.
Славу поет!', 'Куплет 1:
Em H
Am H Em E
Am D G C
Am H Em
E
Куплет 2:
Em H
Am H Em E
Am D G C
Am H Em
E
Куплет 3:
Em H
Am H Em E
Am D G C
Am H Em
E
Куплет 4:
Em H
Am H Em E
Am D G C
Am H Em
E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=3 | photo=notion-youth-songbook | notionPageId=e83a746c-21f0-4488-8166-90a56a931022 | notionChordPageId=e6f8ae5a-f3dc-4e42-a89f-e3f5198e90ae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e83a746c21f04488816690a56a931022', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ангелы в небе'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=3%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Баллада о трёх сыновьях', 'Молодёжный сборник', NULL, 'Куплет 1:
В краю средь гор и цветущих долин
Текла река, исчезая вдали.
Прекрасней не было страны,
Где рождались баллады и сны.
В дорогу звал глас таинственных гор.
Три сына там покидали свой дом.
Один был горд, другой - упрям,
А третий был сердцем смирен.
Слова Отца были грусти полны:
"В любви моей вы росли, как цветы.
Что ждет вас там, в чужих краях.
Да хранит вас молитва моя".
И звучало в ответ эхо горных вершин
"Сохраните богатство души
И любви нескончаемый свет".
Куплет 2:
Прошли года, затерялись вдали.
В краю средь гор и цветущих долин
Встречал отец своих детей
После долгих разлук и скорбей.
И первый сын возвратился домой:
"Гордись, отец, - я великий герой.
Вся власть моя, и в этом суть
На крови я построил свой путь".
Второй принес золотые дары:
"Смотри, отец, я могу все миры
Купить, продать и слезы всех
Превратить в серебро и успех."
И звучало в ответ эхо горных вершин
"Разменяли богатство души
Ради славы и блеска монет".
Мост:
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
Верный сын унаследовал трон.', 'Куплет 1:
Em Am D Em
Em Am D Em
C D Hm C
Am D Em
Em Am D Em
Em Am D Em
C D Hm C
Am D Em
Em Am D Em
Em Am D Em
C D Hm C
Am D Em
C D Em C D Em
C D Hm C
Am D Em
Куплет 2:
Em Am D Em
Em Am D Em
C D Hm C
Am D Em
Em Am D Em
Em Am D Em
C D Hm C
Am D Em
Em Am D Em
Em Am D Em
C D Hm C
Am D Em
C D Em C D Em
C D Hm C
Am D Em
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=4 | photo=notion-youth-songbook | notionPageId=3d2948d7-632e-4578-86ef-c6a2868837c4 | notionChordPageId=e32e8382-3297-4dc6-a61f-b5957e61851b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3d2948d7632e457886efc6a2868837c4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Баллада о трёх сыновьях'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=4%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благо есть славить Господа', 'Молодёжный сборник', NULL, 'Куплет 1:
Благо есть славить Господа
И петь имени Твоему, Спаситель,
Возвещать утром милость Твою
И истину Твою везде.
Припев:
Ты возвеселил душу мою,
Я Тебе, Господь, хвалу пою!
Дела Твои велики, мой Отец,
Ты мой Творец!
Куплет 2:
Возвожу свои очи к горам,
Возношу свои руки к небу.
Я познал, что Господь есть Бог
И на земле и в небесах.
Куплет 3:
Ты укажешь мне жизни путь,
Да не постыжусь, что к Тебе взываю,
На Тебя уповаю я,
Благослови, Господь, меня.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=5 | photo=notion-youth-songbook | notionPageId=a03f83e5-cf38-433d-b124-01a999feb4e8 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/a03f83e5cf38433db12401a999feb4e8 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благо есть славить Господа'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=5%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благодарные сердца', 'Молодёжный сборник', NULL, 'Куплет 1:
Благодарные сердца, поспешите в дом Отца!
Урожай свезли с полей до прихода зимних дней.
Бог - начало всех начал - нам все нужное послал.
Поспешите в Божий дом вознести хвалы псалом!
Припев:
Наш Господь опять придет, жатву с поля соберет,
Все соблазны удалит, рай желанный возвратит.
Даст Он ангелам приказ: сжечь все плевелы огнем,
А пшеницу в тот же час отнести в небесный дом.
Куплет 2:
Мир весь - поле, что давно Богу плод принесть должно.
Плевел и пшеница тут рядом издавна растут.
Сперва зелень, позже - плод, так идет из рода в род.
Боже, молим об одном: сделай добрым нас зерном!
Куплет 3:
Ей, гряди, Господь, гряди! Церковь молит, Церковь ждет;
Свой народ освободи от греха и от забот.
Обновленные душой вечно будем жить с Тобой.
Боже, Боже, поспеши, в мире жатву соверши!', 'Куплет 1:
A F#m D E
A F#m D E
F#m D E C#
D E E7
Припев:
A C# F#m C#m
D A D E
A C# F#m C#m
D A D E A
Куплет 2:
A F#m D E
A F#m D E
F#m D E C#
D E E7
Куплет 3:
A F#m D E
A F#m D E
F#m D E C#
D E E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=6 | photo=notion-youth-songbook | notionPageId=8321e7f6-2cec-4848-8c04-5e1254def079 | notionChordPageId=c894bf77-0f2c-4bba-bc8c-3b35ac25a1cb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8321e7f62cec48488c045e1254def079', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благодарные сердца'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=6%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благословен тот дом', 'Молодёжный сборник', NULL, 'Куплет 1:
Благословен тот дом, где в каждом чистом сердце
Слово святое Господа живет,
Нет власти тьмы, и страха смерти,
И Сам Господь в тот дом хозяином войдет.
Припев:
Благословен! Благословен!
Блгословен тот дом.
Куплет 2:
Благословен тот дом, где в тихий час молитвы
Духом Святым Господь касается сердец,
Где радости счастья, любви в избытке,
И благодать излил небесный наш Отец.
Куплет 3:
Благословен тот дом, где старость уважают,
Где веру свято берегут из рода в род,
Славят Творца и Библию читают,
И возрастают в мудрости из года в год.', 'Куплет 1:
Hm Em F# Hm
Hm Em F#
H Em A D
G Em F#
Припев:
Hm F# Hm
Hm F# Hm
Куплет 2:
Hm Em F# Hm
Hm Em F#
H Em A D
G Em F#
Куплет 3:
Hm Em F# Hm
Hm Em F#
H Em A D
G Em F#', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=7 | photo=notion-youth-songbook | notionPageId=600a0575-0dff-4805-ae68-4735de5f94e3 | notionChordPageId=1d55b8b7-5ada-42c9-8916-e8859b4c92f0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/600a05750dff4805ae684735de5f94e3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благословен тот дом'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=7%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Благослови Господа, душа моя', 'Молодёжный сборник', NULL, 'Куплет 1:
Буду петь Господу всю жизнь мою.
Буду петь Ему доколе я жив.
Да будет благоприятна песнь моя,
Возвеселюсь, возрадуюсь о Господе.
Припев:
Благослови, душа моя, Господа!
Благослови, душа моя, Господа!
Куплет 2:
Буду петь Господу всю жизнь мою.
Буду петь Ему доколе я жив.
Как высоко небо над землею
Так велика, чудесна милость Господа.
Куплет 3:
Буду славить Творца всем сердцем я,
Благодарить Его каждый миг,
Как далеко восток от запада,
Так удалил Он от нас наши грехи.', 'Куплет 1:
D G D
A7 D A7
D G D
Em A D D7
Припев:
G A7 F#m Hm
Em A7 D D7
Куплет 2:
D G D
A7 D A7
D G D
Em A D D7
Куплет 3:
D G D
A7 D A7
D G D
Em A D D7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=8 | photo=notion-youth-songbook | notionPageId=8be04214-b121-45b3-8fab-27b76d4da3c5 | notionChordPageId=621d0c72-5f08-4881-b7d4-a052e3b5a250 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8be04214b12145b38fab27b76d4da3c5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Благослови Господа, душа моя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=8%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог избрал нас', 'Молодёжный сборник', NULL, 'Куплет 1:
Бог избрал нас из разных народов,
Дал нам имя Свое.
Бог избрал нас из разных племен и языков,
Но дал нам сердце одно!
Припев:
Когда мы вместе – мы сильны!
Когда мы вместе – Господь среди нас!
Когда мы вместе – потоки Божьей любви
Льются с небес на нас.
Куплет 2:
Мы есть Церковь – Мы есть Тело Христа,
Мы искуплены кровью Его!
Врата ада не одолеют нас,
Потому, что с нами Господь!', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=9 | photo=notion-youth-songbook | notionPageId=53aa0387-82b2-4766-948b-9dc62c83227f | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/53aa038782b24766948b9dc62c83227f | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог избрал нас'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=9%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог мой, во мне Ты', 'Молодёжный сборник', NULL, 'Куплет 1:
Бог мой, во мне Ты,
Лишь Ты один наполнил жизнь мою.
Бог мой, со мной Ты,
Тебе навеки сердце отдаю.
Припев:
Ты во мне - я заново родился,
Ты во мне - я счастье приобрёл,
Ты ко мне, как солнца свет явился,
И в Тебе я жизни смысл нашёл.
Куплет 2:
Радость, печали,
Порой бывает сердцу тяжело.
О счастье мечтали
И вот оно навеки к нам пришло.', 'Куплет 1:
G Am
C D G
G Am
C D G
Припев:
Em C D
Em C D
Em C D
Em C D G
Куплет 2:
G Am
C D G
G Am
C D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=10 | photo=notion-youth-songbook | notionPageId=4681f5ad-a334-4151-8380-096cf70d345c | notionChordPageId=6c393284-7517-4c77-847a-bd996b81e7d7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4681f5ada33441518380096cf70d345c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог мой, во мне Ты'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=10%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог пришел и умер за меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Бог пришел и умер за меня, аминь, аминь
Победу одержал над силой зла, аминь, аминь
Распят был, но он воскрес, аминь, аминь
Сидящий на престоле Властелин, аминь, аминь
Припев:
Слава Тебе Господь мой Всемогущий
Слава Тебе Великий Бог
Я пою Тебе всем сердцем Бог мой Всемогущий
Слава Тебе мой Бог.
Куплет 2:
Руки Господа покрыла Кровь, аминь, аминь
Но гвозди не могли держать его, аминь, аминь
И Любовь отца, для нас течет, аминь, аминь
Аллилуйя он опять Грядет, аминь, аминь
Мост:
Ты вечный и Святой, Сущий вовек веков
Ты был и есть и вновь грядешь
Ты вечный и Святой, Сущий вовек веков
Ты был и есть и вновь грядешь', 'Куплет 1:
Dm A# F C
Dm A# F C
Dm A# F C
Dm A# F C
Припев:
F Gm F A#
F Gm F A#
F Gm F A#
A# C F
Куплет 2:
Dm A# F C
Dm A# F C
Dm A# F C
Dm A# F C
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=11 | photo=notion-youth-songbook | notionPageId=1fd3c678-3c1d-4219-b603-1ff73359baa5 | notionChordPageId=dcbbacaf-614e-42da-8855-a04a7f6e93a9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1fd3c6783c1d4219b6031ff73359baa5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог пришел и умер за меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=11%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Бог с нами в долине удачи', 'Молодёжный сборник', NULL, 'Куплет 1:
Бог с нами в долине удачи,
И близок в часы неудач.
Когда мы смеемся и плачем,
Он с нами, Господь наш и врач.
В глубокие топи уныния,
В ущелья, где смертная тень.
Спускается Он и доныне,
Чтоб нам помогать каждый день.
Припев:
Скажем вместе: Богу слава! Богу слава!
Скажем вместе: Мы идем за Тобой.
Куплет 2:
Он с нами, когда наше знамя,
Которому имя любовь.
Торжественно реет над нами,
Вобрав в себя образ Христов.
Когда мы людей утешаем,
Слагая дела и слова.
Любовью своей подтверждаем,
Что вера у нас не мертва.
Куплет 3:
Бог с нами когда мы по слову
В обыденной жизни живём
Когда по сердечному зову
Во имя Иисуса идём
Когда расширяем границы
Для новых людей Благодать
Есть смысл для Иисуса трудиться
Есть смысл для Иисуса страдать
Куплет 4:
Бог с нами когда нас немного
Когда его имя несём
Ведь сила Великого Бога
Сердца наполняет огнём
Бог с нами Он в нашем собрании
И он нас в обиду не даст
Исполнятся наши желания
В назначенный Господом час', 'Куплет 1:
Em
D
C
H7
Em
D
C
H7
Припев:
Em Am
H7 Em H7
Куплет 2:
Em
D
C
H7
Em
D
C
H7
Куплет 3:
Em
D
C
H7
Em
D
C
H7
Куплет 4:
Em
D
C
H7
Em
D
C
H7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=12 | photo=notion-youth-songbook | notionPageId=569dac52-3c7e-45f5-b957-fbc45b8bc88b | notionChordPageId=9cb3dac6-12b9-4772-b093-19f8d1c9ee51 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/569dac523c7e45f5b957fbc45b8bc88b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Бог с нами в долине удачи'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=12%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Боже, Ты мой Бог', 'Молодёжный сборник', NULL, 'Куплет 1:
Боже, Ты мой Бог!
Тебя от ранней зари ищу я.
Тебя жаждет душа моя.
Аллилуйя!
Куплет 2:
Я вспоминаю о Тебе.
Размышляю ночью о Тебе.
Ты помощь моя.
Аллилуйя!
Куплет 3:
Милость Твоя лучше чем жизнь.
Благословлю Тебя в жизни моей.
Уста мои восхваляют Тебя.
Аллилуйя!
Куплет 4:
Боже, Ты мой Бог!
Тебя от ранней зари ищу я.
Тебя жаждет душа моя.
Аллилуйя!', 'Куплет 1:
Em C Am Hm
Em C Am D7
G7 C7 Am H7
Em Hm Em
Куплет 2:
Em C Am Hm
Em C Am D7
G7 C7 Am H7
Em Hm Em
Куплет 3:
Em C Am Hm
Em C Am D7
G7 C7 Am H7
Em Hm Em
Куплет 4:
Em C Am Hm
Em C Am D7
G7 C7 Am H7
Em Hm Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=13 | photo=notion-youth-songbook | notionPageId=baff265b-85b9-425e-bf2e-d3db75cbd481 | notionChordPageId=71772f51-511b-4035-b4e5-3bcf3dd2dd09 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/baff265b85b9425ebf2ed3db75cbd481', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Боже, Ты мой Бог'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=13%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Божья любовь', 'Молодёжный сборник', NULL, 'Куплет 1:
Скажи, ну что тебя сюда ведет?
Ответь, ну что тебя сюда влечет?
И от чего твои глаза горят,
Такой счастливый и открытый взгляд.
Припев:
Это любовь, Божья любовь,
Она зальет все, заполнит все,
Только любовь, Божья любовь,
Все в мире пройдет, кроме нее.
Куплет 2:
Я возвожу к Иисусу сердцем взгляд,
И знаю: мой Господь мне очень рад.
В ответ с престола льется на меня,
Вода живая, свет Его огня.
Куплет 3:
Скажи, откуда этот блеск в глазах?
Ответь, ну что даёт нам Бог в сердца?
Он помогает в этом мире жить,
Он дает силы верить и любить.', 'Куплет 1:
Dm Gm
C F
A# Gm
A7
Припев:
Dm Gm
C F
A# Gm
A7 Dm
Куплет 2:
Dm Gm
C F
A# Gm
A7
Куплет 3:
Dm Gm
C F
A# Gm
A7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=14 | photo=notion-youth-songbook | notionPageId=d4d96011-4899-45a0-be4c-55ebf6bb14d9 | notionChordPageId=75d65a49-0948-4675-95e8-a786bcc4937f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d4d96011489945a0be4c55ebf6bb14d9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Божья любовь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=14%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Буду Бога хвалить', 'Молодёжный сборник', NULL, 'Куплет 1:
Буду Бога хвалить доколе жив,
Буду Господу петь доколе есть.
Божьей милости я не заслужил,
А в ответ на любовь из сердца песнь.
На людей не надейся никогда
В самых сильных из них, спасенья нет.
Если есть у тебя сейчас нужда,
Прямо к Богу иди, он даст ответ.
Припев:
Как блажен, тот, кому помощник Бог
У кого вся надежда на Него
Кто создать небеса и землю смог
Не оставит своих ни одного!
Куплет 2:
Справедливый и милосердный Царь
Будет царствовать вечно в род и род
Аллилуйя душа моя восклицай
Славь Царя своего, его народ.
Буду Бога хвалить доколе жив,
Буду Господу петь доколе есть.
Божьей милости я не заслужил,
А в ответ на любовь из сердца песнь.', 'Куплет 1:
A
C#m
Hm
E
A
C#m
Hm
E
Припев:
F#m Hm
E A
F# Hm
E A
Куплет 2:
A
C#m
Hm
E
A
C#m
Hm
E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=15 | photo=notion-youth-songbook | notionPageId=42266a6a-3f58-46b3-a978-38f5d1e4f8be | notionChordPageId=f47930e4-c4af-4e12-900f-b9549c46048b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/42266a6a3f5846b3a97838f5d1e4f8be', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Буду Бога хвалить'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=15%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Будь благословен', 'Молодёжный сборник', NULL, 'Куплет 1:
Будь благословен на земле изобилия,
Где течёт молоко и мёд, будь благословен.
Будь благословен на земле иссохшей и пустой,
Когда мне тяжело в пути, будь благословен.
Припев:
За Твои благословенья
Воздам хвалу,
Если тьма меня стесняет,
Всё равно скажу:
Будь благословен, мой Господь,
Будь благословен!
Будь благословен, мой Господь,
Будь благословен великий Бог!
Куплет 2:
Будь благословен, когда всё хорошо вокруг,
Когда рядом есть близкий друг, будь благословен.
Будь благословен на пути, где страдания,
Когда боль и испытания, будь благословен.
Мост:
Лишь Ты имеешь власть
Всё дать и всё отнять.
Я выберу за всё
Тебя благословлять!', 'Куплет 1:
A E F#m D
A E D
A E F#m D
A E D
Припев:
A E
F#m D
A E
F#m D
A E
F#m D
A E
F#m E D
Куплет 2:
A E F#m D
A E D
A E F#m D
A E D
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=16 | photo=notion-youth-songbook | notionPageId=c3e51ec0-6ec5-4e0b-bca2-d6073cefb8b4 | notionChordPageId=3f183d9c-b131-47d1-ad9d-8037658a4390 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c3e51ec06ec54e0bbca2d6073cefb8b4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Будь благословен'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=16%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Будь храброй, душа', 'Молодёжный сборник', NULL, 'Куплет 1:
Спокойно стой, прими покой:
Совершит все Господь.
Все мысли Его выше наших путей,
Путь Его так велик!
Припев:
Будь храброй, душа, и стой до конца,
Господь ‒ Он рядом, Господь ‒ Он рядом.
И надеждой крепись, до победы держись –
Не подведет Он, не подведет Он!
Куплет 2:
Душа моя, славь Господа!
Силу в Нем ты найдешь.
Не забывай верности Его,
Он проложит Свой путь!
Мост:
Все звезды держишь Ты,
В Твоих руках весь мир,
Исполнишь все, что Ты обещал.
В победе я вновь поднимусь!', 'Куплет 1:
G D
Em C
G D
Em C
Припев:
Em D
G
Em D
C D
Куплет 2:
G D
Em C
G D
Em C
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=17 | photo=notion-youth-songbook | notionPageId=7fe4ca5e-360b-4bd6-a14a-f3bb688882f7 | notionChordPageId=efb3acd5-4c31-4184-8ae8-1c0b4a04beb2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7fe4ca5e360b4bd6a14af3bb688882f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Будь храброй, душа'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=17%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В городе тихая осень', 'Молодёжный сборник', NULL, 'Куплет 1:
В городе тихая осень, первые дни октября.
Клён как-то листья сбросил, и стала другой земля.
Оделась она царицей всего на несколько дней,
Но как просветлели лица у проходящих людей.
Припев:
Осень, красивую осень Бог подарил земле.
Осень, красивую осень я попросил себе.
Осень, красивую осень Бог подарил земле.
Осень, красивую осень я попросил себе.
Мост:
Бог так одевает лилию, цветущую несколько дней,
Что Соломон великий меркнет при славе своей,
Но верных одел Бог лучше в праведной жизни своей,
Чтоб просветлели души рядом идущих людей.', 'Куплет 1:
F#m D E F#m
F#m D E F#m
F#m D E F#m
F#m D E F#m
Припев:
D E F#m A
D E F#m
D E A E F#m
Hm C#m F#m
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=18 | photo=notion-youth-songbook | notionPageId=0dad6474-e94f-4fc2-ac5a-7f7769693401 | notionChordPageId=8a79ea7d-ec3c-45a1-b779-6ebe46af68b3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0dad6474e94f4fc2ac5a7f7769693401', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В городе тихая осень'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=18%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В жизни земной', 'Молодёжный сборник', NULL, 'Куплет 1:
В жизни земной всё приходит к концу,
И для всего назначено время.
Осенью ветер срывает листву,
И устилает озябшую землю.
Только однажды даётся нам жизнь,
Ну, а затем начинается вечность.
Хочешь ли в вечности с Господом быть,
Ныне оставь роковую беспечность.
Куплет 2:
Время летит, не прощая утрат,
Время диктует нам жёсткие сроки.
Выбери ныне блаженство иль ад,
Жизнь со Христом или гибель в пороках.
Может тебе одиноко сейчас,
Пусто в душе, не уютно и душно,
Слышал ты призыв Христа и ни раз,
Но покаянье считаешь ненужным.
Куплет 3:
Вот и теперь сам Спаситель зовёт,
Хочет вернуть Он заблудшего сына.
Ты изнемог и устал, Он поймёт,
Ласково, нежно с любовью обнимет.
Миром покроет любовью своей,
Душу больную твою Он наполнит,
Только не медли, покайся скорей,
Жизнь повторять не придётся запомни.
Мост:
Только однажды даётся нам жизнь,
Ну, а затем начинается вечность.
Хочешь ли в вечности с Господом быть,
Ныне оставь роковую беспечность.', 'Куплет 1:
Dm A# C Dm
Gm A Dm
A# C
Gm A Dm
Gm A Dm
A# C F
Gm A Dm
Gm A Dm
Куплет 2:
Dm A# C Dm
Gm A Dm
A# C
Gm A Dm
Gm A Dm
A# C F
Gm A Dm
Gm A Dm
Куплет 3:
Dm A# C Dm
Gm A Dm
A# C
Gm A Dm
Gm A Dm
A# C F
Gm A Dm
Gm A Dm
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=19 | photo=notion-youth-songbook | notionPageId=98bd3076-7070-4051-9253-1e2dd32426f1 | notionChordPageId=e723f2fd-e546-4df5-883a-ec6ff49347a0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/98bd30767070405192531e2dd32426f1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В жизни земной'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=19%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В мир греха', 'Молодёжный сборник', NULL, 'Куплет 1:
В мир греха, мерзости и зла
С неба к нам любовь шла.
Пыль дорог, боль усталых ног:
По земле идет Бог.
Припев:
Он пришёл для тебя,
Чтобы с Богом был ты и я.
Он нашёл и привел
Даже тех, кто в гибель шёл.
Он нам дал идеал
Той любви, что мир давно не знал.
Он прощал и желал,
Чтобы ты об этом узнал.
Куплет 2:
Жизнь людей, слёзы их детей.
Сколько горестей в ней…
“Только Бог нас избавить мог” –
Вырывался их вздох.
Куплет 3:
Яркий луч средь нависших туч,
Среди пенистых круч.
С нами рос Иисус Христос,
В мир спасение нёс.', 'Куплет 1:
Em Hm Em Hm
C D Em
Em Hm Em Hm
C D Em
Припев:
Am Em
C D Em
Am Em
C D Em
Am Em
C D Em
Am Em
C D Em
Куплет 2:
Em Hm Em Hm
C D Em
Em Hm Em Hm
C D Em
Куплет 3:
Em Hm Em Hm
C D Em
Em Hm Em Hm
C D Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=20 | photo=notion-youth-songbook | notionPageId=bcdfa534-ff65-429e-ba79-269919f4a603 | notionChordPageId=f3b64da8-fa68-4868-a30f-68e3adf88682 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bcdfa534ff65429eba79269919f4a603', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В мир греха'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=20%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В Палестине Царь родился в те далекие года', 'Молодёжный сборник', NULL, 'Куплет 1:
В Палестине Царь родился в те далекие года,
Бог на землю к нам явился и зажглась Его звезда,
Пастухов, стада пасущих, свет великий осиял,
И тогда, идя к пещере, каждый Бога прославлял.
Припев:
Гори звезда, всегда гори, И светом новым озари,
И светом новым озари,
Все, кто блуждает в темноте,
Пусть весть услышат о Христе.
Куплет 2:
Мудрецы, звезду увидев, в Вифлеемский стан пошли,
На колени пред Ним пали и подарки принесли,
И теперь она сияет, Вифлеемская звезда,
Скоро все о ней узнают и поверят во Христа.
Куплет 3:
Много звезд на небе светит, только светит всех сильней,
Та, что время возвестила Рождества Царя Царей,
И когда печаль на сердце, подними глаза туда,
Где сияет вечным светом Вифлеемская звезда', 'Куплет 1:
F Dm
A# Gm C
F Dm
A# Gm C
Припев:
F Dm
C F
F A Dm
Gm C F
Куплет 2:
F Dm
A# Gm C
F Dm
A# Gm C
Куплет 3:
F Dm
A# Gm C
F Dm
A# Gm C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=21 | photo=notion-youth-songbook | notionPageId=27a9f73a-2e3a-448a-acda-8f5b7da5c5ee | notionChordPageId=8597f944-d10c-4992-928f-23dc0246a8ea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/27a9f73a2e3a448aacda8f5b7da5c5ee', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В Палестине Царь родился в те далекие года'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=21%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В Христе одном', 'Молодёжный сборник', NULL, 'Куплет 1:
В Христе одном надежда есть,
Вся моя жизнь и сила в Нём.
Он - Камень мой, скала и песнь,
Надёжный спутник в страшный шторм.
Как высока любовь Его,
Как мир глубок, как с Ним легко.
Мой Утешитель – Всё во всём,
Моя опора только в Нём.
Куплет 2:
В Христе одном, принявшем плоть,
Открылся Всемогущий Бог.
Но дар любви, что дал Господь,
Отверг народ, избрав порок.
Он на кресте Себя отдал,
В смиреньи гнев Отца принял.
Мой грех на плечи возложил,
Чтобы Его я смертью жил.
Куплет 3:
В земле, как все, Он мёртвым был,
Объят был тьмою свет небес.
Но в третий день Он победил,
Из гроба мрачного воскрес!
Он Бог и победитель всех,
Уже не правит больше грех.
Навеки Он хозяин мой,
Я куплен кровию святой.
Куплет 4:
Нет страха смерти, нет вины,
Всё только силою Христа.
От первых дней, до седины,
До смерти в Нём моя судьба.
||: Нет никого и ничего,
Что вырвет из руки Его.
Он приведёт меня в Свой дом,
Моя опора только в Нём. :||', 'Куплет 1:
G D G A
D G A D
G D G A
D G A D
G D A
D G D A
G D G A
D G A D
Куплет 2:
G D G A
D G A D
G D G A
D G A D
G D A
D G D A
G D G A
D G A D
Куплет 3:
G D G A
D G A D
G D G A
D G A D
G D A
D G D A
G D G A
D G A D
Куплет 4:
G D G A
D G A D
G D G A
D G A D
G D A
D G D A
G D G A
D G A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=22 | photo=notion-youth-songbook | notionPageId=5e3a733d-3c37-4297-888a-dbbbb4e61262 | notionChordPageId=8c753842-be45-4628-a9ec-3161c94f3eca | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5e3a733d3c374297888adbbbb4e61262', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В Христе одном'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=22%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'В часы тревог, унынья и сомненья', 'Молодёжный сборник', NULL, 'Куплет 1:
В часы тревог, унынья и сомненья,
Не видя света, света пред собой,
Душа болит, терзается в волненьи,
Спешу, Господь, прийти к Тебе с мольбой!
Припев:
Как счастлив я, что я Христа имею!
Как счастлив я, что Он всегда со мной!
Живу я Им, об этом не жалею,
Как счастлив я, что Он со мной, Друг мой!
Куплет 2:
О образ дивный, кроткий и смиренный,
Христос Господь, живи во мне всегда,
Чтоб в сердце был моем запечатленный,
Не дал упасть под тяжестью креста.
Куплет 3:
К кому пойду я в горести сердечной,
С участьем кто протянет руку мне?
Лишь Ты один с любовью бесконечной
Меня простил, меня привлек к Себе.
Куплет 4:
Но мне порой так тяжело бывает,
И кажется, оставил Бог меня.
Но вновь душа словам Твоим внимает:
“Я не оставлю, Я люблю тебя”.', 'Куплет 1:
Gm D7 Gm
F A# D7
Gm Cm
Gm D7 Gm
Припев:
Cm D7 Gm
Cm F A# D7
Gm Cm
Gm D7 Gm
Куплет 2:
Gm D7 Gm
F A# D7
Gm Cm
Gm D7 Gm
Куплет 3:
Gm D7 Gm
F A# D7
Gm Cm
Gm D7 Gm
Куплет 4:
Gm D7 Gm
F A# D7
Gm Cm
Gm D7 Gm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=23 | photo=notion-youth-songbook | notionPageId=9679d4e0-6d39-4931-a4b2-83ebd31669f7 | notionChordPageId=9699cc71-2d60-4427-b73e-1f75244dd9d3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9679d4e06d394931a4b283ebd31669f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'В часы тревог, унынья и сомненья'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=23%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Велики и чудны', 'Молодёжный сборник', NULL, 'Куплет 1:
Велики и чудны дела Твои,
Господи Боже Вседержитель.
Праведны и истинны пути Твои
Царь Святый.
Припев:
Кто не убоится не прославит Тебя,
Ибо Ты един свят.
Все народы поклонятся
Пред Тобой, ибо Ты един свят.
Свят, свят, Ты един свят.
Свят, свят, Ты един свят.
Куплет 2:
Благости и милости твои на всех,
Господи Боже Вседержитель.
Сила и величие Твоё во всём,
Царь Святый.
Куплет 3:
Честь Тебе, хвала каждый миг, Ииисус,
Господи Боже Вседержитель.
Аллилуйя и осанна лишь Тебе,
Царь Святый.', 'Куплет 1:
Em Am D Em
C D G H
Em Am D Em
C D Em
Припев:
Am H7 Em C
Am D G
Am H7 Em C Am
Hm Em
G D Am Em C D G
G D Am Em C D Em
Куплет 2:
Em Am D Em
C D G H
Em Am D Em
C D Em
Куплет 3:
Em Am D Em
C D G H
Em Am D Em
C D Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=24 | photo=notion-youth-songbook | notionPageId=03e7b7e1-9b25-415f-8096-8a24b71729f4 | notionChordPageId=83fda083-a002-4dcd-af25-341796f18a56 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/03e7b7e19b25415f80968a24b71729f4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Велики и чудны'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=24%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Величит душа моя Бога', 'Молодёжный сборник', NULL, 'Куплет 1:
Величит душа моя Бога,
Он – Царь и Владыка миров,
Когда на душе тревога,
Спешу под Его покров.
Припев:
Он правдой меня осеняет,
Дает мне под крыльями тень,
От коварных путей охраняет,
И душу мою сберегает
По милости каждый день.
Куплет 2:
Ему аллилуйя, осанна,
Он полон небесных щедрот,
Я в Нем нахожу непрестанно
Отраду в минуты невзгод.
Куплет 3:
И я каждый день направляю
Молитвы в небесную синь,
И громко Его прославляю
Сердечной хвалою. Аминь.', 'Куплет 1:
G
Em
Am D
C D
Припев:
G Em
C D
G Em
C G
C D G
Куплет 2:
G
Em
Am D
C D
Куплет 3:
G
Em
Am D
C D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=25 | photo=notion-youth-songbook | notionPageId=5d8e0053-b0cd-41e0-9d85-e38d00a0ad5c | notionChordPageId=24b8d158-9139-4216-9303-c36ce1b4ca3b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5d8e0053b0cd41e09d85e38d00a0ad5c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Величит душа моя Бога'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=25%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Верим мы', 'Молодёжный сборник', NULL, 'Куплет 1:
В час когда вокруг сомненье,
Страх вокруг во тьме земля
Есть Единственное Спасение
Верю я! Верю я!
Припев:
Верим мы, что Бог - Отец наш, верим в Господа Христа
Верим мы в Святого Духа, нам жизнь вечная дана
Верим мы - Христа распяли, верим мы что Он воскрес
Верим мы настанет время, Наш Господь придет с небес, верим мы!
Куплет 2:
В этом сломленном поколении,
Свет приносишь только Ты
Есть Надежда на спасенье
Верим мы! Верим мы!
Куплет 3:
Пусть, будет больше наша вера
В час сомнений и тревог
Ты несешь надежду с неба
Верим мы! Верим мы!
Мост:
Кто потерян был выход найдёт пусть в сердца людей ворвется любовь
Церковь громко скажет чтоб слышал Ты, верим мы! Верим мы!
Нас не одолеют ада врата сила Божья завесу разорвала
Не пройдет Его любовь никогда верим мы! Верим мы!', 'Куплет 1:
C Csus
C Csus
Am F
C F
Припев:
C G
Am F
C G
Am F
Куплет 2:
C Csus
C Csus
Am F
C F
Куплет 3:
C Csus
C Csus
Am F
C F
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=26 | photo=notion-youth-songbook | notionPageId=4ebcd920-7b2d-4c4f-b6eb-027a123e92de | notionChordPageId=b2f0e304-20bc-4522-99d0-bc7cc073a44d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4ebcd9207b2d4c4fb6eb027a123e92de', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Верим мы'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=26%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Верую, Господи', 'Молодёжный сборник', NULL, 'Куплет 1:
Верую, Господи, истинно верую в Слово святое Твое.
Время отмерено каждому верному определенье свое.
Все, что назначено, будет исполнено сильной рукою Твоей
Божье провиденье не омрачайте, не убегайте скорбей.
Припев:
Небо, небо правду знает, небо верных принимает:
Стефан, Павел, Магдалина, Иоанн, Филипп, Мария,
Тит, Лука, Андрей, Варнава - Имена, и с ними слава.
О, дай Бог свое услышать имя.
Куплет 2:
Все, что построили, будет проверено посланным с неба огнем.
Бог так устроил все, будьте уверены, может быть, после поймем,
Где было золото, сено и дерево, чистое серебро.
Каждый увидит, насколько он верен был в том, что от Неба дано.
Куплет 3:
Боже, помилуй нас, из рук не выпусти и для Себя сохрани.
Где бы не были мы, ехали, плыли бы, милости не отними.
Перед Тобою никто не осмелится чтобы неправду сказать.
Чистое небо святыми заселится, грешникам там не бывать.', 'Куплет 1:
Dm Gm A A7
Dm Gm C C7
F D D7
Gm A A7
Припев:
Dm Gm C F
Dm Gm A
Dm Gm C F
Dm Gm A
Куплет 2:
Dm Gm A A7
Dm Gm C C7
F D D7
Gm A A7
Припев:
Dm Gm C F
Dm Gm A
Dm Gm C F
Dm Gm A
Куплет 3:
Dm Gm A A7
Dm Gm C C7
F D D7
Gm A A7
Припев:
Dm Gm C F
Dm Gm A
Dm Gm C F
Dm Gm A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=27 | photo=notion-youth-songbook | notionPageId=3c7a9694-04dc-4538-a11a-5eeeb7b573f4 | notionChordPageId=9e3d2855-c14e-43bc-89fb-e8a081d52c2d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3c7a969404dc4538a11a5eeeb7b573f4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Верую, Господи'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=27%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ветры холодные', 'Молодёжный сборник', NULL, 'Куплет 1:
Ещё будет зима, ещё ветры подуют холодные,
Ещё голосом вьюг разразится метель и пурга.
Чтобы нас испытать, будем ли для спасенья пригодные
Или силы не станет когда нас облягут снега.
А к концу всё подходит и время настало последнее
Как нам нужно друзья дорожить им пока ещё день,
Запасаться елеем, чтобы жизнью нам жить здесь победною
Пока ночью ещё не накрыла нас мрачная тень.
Куплет 2:
Очень скоро и лето закончится благоприятное
Когда Бог свои милости щедрым дождём проливал.
Когда были мы Им, по отцовски любовью обласканы
И так много Он нас, как детей своих благословлял.
Но к концу всё подходит, и время настало последнее
Как нам нужно друзья дорожить им пока ещё день,
Запасаться елеем, чтобы жизнью нам жить здесь победною
Пока ночью ещё не накрыла нас мрачная тень.
Куплет 3:
Будет трудно потом, если мы без запаса останемся
А пройти надо нам через всё и в борьбе устоять.
Где мы силы возьмём, коль сегодня мы не постараемся
Чтоб её в тесном с Богом общении приобретать.
Может надо нам будет оставить всё нами нажитое
И пойти к Иисусу за стан, поруганье неся,
Но не будем мы Богом оставлены или забытые
Любит Он как отец, Сына в жертву за нас принеся.
Куплет 4:
Будем твёрдо держаться Господнего обетования.
Будем верны Ему, чего б нам не стоило то.
Не оставим, друзья, никогда своего упования,
Ведь от Божьей любви отлучить нас не сможет ни что.
Ни метели, ни вьюги, ни ветры с пургою холодною,
Бог Своею любовью всегда будет нас согревать,
А пока время есть благодатного лета Господнего
О котором когда-то потом будем лишь вспоминать.', 'Куплет 1:
Am E
Dm E Am
A7 Dm
Am E Am
A7 Dm
F E
Am Dm
Am E Am
Куплет 2:
Am E
Dm E Am
A7 Dm
Am E Am
A7 Dm
F E
Am Dm
Am E Am
Куплет 3:
Am E
Dm E Am
A7 Dm
Am E Am
A7 Dm
F E
Am Dm
Am E Am
Куплет 4:
Am E
Dm E Am
A7 Dm
Am E Am
A7 Dm
F E
Am Dm
Am E Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=28 | photo=notion-youth-songbook | notionPageId=08a5f372-3fcb-472f-978b-5f7b37b1ea88 | notionChordPageId=b5cd00a6-a782-4d6a-a293-c9b0339fdc3e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/08a5f3723fcb472f978b5f7b37b1ea88', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ветры холодные'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=28%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Взор поднимаю к лазурному небу', 'Молодёжный сборник', NULL, 'Куплет 1:
Взор поднимаю к лазурному небу
Светлой надеждой сердце горит
В жизни земной этой где бы я ни был
Нежно со мною Иисус говорит.
Припев:
Сердцем с Тобою ,Ты вечный и лучший
Мне улететь бы в бескрайнюю даль
Ты самый верный, Мой Друг неразлучный
Радость несу я Тебе и печаль
Радость несу я Тебе и печаль
Куплет 2:
Ввысь устремляться умею душою
Дивная радость, на небе покой
Мой Искупитель, Ты всюду со мною
Славный и мудрый Иисус дорогой
Куплет 3:
А надо мною лазурное небо
Синим простором все в вечность зовёт
Ты неизменный о слава за это!
Пусть в моем сердце надежда живёт.', 'Куплет 1:
Em C
Am H7
Em C
Am H7 Em
Припев:
Em Am H7 Em
C D G
Dm E7 Am
H7 Em
Am H7 Em
Куплет 2:
Em C
Am H7
Em C
Am H7 Em
Куплет 3:
Em C
Am H7
Em C
Am H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=29 | photo=notion-youth-songbook | notionPageId=14be1917-0dc6-42c8-86f4-d39cf573f73d | notionChordPageId=67402743-2ca0-4960-a85b-cb65d71241a6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/14be19170dc642c886f4d39cf573f73d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Взор поднимаю к лазурному небу'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=29%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вот наш Бог', 'Молодёжный сборник', NULL, 'Куплет 1:
Кто моря все горстью исчерпал?
Кто песок земли пересчитал?
Кто Один над всем имеет власть?
Кто творенью радость может дать?
Припев:
Вот наш Бог, Трон Его высок,
Будем поклоняться!
Вот наш Царь, несравним ни с чем,
Будем поклоняться!
Куплет 2:
Кто дает народам Свой устав?
Кто Единый прав во всех делах?
Кто решает что произойдет?
Кто Один все знает наперед?
Куплет 3:
Кто был свят, но взял вину людей?
Кто подставил руки для гвоздей?
Кто в смиреньи умер на кресте?
Кто воскрес, чтоб грешников спасти?', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=30 | photo=notion-youth-songbook | notionPageId=e4c919de-4ab6-496d-8f82-42548f63e1dd | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/e4c919de4ab6496d8f8242548f63e1dd | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вот наш Бог'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=30%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вот он я', 'Молодёжный сборник', NULL, 'Куплет 1:
Вот он я. Твоим величием смирён,
Благодатью освобождён.
Вот он я. Нечистый, грешный человек.
Омытый жертвою за грех.
Припев:
На кресте распятый Божий Сын страдал,
За грех мой умирал,чтоб я свободным стал.
Ты велик, Ты велик.
Меня покрыла милость Твоя,
К новой жизни воскресила она.
Куплет 2:
Вот он я. Твоей любовью, так восхищён.
Прощаю, потому что прощён.
Вот он я. Знаю, что я нужен Тебе.
Освящён, очищен, в огне.', 'Куплет 1:
Am G F C F
C G
Am G F C F
C G
Припев:
Am G C Am G C
D F
C G Am F
C G
Am F
Куплет 2:
Am G F C F
C G
Am G F C F
C G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=31 | photo=notion-youth-songbook | notionPageId=fc08ad30-2c85-4dab-9175-985f389071f0 | notionChordPageId=06494446-b0dd-429f-8167-d093294bbfae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fc08ad302c854dab9175985f389071f0', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вот он я'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=31%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вот прошли тысячелетья...', 'Молодёжный сборник', NULL, 'Куплет 1:
Вот прошли тысячелетья…
Над землей, над миром этим
Все по-прежнему нам светит солнца свет.
Но настанет это время:
День суда и воскресенья,
Чтоб открыто нам пред Богом дать ответ.
Припев:
О, день суда! За все года,
Дашь тогда за жизнь прожитую отчёт.
О человек, твой краток век,
Торопись сейчас спастись!
Куплет 2:
Образ смертного приемля,
Божий Сын пришел на землю,
Чтобы грешных всех от гибели спасти.
От греха и преступленья
Совершил Он искупленье,
Всякий может в Нем спасенье обрести.
Куплет 3:
Бог зовет, и неизвестно,
Сколь продлится зов небесный
Над землёй, над миром грешным, друг, спеши!
Жизни вечный дар вещая,
Бог не завтра обещает,
Но сегодня предлагает для души.', 'Куплет 1:
C
Am
Dm G C
C
Am
Dm G C
Припев:
C F G C
Am Dm G C
C F G C
Am Dm G C
Куплет 2:
C
Am
Dm G C
C
Am
Dm G C
Куплет 3:
C
Am
Dm G C
C
Am
Dm G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=32 | photo=notion-youth-songbook | notionPageId=a21255a5-82ca-4a2c-b393-ac7dd3837ddd | notionChordPageId=cf02ed42-7772-4933-a227-de2e8defa95c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a21255a582ca4a2cb393ac7dd3837ddd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вот прошли тысячелетья...'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=32%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Все небеса да хвалят Воскресшего', 'Молодёжный сборник', NULL, 'Куплет 1:
Все небеса да хвалят Воскресшего
Сравнится ль кто с сияньем красоты Его?
Ведь Агнец, Божий Сын - Небесный занял трон,
Поклонимся пред Ним, Достоин славы Он!
Куплет 2:
Превозношу, несу хвалу Воскресшему,
Кто был распят, Святому и Предвечному.
Отец всё дал Ему, а мы чем воздадим?
Колени преклоню я только перед Ним.', 'Куплет 1:
G C D G
G C D G
G C G Em
C D G
Куплет 2:
G C D G
G C D G
G C G Em
C D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=33 | photo=notion-youth-songbook | notionPageId=19bf4e19-c6d7-41bd-a001-35e1c0dfca8a | notionChordPageId=155ab88a-5ec0-41dc-9300-1e769bc80efe | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/19bf4e19c6d741bda00135e1c0dfca8a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Все небеса да хвалят Воскресшего'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=33%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Встает заря', 'Молодёжный сборник', NULL, 'Куплет 1:
Встает заря, и солнца луч на небо всходит,
Засияв в бескрайней синеве.
За новый день хвалу Творцу поет природа,
Мы воспрянем в радостной хвале!
Припев:
Слава Богу! Слава Богу!
За милость, за прощение грехов!
Слава Богу! Слава Богу
За дивную Его любовь!
Куплет 2:
Как дивно все, что сотворил наш Бог великий,
Да звучит и слава, и хвала!
Прекрасно все, что создано Творцом Владыкой,
Славим Бога за дивные дела!
Куплет 3:
Великий Бог в любви Своей к нам, людям грешным,
Отдал в жертву Сына Своего,
И нас омыл Он Кровию Своей Пречистой,
Будем вечно славить мы Его.', 'Куплет 1:
Em D
Am H7 Em
Em D
Am H7 Em
Припев:
Em G
Am D G H7
Em G
Am H7 Em
Куплет 2:
Em D
Am H7 Em
Em D
Am H7 Em
Куплет 3:
Em D
Am H7 Em
Em D
Am H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=34 | photo=notion-youth-songbook | notionPageId=bdd0ce16-c2ed-42db-9412-57022a5604f7 | notionChordPageId=024e644e-0d6b-4ba1-ab76-5c83e6d025c6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bdd0ce16c2ed42db941257022a5604f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Встает заря'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=34%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вся земля полна славы', 'Молодёжный сборник', NULL, 'Куплет 1:
Вся земля полна славы и хвалы
Любовь Отца нам явилась в Сыне
И зажглась в небе яркая звезда
Она, мой друг, светит ярко и доныне
Припев:
Иисус! Иисус!
Ты родился в этот мир
Чтобы жизнь мне дать
Чтоб всегда со мною быть
Спасителем мне стать
Ты любовию Своей
Изменил меня, изменил весь этот мир
Иисус! Мой Иисус!
Куплет 2:
Подними к небу руки и тогда,
Льется пусть слава и хвала Иисусу,
Ликуй Земля, ведь открыты Небеса,
Родился Царь и грех мира разрушен', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=35 | photo=notion-youth-songbook | notionPageId=50dfd8c1-a23f-4321-9906-b39cc217a6b2 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/50dfd8c1a23f43219906b39cc217a6b2 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вся земля полна славы'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=35%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Вся земля хвалу поет', 'Молодёжный сборник', NULL, 'Куплет 1:
Вся земля хвалу поет лишь Тебе, наш чудный Бог.
И во всей вселенной нет
Кто б с Тобой сравниться смог.
Ты превосходнее всего на свете,
И нет подобного Тебе!
Ты наш Господь, Ты царствуешь вовеки,
Превознесем Тебя в хвале!
Припев:
Небеса Тебе поют: «Святый! Святый!»
Вся земля Тебе поет: «Достоин Ты!»
Всё творенье воздает Тебе хвалу, Господь:
«Благословен наш Бог, Творец всего!»
Куплет 2:
От престола Твоего течёт поток живой воды.
Для народа всей земли
Сияет свет Твоей любви.
Своим присутствием покрой всю землю,
Пусть свет прольется в жизнь людей,
И все народы преклонят колени,
И воспоют хвалу Тебе!', 'Куплет 1:
D A Hm G
D A
Hm G
Em D
G A
Em D
G A
Припев:
Hm G D
Hm G D
Hm G D
Em A
Куплет 2:
D A Hm G
D A
Hm G
Em D
G A
Em D
G A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=36 | photo=notion-youth-songbook | notionPageId=13b70973-e9ba-4e1d-bfaa-f10aaf895bfe | notionChordPageId=022bac89-cb62-49a1-a83f-b96d429f6f8a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/13b70973e9ba4e1dbfaaf10aaf895bfe', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Вся земля хвалу поет'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=36%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Выбрали мы узкую дорогу', 'Молодёжный сборник', NULL, 'Куплет 1:
Выбрали мы узкую дорогу
Нам не жалко юные года;
Ведь с каждым днём мы становимся ближе к Богу
И эта радость у нас в сердцах.
Припев:
Нам так хочется с Иисусом быть там, на небесах,
Ведь не даром пролилась святая кровь;
Где не будут слёзы на глазах,
Только песнь хваленья на устах,
Ведь там вечно царит любовь.
Куплет 2:
На земле дух не найдёт причала,
Только ты не унывай;
Жизнь даёт короткое начало,
А конец - небесный край.
Куплет 3:
А пока, с надеждою живою
Будем мы здесь проходить свой путь;
День придёт, расстанемся с землёю,
Чтобы нам там в небе отдохнуть.', 'Куплет 1:
Em C D G
C Am H
Em C D G
C Am H7
Припев:
Am D H7 Em
C D G E
C D
H7 Em
C H7 Em
Куплет 2:
Em C D G
C Am H
Em C D G
C Am H7
Куплет 3:
Em C D G
C Am H
Em C D G
C Am H7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=37 | photo=notion-youth-songbook | notionPageId=47d1d217-afd3-48f8-b014-f4c7e0b80172 | notionChordPageId=bc5f9fed-e4e0-4a8c-aaeb-46e71dc39feb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/47d1d217afd348f8b014f4c7e0b80172', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Выбрали мы узкую дорогу'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=37%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Где вы, друзья мои', 'Молодёжный сборник', NULL, 'Куплет 1:
Где вы, друзья мои? Я вас люблю.
Бог приготовил дорогу мне мою,
Но память приносит вас, и сквозь года
Я обнимаю вас, а в душе звучат слова:
Припев:
Милые мои, вы Богом данные
Разошлись пути, но в небо званны мы.
Если суждено уже не встретиться нам,
Я в небе расцелую всех вас.
Куплет 2:
Я не заплачу, тихо скажу:
«Господи Боже, об одном Тебя прошу:
Пусть Твои Ангелы друзей моих хранят,
Да не преткнутся, не дай им обернуться назад»', 'Куплет 1:
Em Am H
Am D Am H
Em Am H
Am D Am H
Припев:
Am H Em
Am H Em E
Am D G C
Am H Em
Куплет 2:
Em Am H
Am D Am H
Em Am H
Am D Am H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=38 | photo=notion-youth-songbook | notionPageId=2e598b1d-3f98-4122-af63-9aa553cfaefd | notionChordPageId=dc7f8357-5762-47a8-bb9c-02d84129c1e8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2e598b1d3f984122af639aa553cfaefd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Где вы, друзья мои'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=38%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Где ты прекрасная', 'Молодёжный сборник', NULL, 'Куплет 1:
Где ты прекрасная, светлая, ясная,
Родина вечная — Отчизна моя.
Мысли к тебе летят, в высь устремляются,
В синее небо направляю свой взор.
Припев:
А надо мною синее небо,
Стайкою тёмной летят журавли.
В крике их птичьем радости много,
К родине вечной возвратились они.
Куплет 2:
Там в вышине небес, в краю безоблачном,
Пастырь Иисус Христос ждёт уж меня.
Скоро достигну я той красоты небес,
И поднимаю снова к небу глаза.
Куплет 3:
Знаю, Спаситель мой, скоро придёт за мной,
И в белоснежную церковь возьмёт.
Только прошу Тебя, дай устоять в пути,
Чтобы без пятнышка в небо войти.
Куплет 4:
Родина вечная, чистое небо,
Край мой чудесный - Отчизна моя.
Прими моё сердце, цвет моей юности,
В руки Иисуса отдаюсь навсегда.', 'Куплет 1:
A Dm Gm
A Dm A
Dm Gm
A Dm
Припев:
Gm Dm
A Dm D7
Gm Dm
A Dm
Куплет 2:
A Dm Gm
A Dm A
Dm Gm
A Dm
Куплет 3:
A Dm Gm
A Dm A
Dm Gm
A Dm
Куплет 4:
A Dm Gm
A Dm A
Dm Gm
A Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=39 | photo=notion-youth-songbook | notionPageId=239c968f-827d-490e-857d-8b5dc5205d78 | notionChordPageId=1249248b-9315-41ac-8d2e-9a2ff5bd626d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/239c968f827d490e857d8b5dc5205d78', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Где ты прекрасная'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=39%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Гефсиманский сад', 'Молодёжный сборник', NULL, 'Куплет 1:
Гефсиманский сад, Гефсиманский сад…
Спят цветы в саду, и деревья спят…
||: Слышит сад слова и молитвы стон
Слышит он, слышит он. :||
Куплет 2:
Звёзды смотрят вниз, звёзды смотрят вниз,
Как Иисус Христос до земли поник.
||: Почему Он здесь? – звёзды не поймут,
Почему, почему? :||
Куплет 3:
В этот скорбный час, в этот скорбный час
Не делил никто со Христом печаль.
||: Чаша мук Его так была горька,
Нелегка, нелегка! :||
Куплет 4:
Тайну сад открыл, тайну сад открыл,
Для чего Иисус на коленях был.
||: Чтобы крестный путь до конца свершить,
Победить, победить!!! :||
Мост:
И в молитве я, и в молитве я
Говорю: Господь, научи меня
||: На коленях так, как Твой Сын, стоять,
Побеждать, побеждать!!! :||', 'Куплет 1:
Dm
Gm A
Gm C F A#
Gm A# A
Куплет 2:
Dm
Gm A
Gm C F A#
Gm A# A
Куплет 3:
Dm
Gm A
Gm C F A#
Gm A# A
Куплет 4:
Dm
Gm A
Gm C F A#
Gm A# A
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=40 | photo=notion-youth-songbook | notionPageId=b705466a-8e38-4cf9-9f56-6d51a42cb061 | notionChordPageId=406c0e71-5f5d-431c-abee-1a1ff19cd366 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b705466a8e384cf99f566d51a42cb061', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Гефсиманский сад'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=40%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Глубока, подобно морю', 'Молодёжный сборник', NULL, 'Куплет 1:
Глубока, подобно морю, совершенная Любовь
Как поток, поящий горы, жизнь даёт Христова Кровь.
Царь вселенной, Искупитель умирал за нас с тобой.
Там Его Любовь излита, где пролита Божья Кровь.
Куплет 2:
На горе Его распятья Бог Источник нам открыл.
Чтоб болезни и проклятья Он с детей Своих омыл.
Чрез Его любовь забудем навсегда про смерть и ад!
И в восторге вечно будем Милость Божью воспевать.
Куплет 3:
Благодать, Любовь и Милость - Божья мощная река.
Из Источника явилась на Голгофе у Креста.
Царь вселенной, Искупитель, умирал за нас с тобой.
Там была Любовь излита, где пролита Божья Кровь.', 'Куплет 1:
D G D A
D G D A D
D Em A D
Hm G D A D
Куплет 2:
D G D A
D G D A D
D Em A D
Hm G D A D
Куплет 3:
D G D A
D G D A D
D Em A D
Hm G D A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=41 | photo=notion-youth-songbook | notionPageId=262ed320-85b7-41da-9de6-8402c2e9f769 | notionChordPageId=0025d45d-d12d-4c58-b4c0-39e43104f4db | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/262ed32085b741da9de68402c2e9f769', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Глубока, подобно морю'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=41%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Говори ко мне', 'Молодёжный сборник', NULL, 'Куплет 1:
От гласа Твоего содрогаются горы
От гласа Твоего сотрясается земля
От гласа Твоего разверзается море
От гласа Твоего расступается тьма
Но ко мне Ты говоришь в тихом веянии ветра
Ты приходишь в жизнь мою, предваряя рассвет
Ты ко мне говоришь, когда я жду ответа.
И нежней, чем голос Твой в мире нет!
Припев:
О! Говори! Говори ко мне! Говори! Говори ко мне!
Говори! Говори ко мне, мой Господь!
О! Говори! Говори ко мне! Говори! Говори ко мне!
Говори! Говори ко мне, мой Господь!', 'Куплет 1:
C#m H
A G#m C#m
C#m H
A G#m C#m
C#m A H E
A F#m G#m C#m
C#m A H E
A G#m C#m
Припев:
C#m H
A G#
C#m H
A G#m C#m', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=42 | photo=notion-youth-songbook | notionPageId=229ce5db-c8bb-4814-b49b-b392f378c2e4 | notionChordPageId=4259388c-05cc-4fc3-ac3b-e236200e8cd3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/229ce5dbc8bb4814b49bb392f378c2e4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Говори ко мне'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=42%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Горы сдвинутся', 'Молодёжный сборник', NULL, 'Куплет 1:
Его мысли не наши мысли, и пути Его не наши пути.
Сам Господь их записал однажды, по которым нам должно пройти.
Но как небо выше земли, выше наших Боже мысли Твои.
Я склоняюсь у святых Твоих ног, ибо Ты есть неизменный Бог.
Припев:
Горы сдвинутся, холмы поколеблются,
А милость Твоя не отступит.
Твое Слово назад не возвращается,
Ты исполнишь, что обещал, я верю в Слово Твое.
Куплет 2:
Он дает утомленному силу, изнемогшему крепость дает.
Говорит всегда: «Я с тобою», и за руку тебя ведет.
А надеющиеся на Господа обновятся в силе всегда.
О, душа успокойся, рядом Бог, не бойся.', 'Куплет 1:
Dm Am
Gm A
Gm A Dm Gm A Dm
A#m Dm Gm A Dm A
Припев:
Dm Am
Gm A Dm Gm A
Dm Am
Gm A Dm
Куплет 2:
Dm Am
Gm A
Gm A Dm Gm A Dm
A#m Dm Gm A Dm A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=43 | photo=notion-youth-songbook | notionPageId=d40e4798-8cc4-47c6-9b45-b797ec40493d | notionChordPageId=97643278-8dca-4b0e-98fd-1cb92cdbee9c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d40e47988cc447c69b45b797ec40493d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Горы сдвинутся'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=43%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господи, как странно', 'Молодёжный сборник', NULL, 'Куплет 1:
Господи, как странно, что я жил Тебя не зная
Жил без благости Твоей Святой и без Твоей любви
Ныне я с Тобой, меня в семью Своих детей Ты принял
Я благодарю Тебя и прославлять Тебя хочу я.
Припев:
Славьте, славьте Бога, прославляйте Бога,
Прославляйте Бога всё больше день за днём.
Славьте, славьте Бога, прославляйте Бога,
Прославляйте Бога в сердце своём.
Куплет 2:
Господи, благодарю я за любовь Твою и милость,
И за слово, что в пути моем меня всегда хранит,
Господи, благодарю, что с братьями и сестрами хвалу
Тебе пою всегда и прославлять Тебя хочу.
Куплет 3:
Господи, как страшно было, когда жил совсем один я
В темноте, греховном мире, без любви к тебе.
Но Ты помог свет Твой увидеть, и в грехе мне не погибнуть
Слава вечная, хвала, и прославлять хочу Тебя я.
Куплет 4:
Я не знал, что есть такая жизнь и друзья такие.
За спасение моё Христа благодарю.
С Ним сумею сделать всё, снесу я трудности любые
Потому что славлюБога и Его люблю.', 'Куплет 1:
Em D
C D H7
Em D
C D H7
Припев:
Em C D G
C Am D H7
Em C D G
C Am H Em
Куплет 2:
Em D
C D H7
Em D
C D H7
Куплет 3:
Em D
C D H7
Em D
C D H7
Куплет 4:
Em D
C D H7
Em D
C D H7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=44 | photo=notion-youth-songbook | notionPageId=acdea7df-dc0a-47af-8985-fea2661be7f6 | notionChordPageId=4a659e20-7b01-4605-af41-a93f93962de3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/acdea7dfdc0a47af8985fea2661be7f6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господи, как странно'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=44%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господь - пастырь мой', 'Молодёжный сборник', NULL, 'Куплет 1:
На злачных пажитях меня покоит Он,
Водит к тихой воде наслаждаться.
Припев:
Господь - пастырь мой,
Я ни в чём не буду нуждаться:
Куплет 2:
Каждый день подкрепляте Он душу мою,
На путь правды меня направляет.
Куплет 3:
И долиною смертной пойду
Пред Тобой - я не буду бояться.
Куплет 4:
Умастил Ты елеем голову мою,
Преисполнена моя чаша.
Куплет 5:
Пребывать вечно буду я в доме Твоем,
В чудный образ Твой преображаться.', 'Куплет 1:
Em D G C
G D Em
Припев:
Em D G
C G D
Куплет 2:
Em D G C
G D Em
Куплет 3:
Em D G C
G D Em
Куплет 4:
Em D G C
G D Em
Куплет 5:
Em D G C
G D Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=45 | photo=notion-youth-songbook | notionPageId=843f43e7-9f21-40b6-a40b-d2ce1d54d550 | notionChordPageId=cec5a1fd-09b9-48f2-b55a-7624bbfab7a1 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/843f43e79f2140b6a40bd2ce1d54d550', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господь - пастырь мой'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=45%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господь есть мой Пастырь', 'Молодёжный сборник', NULL, 'Куплет 1:
Господь есть мой Пастырь, не буду тужить,
На пажитях злачных пасет.
Дает насыщенье моей Он душе
И водит к потокам вод.
Припев:
А в небе не будет слёз - там чарствует Христос,
Там Иисус сотрет слезу с очей.
Уж скоро окончим путь и сможем отдохнуть
В чудесных бесконечных небесах!
Куплет 2:
Долиной ли смерти придется идти,
Не буду нуждаться с Тобой.
Твой жезл и Твой посох отрада в пути,
Усталому сердцу покой.
Куплет 3:
Так благость и милость, мой Боже святой,
Идут со мной по всей земле.
Храни меня в мире могучей рукой
Пока не прибуду к Тебе.', 'Куплет 1:
G C
D G
G C
D G
Припев:
C D Hm Em C
D G
C D Hm Em C
D G
Куплет 2:
G C
D G
G C
D G
Куплет 3:
G C
D G
G C
D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=46 | photo=notion-youth-songbook | notionPageId=0f92c987-641d-493b-9b2c-2be4ddf1e083 | notionChordPageId=81dfa1fb-a39c-4fe3-93f4-72df8159ca78 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0f92c987641d493b9b2c2be4ddf1e083', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господь есть мой Пастырь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=46%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Господь моя сила', 'Молодёжный сборник', NULL, 'Куплет 1:
// Господь моя сила и щит. //
Господь упованье моё и помощь мне.
Припев:
И потому я ликую,
Сердце моё ликует
И песнь моя славит Господа.
Куплет 2:
// Господь моя радость и мир //
Господь утешенье мое и мой покой.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=47 | photo=notion-youth-songbook | notionPageId=5499f738-a54a-41ec-bfa5-1c1b5e5444fa | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/5499f738a54a41ecbfa51c1b5e5444fa | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Господь моя сила'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=47%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Давно погасли огни', 'Молодёжный сборник', NULL, 'Куплет 1:
Давно погасли огни туманных надежд
Давно затихли слова безумных невежд
И только мысли летят в полночную даль
Туда, где зреет рассвет, разгоняя печаль.
Ведь где-то есть она, другая страна
Там, где царит любовь, там, где всегда весна
Где звуки арф и труб, где ангелы поют
Где Богу и Христу хвалу все воздают.
Припев:
Он был, Он есть и снова грядет
Блажен, кто свят, кто верит и ждет.
Куплет 2:
А завтра снова в бой, снова туда
Куда ведет побед тернистая тропа
Туда, где горя нет, нет боли и слёз
Туда, где ждет своих Спаситель наш Христос.
О, как ты нам нужна, другая страна
Там, где царит любовь, там, где всегда весна
Где звуки арф и труб, где ангелы поют
Где Богу и Христу хвалу все воздают.', 'Куплет 1:
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Припев:
F C E Am
F C E Am
Куплет 2:
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am
Am F C E Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=48 | photo=notion-youth-songbook | notionPageId=4d1f7889-d830-4444-b112-3da7ba50f7ac | notionChordPageId=4d3c5c81-6216-4bca-910b-438fffada889 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4d1f7889d8304444b1123da7ba50f7ac', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Давно погасли огни'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=48%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Далеко, далеко', 'Молодёжный сборник', NULL, 'Куплет 1:
Далеко, далеко, далеко, далеко,
Там за гранью небес голубых.
Там так нежно, прекрасно, там так мило, легко,
Наслаждаться в общеньи святых.
Куплет 2:
Глубоко, глубоко, глубоко, глубоко,
Я мечтаю о Родине той,
Где нет слёз, нет тревог, там свободно, легко,
Где Отцовский мой дом дорогой.
Куплет 3:
Верю я, верю я, верю я, верю я,
Что Ты скоро, Спаситель, придёшь.
Лишь надежда одна утешает меня -
Что увижу я в небе Тебя!
Куплет 4:
О, Господь, о, Господь, о, Господь, о, Господь,
Дай мне силы идти за Тобой.
Побеждать этот мир лишь любовью Твоей,
Ожидая отрадных тех дней!', 'Куплет 1:
Cm G#
A# D#
Fm Cm
Fm G Cm
Куплет 2:
Cm G#
A# D#
Fm Cm
Fm G Cm
Куплет 3:
Cm G#
A# D#
Fm Cm
Fm G Cm
Куплет 4:
Cm G#
A# D#
Fm Cm
Fm G Cm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=49 | photo=notion-youth-songbook | notionPageId=e2c47307-d972-49d1-9de9-d830c376234d | notionChordPageId=73f55c34-d77a-4901-932d-e0b6c0c88869 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e2c47307d97249d19de9d830c376234d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Далеко, далеко'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=49%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Держит Он меня!', 'Молодёжный сборник', NULL, 'Куплет 1:
Если грех меня страшит, Держит Он меня!
Вера в Бога победит: Держит Он меня.
Чтобы мне не потерять Вечного огня,
Должен Он меня держать. Держит Он меня.
Припев:
Держит Он меня
Держит Он меня.
Охраняя и любя,
Держит Он меня.
Куплет 2:
В крепких, любящих руках Держит Он меня,
Дорог я в Его глазах: Держит Он меня.
Он не даст погибнуть мне, Сохранит вполне.
Обещания храня, Держит Он меня.
Куплет 3:
За меня страдал Христос, Держит Он меня.
Наказание понес, Держит Он меня.
Я воскресну к жизни с Ним Держит Он меня
Знаю, буду Им храним До Благого Дня.', 'Куплет 1:
G C D G
G C D G
C D G C H Em
C D G C D G
Припев:
C D Em
Em D G
G Am G C
C D G
Куплет 2:
G C D G
G C D G
C D G C H Em
C D G C D G
Куплет 3:
G C D G
G C D G
C D G C H Em
C D G C D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=50 | photo=notion-youth-songbook | notionPageId=991ed6ab-0e7b-47ae-ba03-63b4f21634af | notionChordPageId=399ee036-70b3-4efe-959e-7f12ba4c2a22 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/991ed6ab0e7b47aeba0363b4f21634af', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Держит Он меня!'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=50%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Дивный Спаситель, прекрасный', 'Молодёжный сборник', NULL, 'Куплет 1:
Дивный Спаситель, прекрасный,
Наш Искупитель и Друг.
Кто мог подумать, что Агнец
Мог искупить нас от мук,
О, мог искупить нас от мук?
Припев:
Ты – Тот, Кого прославляем,
Тот, Кого любим всегда.
Дай исцеление и милость
Нашим голодным сердцам,
О, нашим голодным сердцам.
Куплет 2:
Сторож души и Советник,
Дух Твой мы жаждем вдохнуть.
Новой надеждой Ты светишь,
Если теряем мы путь,
О, если теряем мы путь.
Куплет 3:
Вечный Отец Всемогущий,
Верно Ты любишь Своих,
В слабости к Трону идущих,
Чтобы у ног пасть Твоих,
О, чтобы у ног пасть Твоих.', 'Куплет 1:
C F C
Em F G
Am F Fm
C G Am
F C G C E
Припев:
Am G F G
Am G F G
Am F Fm
C G Am
F C G C
Куплет 2:
C F C
Em F G
Am F Fm
C G Am
F C G C E
Куплет 3:
C F C
Em F G
Am F Fm
C G Am
F C G C E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=51 | photo=notion-youth-songbook | notionPageId=7c4040ad-8119-4299-8431-941e770f4eaa | notionChordPageId=de777582-6048-43d7-89ab-2259b9b10eef | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7c4040ad811942998431941e770f4eaa', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Дивный Спаситель, прекрасный'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=51%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Для тебя, о человек', 'Молодёжный сборник', NULL, 'Куплет 1:
Для тебя, о человек, Бог создал небо и поля,
Для тебя цветут сады и плод дает земля,
Для тебя моря и горы, все живое – для тебя,
Для тебя на небе солнце и луна.
Припев:
Что отдал ты Ему за эту красоту?
Что отдал ты за эти чудеса?
Подумай, человек, ведь твой недолгий век.
Отдай Ему себя! Отдай Христу себя!
Куплет 2:
Для тебя звучит мелодия в далекой вышине,
Для тебя роса на травах на заре,
Для тебя моря и горы, все живое – для тебя,
Для тебя все это создала Его рука.', 'Куплет 1:
Am Dm
E Am
A Dm
Am E Am
Припев:
Am Dm Am
Gm A Dm
E Am F
Dm F E
Куплет 2:
Am Dm
E Am
A Dm
Am E Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=52 | photo=notion-youth-songbook | notionPageId=0aee615f-f9a3-4135-8066-2599b0ee10e9 | notionChordPageId=ae1489c5-0a4c-4165-b600-e3fce2d53577 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0aee615ff9a3413580662599b0ee10e9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Для тебя, о человек'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=52%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Дни, как звук, отшумят', 'Молодёжный сборник', NULL, 'Куплет 1:
Дни, как звук, отшумят и исчезнут вдали.
В синем небе летят над землёй журавли.
В журавлином пути быстрый бег твоих лет.
И оставишь ли ты, и оставишь ли ты
На земле добрый след.
Куплет 2:
Как пройти этот путь, чтобы что-то отдать,
Людям счастье вернуть, веру не потерять.
Пусть же юность твоя ярким светом горит
И крупицы добра, и крупицы добра
Людям щедро дарит.
Куплет 3:
Дни, как звук, отшумят и исчезнут вдали.
В синем небе летят над землёй журавли.
В журавлином пути быстрый бег твоих лет.
И оставишь ли ты, и оставишь ли
На земле добрый след.', 'Куплет 1:
Am E Am
Dm G C
C Dm G C
Dm Am E
E Am
Куплет 2:
Am E Am
Dm G C
C Dm G C
Dm Am E
E Am
Куплет 3:
Am E Am
Dm G C
C Dm G C
Dm Am E
E Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=53 | photo=notion-youth-songbook | notionPageId=7052ee21-45bc-4abd-993e-d28480e1c62b | notionChordPageId=eb817dd6-9104-4a25-9e39-def5ec966797 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7052ee2145bc4abd993ed28480e1c62b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Дни, как звук, отшумят'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=53%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Долго в сумраке скитался', 'Молодёжный сборник', NULL, 'Куплет 1:
Долго в сумраке скитался, на путях греховных я
В жизни разочаровался, мир обманывал меня.
Я взывал: «Кто мне поможет? Скорбь мою увидит кто?»
И услышал голос Божий: «Я люблю Тебя давно».
Припев:
"Так давно, так давно Я люблю тебя давно.
О, как сладок Божий голос - Я люблю тебя давно."
Куплет 2:
Он меня с любовью принял и от всех грехов омыл,
Я к ногам Его склонился и за всё благодарил.
И теперь всегда покоюсь я на пажитях Его,
Постоянно слышу голос: «Я люблю Тебя давно»
Куплет 3:
И ни в чём мне нет отрады, мир греха мне чуждым стал
Во Христе лишь, Друге дивном, утешенье я познал.
О, как чудно жить в объятиях у Того, Кто жизнь даёт
Слышать голос утешенья: «Я люблю Тебя давно»
Куплет 4:
О, приди обременённый, лишь доверься, Он простит
С верой глянь на крест Голгофский и тебя он оживит.
Если искренно покаясь, в сердце примешь ты Его
Непременно ты услышишь: «Я люблю Тебя давно»', 'Куплет 1:
Am Dm G C
F Dm E E7
Am Dm G C
F Dm E E7
Припев:
Am Dm G C
F Dm E Am
Куплет 2:
Am Dm G C
F Dm E E7
Am Dm G C
F Dm E E7
Куплет 3:
Am Dm G C
F Dm E E7
Am Dm G C
F Dm E E7
Куплет 4:
Am Dm G C
F Dm E E7
Am Dm G C
F Dm E E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=54 | photo=notion-youth-songbook | notionPageId=9b8eb47a-2e74-430a-8d4c-701c377553dd | notionChordPageId=76f4e9b7-97d0-4272-955a-50a4a4f73d1b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9b8eb47a2e74430a8d4c701c377553dd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Долго в сумраке скитался'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=54%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Дорога смерти в Иерусалиме', 'Молодёжный сборник', NULL, 'Куплет 1:
Дорога смерти в Иерусалиме,
По ней ступает Человек совсем бессильный
Избит, измучен, весь кровоточит,
И гвоздь заточен, чтобы жизнь Его закончить.
Припев:
Его любовь с креста тебе кричала:
“Здесь Мой конец, а для тебя здесь есть начало”.
Она давно тебя звала, искала,
Когда во тьме ты болен был, она стонала…
Куплет 2:
Как нам легко и как нам просто
Идти, мой друг, по Виа Долороса
Вид узких улиц, вслед смотрят косо
Всем, кто пришел найти ответ Его вопросам.
Куплет 3:
Дорога смерти в Иерусалиме,
По ней ступает Человек совсем бессильный
Идет, чтоб вечность дать нам с тобою,
Путь в бесконечность проложить Своею Кровью.', 'Куплет 1:
Dm A#
Gm C Dm
Dm A#
Gm C F
Припев:
F A# Gm
Gm C F
F A# Gm
Gm C Dm
Куплет 2:
Dm A#
Gm C Dm
Dm A#
Gm C F
Куплет 3:
Dm A#
Gm C Dm
Dm A#
Gm C F', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=55 | photo=notion-youth-songbook | notionPageId=a9294273-b26d-4350-b251-b59638ed0bff | notionChordPageId=a8ff8072-3286-4859-a7d0-e044ef134294 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a9294273b26d4350b251b59638ed0bff', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Дорога смерти в Иерусалиме'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=55%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Душу мою к Тебе возношу', 'Молодёжный сборник', NULL, 'Куплет 1:
Душу мою к Тебе возношу -
На Тебя уповаю.
Веры своей не устыжусь
Боже к Тебе я взываю.
Припев:
Пусть Твоя истина и правота
Ночью и днем охраняет меня.
Очи мои устремлены
К Великому Богу любви.
Куплет 2:
Боже, как долго блуждал я во тьме.
Боже, будь рядом со мною.
Боже, прошу, приблизся ко мне.
В святости нежной любовью.', 'Куплет 1:
D A Em Hm
G A
D A Em Hm
G A
Припев:
G D A
G D A
D A Em Hm
G A D
Куплет 2:
D A Em Hm
G A
D A Em Hm
G A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=56 | photo=notion-youth-songbook | notionPageId=404959d9-81ef-483d-8e34-336f40e9cc4b | notionChordPageId=169b3e7e-d29a-45fe-ae1e-b8017926ac6d | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/404959d981ef483d8e34336f40e9cc4b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Душу мою к Тебе возношу'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=56%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Если ждет тебя дорога', 'Молодёжный сборник', NULL, 'Куплет 1:
Если ждет тебя дорога в неизвестный край,
На прощанье у порога думы не гадай,
Слово доброе послушай и совет прими:
В этом мире гибнут души, ты свою храни.
Куплет 2:
Если ждет тебя дорога в неизвестный край,
Спутницей себе тревогу ты не выбирай,
С ней душе одна забота и тоска в пути -
В звездном небе будто кто-то потушил огни.
Куплет 3:
Если ждет тебя дорога в неизвестный край,
Не суди упавших строго, лучше поднимай,
Может статься, сам в бессилье где-то упадешь,
Ослабеют сердца крылья, веру надорвешь.
Куплет 4:
Жизнь кипит вокруг, как море, бьет тебя волной,
И в твоем огромном горе ты для всех чужой.
Помощь есть для всех у Бога, ты к Нему взывай,
Если ждет тебя дорога в неизвестный край.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=57 | photo=notion-youth-songbook | notionPageId=a39f5d5d-7b8c-4ece-ac49-ab32d3ce250a | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/a39f5d5d7b8c4eceac49ab32d3ce250a | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Если ждет тебя дорога'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=57%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Есть на небе город', 'Молодёжный сборник', NULL, 'Куплет 1:
Есть на небе город, чудный город света,
Там нужды болезни и печали нету.
Там Живут святые, там играют гусли,
Воспевая славу Господу Иисусу.
Припев:
Болезни там нет, не гаснет там свет, Иерусалим.
Там вечно живут, там песни поют, Иерусалим.
Ты город живых, ты город святых, Иерусалим.
К тебе я стремлюсь, с тобой я сольюсь, Иерусалим.
Куплет 2:
Золотом обложен город тот прекрасный,
Лишь в тебе, Иерусалим, вечно буду счастлив.
Жизнь мою преобрази здесь, в земной долине,
Чтоб покой душе найти в Иерусалиме.
Куплет 3:
Братья мои, сёстры, там мы будем вместе
Воспевать Иисусу радостные песни.
Так давайте ж на земле вместе славить Бога,
Чтобы стала нам светлей в небеса дорога.', 'Куплет 1:
Am Dm E Am
Am F G C
Am Dm G C
Am E
Припев:
Am Dm
G C E
Am Dm
Am E Am Dm
Куплет 2:
Am Dm E Am
Am F G C
Am Dm G C
Am E
Куплет 3:
Am Dm E Am
Am F G C
Am Dm G C
Am E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=58 | photo=notion-youth-songbook | notionPageId=4a650950-ebfc-4e24-a91f-2209a5ae6962 | notionChordPageId=09204246-e0b9-4199-92d6-7ffbd20f9321 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4a650950ebfc4e24a91f2209a5ae6962', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Есть на небе город'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=58%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Живущий под кровом Твоим', 'Молодёжный сборник', NULL, 'Куплет 1:
Живущий под кровом Твоим
Под сенью покоится,
Господу говорит:
“Ты - мой щит”.
Припев:
Он избавит меня от сети ловца
И от гибельной язвы меня сохранит,
Потому что уповаю на Творца,
Потому что я говорю: “Бог мой щит”.', 'Куплет 1:
E H
H A H
E H
H A H
Припев:
E G#m A H
E G#m A H
E H A
A H E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=59 | photo=notion-youth-songbook | notionPageId=4977a864-2386-44a9-8e79-08c7f1b40e41 | notionChordPageId=0aa2b9c6-803b-4326-a72a-0b23ac58f952 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4977a864238644a98e7908c7f1b40e41', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Живущий под кровом Твоим'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=59%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Жизни река бежит', 'Молодёжный сборник', NULL, 'Куплет 1:
Жизни река бежит, в вечность она ведёт,
Кто грех свой победит, в вечную жизнь войдёт.
Нужно Иисуса искать, нужно Его найти.
Вечную благодать, верою обрести.
Куплет 2:
Вера – нелёгкий путь, узок он и тернист.
Главное не свернуть, главное прямо ввысь.
Вера нелёгкий наш путь, но нет путей иных.
Чтобы к Христу прильнуть, в царстве Его святых.
Куплет 3:
Верю, Господь Иисус, верю Ты – мой Творец.
Верю утрёшь слезу дашь славы мне венец.
Верю, что день тот придет, примешь меня Иисус.
Верю, Ты мой Господь, верю не постыжусь.', 'Куплет 1:
Dm A7 Dm Gm
A7 Dm C7 F
D7 Gm
Dm A7 Dm
Куплет 2:
Dm A7 Dm Gm
A7 Dm C7 F
D7 Gm
Dm A7 Dm
Куплет 3:
Dm A7 Dm Gm
A7 Dm C7 F
D7 Gm
Dm A7 Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=60 | photo=notion-youth-songbook | notionPageId=1785e4eb-f62f-4b08-9197-92145fca5797 | notionChordPageId=82ea0cfb-0b2e-4737-bcc0-8a3fd1774da2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1785e4ebf62f4b08919792145fca5797', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Жизни река бежит'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=60%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Жизнь – борьба', 'Молодёжный сборник', NULL, 'Куплет 1:
Жизнь – борьба Света с тьмой,
Надо мной и над тобой.
Шумит ветер, рвется пламя,
Дал нам Бог победы знамя!
Путь назначен нам далекий,
И тернистый, и нелегкий.
Рождены мы все в пустыне,
Бог призвал нас быть святыми.
Припев:
Столп огня нас ведет среди ночи,
Раздвигает моря, если хочет.
Столп огня, сила Духа Святого,
Разрушает любые оковы.
Куплет 2:
Его сила, Его слава,
Бога Сущего от начала,
Сердце силой наполняет,
Духом нас соединяет.
Нас ведет одна дорога,
Истина и жизнь от Бога.
Мы, рожденные в пустыне,
Прославляем Его Имя!', 'Куплет 1:
Am F
Dm E
Am F
Dm G
F C
Dm Am
F C
Dm E
Припев:
Am F
Dm E
F Dm
C E
Куплет 2:
Am F
Dm E
Am F
Dm G
F C
Dm Am
F C
Dm E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=61 | photo=notion-youth-songbook | notionPageId=0ceae948-d008-4a32-8b8e-f2928cb0fc2b | notionChordPageId=eaae2921-1742-411d-b3ef-089ea93ec398 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0ceae948d0084a328b8ef2928cb0fc2b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Жизнь – борьба'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=61%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Жизнь это поле', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты устал в этой жизни от горя и слез,
Ты повсюду встречаешь шипы вместо роз,
Кто-то предал тебя - ты ему не простил,
Слов обидных друзьям ты своим не забыл.
Столько раз забывали тебя поддержать,
Когда нужно слова ободренья сказать,
И теперь, в своем сердце обиду храня,
Ты живешь на земле, никого не любя…
Припев:
Ведь жизнь - это поле, ты сам выбираешь:
Семя какое в него погружаешь.
Но только запомни, плоды будут позже,
Всё на весы Бог когда-то положит…
Куплет 2:
Мой уставший, израненный друг, не спеши –
Ты колени склони перед Богом в тиши,
И о ране своей всё Ему расскажи,
Исцеленье найдешь у Христа для души.
В твое сердце прольется луч света, добра,
Вдруг увидишь лицо Иисуса Христа.
Он страдал на кресте, Он людей возлюбил,
Хочет Он, чтоб обиды свои ты простил!', 'Куплет 1:
Am G
Dm Am
F C
Dm E
F C
Dm Am
F Am
Dm E
Припев:
Am E G D
F Am Dm E
Am E G D
F Am Dm E Am
Куплет 2:
Am G
Dm Am
F C
Dm E
F C
Dm Am
F Am
Dm E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=62 | photo=notion-youth-songbook | notionPageId=07af1246-82a6-4ae9-b3ed-32089f1b4d0e | notionChordPageId=f52dc671-4ade-45d7-a9f2-38da46c10594 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/07af124682a64ae9b3ed32089f1b4d0e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Жизнь это поле'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=62%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За всё благодарите', 'Молодёжный сборник', NULL, 'Куплет 1:
Праздник жатвы наступил как ты этот год прожил?
Сердце благодарное ли ты Богу принес?
Мы всегда в Его руках, будем же беречь в сердцах
Искру благодатного огня, что хранил меня.
Припев:
За всё благодарите Его ничто мы в этом мире без Него
В Нем жизни дыханье, в Нем мудрость и знанье.
За все благодарите Творца, за то что Его милость без конца.
В Жатвы День мы благодарим Его,
В Жатвы День мы благодарим Его.
Куплет 2:
Все здесь проходящее, ветром уносящее,
Как песок рассыпется и все уйдет в никуда.
Только милость вечная, Божья бесконечная
На Земле останется, ведь Он Бог Спаситель твой.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=63 | photo=notion-youth-songbook | notionPageId=15e8794a-cda0-42c9-9ba1-ad76d1e99860 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/15e8794acda042c99ba1ad76d1e99860 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За всё благодарите'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=63%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За все я благодарю', 'Молодёжный сборник', NULL, 'Куплет 1:
За все Тебя, Господь, я благодарю
Ты искупил от смерти душу мою.
И буду возвещать я по всей земле
О том, как милостив и благ Ты ко мне.
Припев:
Вся слава Тебе, мой Иисус,
Спасенье дал мне мой Иисус,
И сердце во мне – о, Иисус,
Поет о Тебе всегда, Иисус.
Куплет 2:
Я посвящаю жизнь свою лишь Тебе,
И благодать Твоя сегодня на мне.
Пусть каждый знает, слыша из моих уст,
О том, что жив Господь, Спаситель Иисус.
Куплет 3:
С креста стекала кровь Святая Твоя,
Грехи смывая, очищала меня.
Одежду правды мне Иисус подарил,
Простил, очистил и меня искупил.', 'Куплет 1:
F A Dm
F A Dm
Gm D Gm C
F C A# C
Припев:
F A7 Dm A# C F
F A7 Dm A# C F
F A7 Dm A# C F
A7 Dm C A#
Куплет 2:
F A Dm
F A Dm
Gm D Gm C
F C A# C
Куплет 3:
F A Dm
F A Dm
Gm D Gm C
F C A# C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=64 | photo=notion-youth-songbook | notionPageId=f8279bc8-ed20-4386-baf3-b4f5203bfde3 | notionChordPageId=95889e28-768f-4110-a9bf-8d34961148bd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f8279bc8ed204386baf3b4f5203bfde3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За все я благодарю'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=64%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За Голгофу, за кровь', 'Молодёжный сборник', NULL, 'Куплет 1:
За Голгофу, за кровь я Тебя благодарю.
За Воскресенье Твое, за победу Твою.
Припев:
Благодарю Тебя, Иисус.
Благодарю Тебя, Иисус.
Благодарю Тебя, Иисус.
Просто я благодарю.
Просто я благодарю.
Куплет 2:
За прекрасный рассвет, добрый утрений свет.
За творенье Твое, за спасенье Мое.
Куплет 3:
За чистый воздух с небес, светлый солнечный лес.
За ликование птиц, за Слово с вечных страниц.', 'Куплет 1:
D A Hm G D A
D A Hm G A D
Припев:
D A Hm
G D A
D A Hm
G D
G D A D
Куплет 2:
D A Hm G D A
D A Hm G A D
Куплет 3:
D A Hm G D A
D A Hm G A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=65 | photo=notion-youth-songbook | notionPageId=9f1f4d29-1193-4a45-be7c-a33d604a699a | notionChordPageId=3c55ef66-c092-478e-895e-3506f17ab82a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9f1f4d2911934a45be7ca33d604a699a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За Голгофу, за кровь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=65%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Зажечь лесной пожар', 'Молодёжный сборник', NULL, 'Куплет 1:
Зажечь лесной пожар одной довольно искры,
Огонь не удержать, он вширь помчится быстро.
//: Вот так и Божия любовь и Божья благодать,
Кто их познал, не может тот в себе их удержать. ://
Куплет 2:
Когда кругом весна, поют ручьи и птицы,
Весь Божий мир поёт и хочется молиться.
//: Вот так и Божия любовь и Божья благодать,
Ты хочешь петь, ты хочешь их другому передать. ://', 'Куплет 1:
D F#m G A
D F#m G A
G D G D Hm
G Hm G A D
Куплет 2:
D F#m G A
D F#m G A
G D G D Hm
G Hm G A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=66 | photo=notion-youth-songbook | notionPageId=602272fe-28a7-45f4-a9d1-716993d8dee1 | notionChordPageId=956365a3-fc26-4568-bc9f-bb8d8cde7a75 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/602272fe28a745f4a9d1716993d8dee1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Зажечь лесной пожар'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=66%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Зачем мой Господь', 'Молодёжный сборник', NULL, 'Куплет 1:
Зачем, мой Господь, Ты оставил всех ангелов в небе?
Зачем, мой Господь, Ты оставил родного Отца?
И славу оставив всю, родился Ты в смертном теле.
Зачем Царь всего творенья обнищал?
Куплет 2:
На небе Тебе славу дивные ангелы пели,
Ты был там согрет бесконечной любовью Отца.
Зачем Ты оставил свой любимый небесный город?
Зачем Ты прийти на землю пожелал?
Куплет 3:
Ты видел с небес как я жил бесполезно греховно,
Достоин того что быть брошенным в огненный ад.
И Ты тихо в мир сошел и вместо меня покорно
Был мучим, гоним, оплеван и распят.
Припев:
Для меня сошел Ты с небес,
(Для меня - - а- - - - - - - а-а)
За меня был поднят на крест.
(За меня - - - а- - - - - - - а-а)
Чтобы грех снять, боль мою унять,
Чтобы мне удел с собою в небе дать.
Куплет 4:
За что же меня, мой Господь, бесконечно Ты любишь?
Ведь я не достоин поднять даже к небу глаза.
На миг замолкает все, глаза заливают слезы,
Ведь я Тебе столько боли причинял.
Куплет 5:
Хочу Тебя славить, Господь мой, за дар Твой бесценный.
Хоть слаб я и нищ и не знаю где взять нужных слов.
Пусть будут слова просты, но искренние от сердца.
Ведь Ты для меня так дорог, мой Господь.
Припев', 'Куплет 1:
Dm                          F                             Gm              A
     Dm                          F                             Gm            C
     Gm                          C         F                                     Bb
     Gm                                 Bb                 A
Куплет 2:
Dm            F                        Gm            A
      Dm                       F                          Gm                  C
     Gm                           C            F                              Bb
     Gm                             Bb                    A
Куплет 3:
Dm                     F                               Gm             A
       Dm            F                                             Gm               C
    Gm                             C           F                         Bb
         Gm                            Bb                 A
Припев:
               Dm    Gm                 Dm    Gm
               Dm   Gm           F        Bb       A
Куплет 4:
Dm                 F                                      Gm              A
        Dm              F                                   Gm            C
     Gm                           C          F                         Bb
       Gm                           Bb                  A
Куплет 5:
Dm                F                                       Gm                     A
            Dm               F                            Gm                        C
            Gm                            C         F                          Bb
          Gm                           Bb                        A
Припев:
               Dm    Gm                 Dm    Gm
               Dm   Gm           F        Bb       A
Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=67 | photo=notion-youth-songbook | notionPageId=ec38bccd-02be-4ad8-bc8e-215bb9d1909e | notionChordPageId=6a86c4c9-d546-469b-b1fb-7769645e1f22 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ec38bccd02be4ad8bc8e215bb9d1909e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Зачем мой Господь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=67%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'За шагом шаг', 'Молодёжный сборник', NULL, 'Куплет 1:
Мы пытаемся найти в жизни разные пути.
Кто укажет нам дорогу в светлый мир?
Кто подарит мир сердцам, не оставит до конца?
Нас Господь ведет свой дом на небеса.
Припев:
За шагом шаг смело мы вперёд пойдём.
Бог дает нам радость жизни,
Он наш путь сквозь тьму и дождь.
День за днем мы его путем идем.
Нам Господь дарует силу
Шаг за шагом день за днем.
Куплет 2:
Церковь станет нам мостом в замок веры, в светлый дом,
Где надежда и уверенность в грядущем.
Пусть сияет свет Христа. В нём любовь и доброта
И святая неземная красота.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=68 | photo=notion-youth-songbook | notionPageId=c8f0c7b5-eabb-4975-8baf-e16a80148656 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/c8f0c7b5eabb49758bafe16a80148656 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'За шагом шаг'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=68%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Здесь, на земле, мы только странники', 'Молодёжный сборник', NULL, 'Куплет 1:
Здесь, на земле, мы только странники
И часто путь далекий ждёт.
Порою ноги от усталости болят,
Но в небе Родина нас ждёт!
Припев:
Там, там, там, в небесах,
Ангелы поют.
В синих, синих, синих небесах
Родина нас ждет!
Куплет 2:
Порою мы друзей встречаем,
И снова дальний путь зовёт.
Увидимся у ног Спасителя Христа,
Ведь в небе Родина нас ждет!
Куплет 3:
В дороге дальней, дорогие друзья,
Вы расскажите людям всем,
Как велика любовь Спасителя Христа,
Что в небе Родина нас ждет!', 'Куплет 1:
Am Dm
E Am
Am Dm
F E
Припев:
Am Dm
G C E
Am Dm
E Am
Куплет 2:
Am Dm
E Am
Am Dm
F E
Куплет 3:
Am Dm
E Am
Am Dm
F E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=69 | photo=notion-youth-songbook | notionPageId=e110d31d-3257-4c3f-bf07-3c438e9cabac | notionChordPageId=e563d8eb-790e-4ff9-9f2e-19caa761abc7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e110d31d32574c3fbf073c438e9cabac', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Здесь, на земле, мы только странники'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=69%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Знаешь, в жизни всё проходит', 'Молодёжный сборник', NULL, 'Куплет 1:
Знаешь, в жизни всё проходит и уходит, уплывает как вода,
А за суетою жарких будней остается лишь пустота.
Каждый день бежишь куда не знаешь, на работу, по делам,
И вокруг себя не замечаешь ту любовь, что ищет нас.
Припев:
В чём смысл твоей жизни?
Пустота… Пустота… Если нету в ней Христа…
В чём смысл твоей жизни?
Суета… И пустота… Если нету в ней Христа…
Куплет 2:
Знаешь, в жизни всё проходит и уходит, уплывает как вода,
А за суетою жарких будней остается лишь пустота.
Сколько раз ты задавал вопросы, находил ли ты ответ?
Для чего пришёл на эту землю и для чего ты ешь свой хлеб?
Мост:
:: Есть смысл твоей жизни,
Лишь с Христом, лишь с Христом, счастье будет только в нём. ::', 'Куплет 1:
Dm A#
C A
Dm A#
C A
Припев:
Dm
A# Gm A
Dm
A# Gm A
Куплет 2:
Dm A#
C A
Dm A#
C A
Припев:
Dm
A# Gm A
Dm
A# Gm A
Мост:
Em
C Am H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=70 | photo=notion-youth-songbook | notionPageId=b9682b7b-50ae-4f80-9457-6d0865157e15 | notionChordPageId=18b335cf-250e-4d40-9662-b3bacb20db83 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b9682b7b50ae4f8094576d0865157e15', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Знаешь, в жизни всё проходит'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=70%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Измени меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Измени меня, измени меня
Чтобы я смог сделать то,
Для чего Ты меня призвал,
Измени меня!
Куплет 2:
Укрепи меня, укрепи меня,
Чтобы я мог быть сильней,
Пребывал в любви Твоей.
Укрепи меня!
Куплет 3:
Испытай меня, испытай меня,
Чтоб нуждался я в Тебе,
Чтобы Ты пребывал во мне.
Испытай меня!
Куплет 4:
Охраняй меня, охраняй меня,
Чтоб я чувствовал Тебя,
Прославлял Тебя, любя.
Охраняй меня!
Куплет 5:
Освяти меня, освяти меня,
Чтобы я мог сделать то,
Для чего ты меня призвал.
Освяти меня!', 'Куплет 1:
E H7 E
A H7
E C#m
A H7 E
Куплет 2:
E H7 E
A H7
E C#m
A H7 E
Куплет 3:
E H7 E
A H7
E C#m
A H7 E
Куплет 4:
E H7 E
A H7
E C#m
A H7 E
Куплет 5:
E H7 E
A H7
E C#m
A H7 E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=71 | photo=notion-youth-songbook | notionPageId=b4d218a9-2acc-4547-b627-614fb0f57bd7 | notionChordPageId=64d67bf2-fa7b-4d2e-b3e2-d8d577ff81df | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b4d218a92acc4547b627614fb0f57bd7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Измени меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=71%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, как Ты дорог для меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Иисус, как Ты дорог для меня
Иисус, внемлешь Ты мольбе моей.
О, Иисус, поднимешь Ты, коль упаду;
Как Ты дорог, дорог для меня.
Куплет 2:
Иисус, Тебя люблю я прославлять.
Иисус, Ты без начала, без конца.
Иисус, Ты умер и простил мой грех;
Как Ты дорог, дорог для меня.
Куплет 3:
Иисус, Ты обещал прийти сюда.
Иисус, мы ждем Тебя, открыв сердца.
О, Иисус, услышь Ты наши голоса;
Как Ты дорог, дорог для меня.', 'Куплет 1:
D Em
A7 D
Hm Em
A7 D
Куплет 2:
D Em
A7 D
Hm Em
A7 D
Куплет 3:
D Em
A7 D
Hm Em
A7 D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=72 | photo=notion-youth-songbook | notionPageId=480318d0-5895-42f8-8cdc-6c6900672ece | notionChordPageId=9f2d6af7-a499-4b02-a80e-c1a5f96d0f16 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/480318d0589542f88cdc6c6900672ece', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, как Ты дорог для меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=72%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, превозносим', 'Молодёжный сборник', NULL, 'Куплет 1:
Иисус, превозносим
Твоё имя, Ты – Царь,
Пребывающий среди нас,
И наполняющий сердца!
Припев:
Мы поклоняемся Тебе, Господь!
Ты – Бог на небе и на земле,
Ты – Бог на небе и на земле,
Ты – Владыка во веки веков.
Куплет 2:
Иисус, Ты достоин
Вечной славы от нас
Возвещать буду всякий час
Благословение Твоё!
Куплет 3:
Воссел одесную
Ты на троне Отца
Прими славу, величие
И восхваление без конца', 'Куплет 1:
G Em
C Am D
G Em
C D G
Припев:
D Em
C D G Em
C D G Em
C D G
Куплет 2:
G Em
C Am D
G Em
C D G
Куплет 3:
G Em
C Am D
G Em
C D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=73 | photo=notion-youth-songbook | notionPageId=3aa33724-4ed5-4258-8131-3e98e0ecfd38 | notionChordPageId=c597f442-2c74-4549-9f20-4c28124d5a6c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3aa337244ed5425881313e98e0ecfd38', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, превозносим'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=73%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, Ты любовь моя', 'Молодёжный сборник', NULL, 'Куплет 1:
Иисус, Ты любовь моя,
Иисус, не оставлю я Тебя,
Из темноты Ты забрал меня,
Дал свободу и теперь знаю я:
Припев:
В Тебе я нуждаюсь,
Я люблю Тебя, навеки будь со мной.
Спаситель, мой лучший друг,
Прославлять Тебя я буду вновь и вновь.
Куплет 2:
Иисус, ты спаситель мой.
Иисус, лишь в тебе найду покой.
Даришь ты жизни полноту,
Ты скала моя и я к тебе иду!', 'Куплет 1:
D A F#
Hm G A
D A F#
Hm G A
Припев:
D A F# Hm
G A D
D A F# Hm
G A D
Куплет 2:
D A F#
Hm G A
D A F#
Hm G A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=74 | photo=notion-youth-songbook | notionPageId=49f7d329-452f-440f-9568-e23cf3c8d18d | notionChordPageId=4bc2fdbc-0c46-485f-abc7-b31da83b8f00 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/49f7d329452f440f9568e23cf3c8d18d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, Ты любовь моя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=74%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, Ты моя скала', 'Молодёжный сборник', NULL, 'Куплет 1:
Когда в море бушует волна,
Ветер рвет твои паруса,
И бессмысленной стала борьба,
Пой тогда:
Припев:
Иисус, Ты моя скала,
Иисус, Ты живая вода,
И Голгофы завет крови
Верен Ты,
Упованье мое и покой.
Я однажды вернусь домой
И услышу Твои слова:
“Ждал Я Тебя!”
Куплет 2:
В нашей жизни любая беда,
Словно в море крутая волна,
Губит тех, кто бросил грести,
Свой крест нести.
Куплет 3:
Укрепившись любовью Отца,
Верой в жертву Иисуса Христа,
Силой Духа Святого всегда
Пой слова.', 'Куплет 1:
Am E Am
G C
Dm Am
E
Припев:
Dm G
C Am
Dm E
E Am
Dm G
C Am
Dm E
E7 Am
Куплет 2:
Am E Am
G C
Dm Am
E
Куплет 3:
Am E Am
G C
Dm Am
E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=75 | photo=notion-youth-songbook | notionPageId=48be6208-3700-44ae-a808-8afb39ab9ac2 | notionChordPageId=15a3479b-d150-4dd7-89c0-539b9a95b589 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/48be6208370044aea8088afb39ab9ac2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, Ты моя скала'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=75%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Иисус, Ты умер на кресте', 'Молодёжный сборник', NULL, 'Куплет 1:
Иисус, Ты умер на кресте
Воскрес, чтоб грешников спасти.
Мои все грехи, Иисус, прости,
Спаситель, Друг, Господь мой Ты!
Припев:
Измени меня, прошу,
Ведь я Тебе служить хочу.
Измени меня, прошу,
Ведь я Тебе служить хочу.', 'Куплет 1:
D A Hm
G D A D
D A Hm
G D A D
Припев:
G A Hm
G D A D
G A Hm
G D A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=76 | photo=notion-youth-songbook | notionPageId=101d044d-0291-4a41-a204-b6f0ca7601f1 | notionChordPageId=a072921f-55c7-447d-8f13-73621ff833a5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/101d044d02914a41a204b6f0ca7601f1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Иисус, Ты умер на кресте'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=76%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ищите Бога', 'Молодёжный сборник', NULL, 'Куплет 1:
Ищите Бога, ищите слёзно,
Ищите, люди, пока не поздно.
И днём, и ночью, в жару и стужу
Ищите Бога, Он сердцу нужен!
Куплет 2:
Ищите Бога, ищите каждый,
И вы найдёте Его однажды.
И будет радость превыше неба,
Но так ищите, как нищий — хлеба!', 'Куплет 1:
Cm Fm G Cm
Fm G Cm C
Fm A# Cm
Fm G Cm
Куплет 2:
Cm Fm G Cm
Fm G Cm C
Fm A# Cm
Fm G Cm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=77 | photo=notion-youth-songbook | notionPageId=5a9ca282-7ae7-4255-b6e2-86df7ffc65c3 | notionChordPageId=c4ffd83c-7861-4625-a80a-99d6610c392f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5a9ca2827ae74255b6e286df7ffc65c3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ищите Бога'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=77%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ищите прежде Царства', 'Молодёжный сборник', NULL, 'Куплет 1:
Ищите прежде Царства Божия
И правды Его,
Все остальное приложится вам,
Аллилуйя, аллилуйя!
Куплет 2:
Царствие Божие не пища и питье,
А праведность и мир,
И радость во Святом Духе,
Аллилуйя, аллилуйя!
Куплет 3:
Просите и дано будет вам,
Ищите и найдете,
Стучите и отворят вам,
Аллилуйя, аллилуйя!', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=78 | photo=notion-youth-songbook | notionPageId=214a2ef2-ad6b-4881-bb4b-5fbdd34400ec | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/214a2ef2ad6b4881bb4b5fbdd34400ec | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ищите прежде Царства'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=78%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Каждый день улетают самолёты', 'Молодёжный сборник', NULL, 'Припев:
Каждый день улетают самолёты,
Каждый час уезжают поезда,
Но, а я - останусь с Иисусом
Навсегда, навсегда, навсегда.
Куплет 1:
В жизни много суеты,
От неё устанешь ты.
Только Бог даёт покой
Любящей Своей рукой.
Куплет 2:
Доверяй Ему всегда -
Не покинет никогда.
Он отдал всю жизнь Свою,
Чтобы жил ты с Ним в раю.
Куплет 3:
Никогда не унывай,
Небо есть заветный край.
Ты в него всегда смотри,
Помощь Господа прими.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=79 | photo=notion-youth-songbook | notionPageId=263c0a1a-4df3-4525-94be-259bd75020d9 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/263c0a1a4df3452594be259bd75020d9 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Каждый день улетают самолёты'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=79%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как вожделенны жилища Твои', 'Молодёжный сборник', NULL, 'Куплет 1:
Как вожделенны жилища Твои,
Господи сил!
Истомилась душа моя,
Желая войти
Во дворы Господни, дворы Господни,
Господи Боже сил!
Ибо день один во дворах Твоих
Лучше тысячи.
Куплет 2:
Услышь молитву мою,
Боже, защитник наш.
Приникни, призри на лице
Помазанника Твоего.
Ибо Ты даёшь благодать и славу,
Ибо Ты есть солнце и щит,
Ибо день один во дворах Твоих
Лучше тысячи.', 'Куплет 1:
C G Am7 F
C G
C G Am7 F
C G
C E Am F
E Am
Dm G Em Am
Dm G C
Куплет 2:
C G Am7 F
C G
C G Am7 F
C G
C E Am F
E Am
Dm G Em Am
Dm G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=80 | photo=notion-youth-songbook | notionPageId=3ad616da-f2ce-41f7-99f2-8353184afa37 | notionChordPageId=d13aeb49-5f33-47d4-8ce7-40c62f3c3723 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3ad616daf2ce41f799f28353184afa37', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как вожделенны жилища Твои'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=80%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как вожделенны', 'Молодёжный сборник', NULL, 'Куплет 1:
Как вожделенны жилища Твои,
Господи, Боже сил.
Как вожделенны жилища Твои,
Господи, Боже сил.
Так истомилась душа моя,
Желая в Господни дворы.
Сердце мое и плоть моя
Стремятся туда, где Ты, где Ты, где Ты.
Куплет 2:
Господи, Боже, призри на лице
Помазанника Твоего.
Господи, Боже, призри на лице
Помазанника Твоего.
Лучше мне жить у порога в Твой дом,
Нежели в замке греха,
Ибо, Господь, Ты есть солнце и щит,
Блажен тот, кто верит в Тебя.
Мост:
Я верю в Тебя, мой Бог!
Я верю в Тебя, мой Бог!
Я верю в Тебя, мой Бог!
Я верю в Тебя!
Я верю в Тебя, мой Бог!
Я верю в Тебя, мой Бог!
Имя Твое всегда будет в сердце моем.
Я верю в Тебя!', 'Куплет 1:
D Hm
G A D
D Hm
G A D
G
D
Hm
Hm D A
Куплет 2:
D Hm
G A D
D Hm
G A D
G
D
Hm
Hm D A
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=81 | photo=notion-youth-songbook | notionPageId=0908f372-f2b8-4852-88e1-4ec8011709f8 | notionChordPageId=dfe5f973-7603-423a-af9e-efc789140af5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0908f372f2b8485288e14ec8011709f8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как вожделенны'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=81%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как глубока Твоя любовь', 'Молодёжный сборник', NULL, 'Куплет 1:
Как глубока Твоя любовь,
И прощение – наш покров,
Ты – наш свет и наш покой,
Упование Бог святой.
Припев:
Твоя милость велика, Твоя правда высока,
Твоя сильная рука нас ведёт издалека
Дух Святой, дорогой,
Драгоценный Дух Святой,
Наполняй сердца славою Отца!
Дух Святой, дорогой,
Драгоценный Дух Святой,
Освещай и веди за Собой!', 'Куплет 1:
Em C
Am H7
Em G
Am H7
Припев:
C Em
C H7
Am D
G C
Am H7 Em E7
Am D
G C
Am H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=82 | photo=notion-youth-songbook | notionPageId=35ea72ae-290c-42bd-a4dc-7893b8391526 | notionChordPageId=051b1862-1405-464c-96e1-c855e08c0134 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/35ea72ae290c42bda4dc7893b8391526', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как глубока Твоя любовь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=82%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как олень стремится к водам', 'Молодёжный сборник', NULL, 'Куплет 1:
Как олень стремится к водам,
Так душа моя к Тебе.
Ты один желанье сердца;
Поклоняюсь я Тебе.
Припев:
Ты - мой щит, крепость Ты моя,
Пред Тобой склоняюсь я,
Ты - Один желанье сердца,
Поклоняюсь я Тебе.
Куплет 2:
Свет в ночи и источник жизни,
Это Ты - мой Бог Святой,
Словно путник иду к Отчизне,
Где найду душе покой.
Куплет 3:
Ты Один мне всего дороже,
Мой покой и жизнь моя,
Прославляю Тебя, мой Боже,
Всей душой любя Тебя.', 'Куплет 1:
C Em Am
F G C F G
C G Am
F G C
Припев:
Am F C
F Dm E
C Em Am
F G C
Куплет 2:
C Em Am
F G C F G
C G Am
F G C
Куплет 3:
C Em Am
F G C F G
C G Am
F G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=83 | photo=notion-youth-songbook | notionPageId=3f531f6f-3751-40cf-8209-c5eb82c98dcf | notionChordPageId=06a709db-8663-461f-92bd-249545d180ae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3f531f6f375140cf8209c5eb82c98dcf', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как олень стремится к водам'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=83%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как прекрасно все то, что Твое', 'Молодёжный сборник', NULL, 'Куплет 1:
Как прекрасно все то, что Твое,
Мне повсюду Твой слышится голос,
Ветром в листьях звенит и поет,
В сердце шепчет, как зреющий колос.
Эти горы, покрытые мхом,
Эти волны, покрытые пеной,
Этот берег с горячим песком,
Это солнце в бескрайней Вселенной.
Припев:
Боже мой, это Ты, это Ты;
Я с Тобою повсюду встречаюсь,
Когда рву мимоходом цветы,
Иль на чей-то поклон отвечаю.
Куплет 2:
Мне повсюду видна твоя кисть,
Твой резец и Твой почерк с размахом,
В детском взоре, что светел и чист,
И в цветущих на поле ромашках.
Это Ты нам даруешь друзей,
Это Ты научил нас трудиться,
Потому я хочу все сильней
И все чаще усердней молиться.
Куплет 3:
Это Ты меня петь научил,
Потому моя песнь не сполкает.
Это Ты в меня свет Свой пролил,
Он и в вечности не угасает.
Как прекрасно все то, что Твое,
Пред величьем Твоим я немею.
Это Ты мне, Спаситель, даешь
Все то доброе, что я имею.', 'Куплет 1:
Am
Dm
G
C E7
Am
Dm
F
E7
Припев:
Am
Dm
G
C E
Куплет 2:
Am
Dm
G
C E7
Am
Dm
F
E7
Куплет 3:
Am
Dm
G
C E7
Am
Dm
F
E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=84 | photo=notion-youth-songbook | notionPageId=4be82751-2886-41cc-95cc-628b88c41666 | notionChordPageId=85309b48-1a65-4b3e-ad93-f38076a1b855 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4be82751288641cc95cc628b88c41666', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как прекрасно все то, что Твое'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=84%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как сон уходят прочь года', 'Молодёжный сборник', NULL, 'Куплет 1:
Как сон уходят прочь года
Мне не забыть лица моих друзей
Несу в своих молитвах я
Их имена и на душе теплей
Припев:
Стрелки на часах, словно миг остановили
И ветер разлук тихо позвал в дальний путь
Будем вместе в небесах, а пока где б мы ни жили
Смотри не забудь, лица друзей не забудь
Куплет 2:
Скорбей так много на земле
В чуждых сердцах нет места для любви
Альбом листая в тишине
Прошу: “Господь, друзей моих храни”', 'Куплет 1:
Cm Gm
Fm G#
Cm Gm
Fm G#
Припев:
Cm Fm A# D#
Cm G#
Cm Fm A# D#
Cm G#
Куплет 2:
Cm Gm
Fm G#
Cm Gm
Fm G#', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=85 | photo=notion-youth-songbook | notionPageId=7346db90-6079-44d8-a8e3-40ccbd7ca1ea | notionChordPageId=3492c609-af18-4990-ba67-851ebc203768 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7346db90607944d8a8e340ccbd7ca1ea', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как сон уходят прочь года'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=85%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как часто мы блуждаем', 'Молодёжный сборник', NULL, 'Куплет 1:
Как часто мы блуждаем, и просто забываем,
Что миром правит суета
Порой в любовь играем, грехов не замечаем,
А в сердце боль и пустота.
Припев:
Приди к Иисусу и скажи:
"Я не могу так больше жить,
Я больше не хочу грешить,
Прости меня!"
Приди к Иисусу и поверь,
Что жизнь изменится теперь
И что святая кровь Христа спасет тебя.
Куплет 2:
Христос простит любого, Он исцелит больного
Наполнит сердце добротой
Любовь его святая живёт и побеждает,
Приносит радость и покой!', 'Куплет 1:
C Em A7
Dm
G E Am Dm
G C
Припев:
Dm G
C Am
Dm G
C
Dm G
C Am
Dm G C
Куплет 2:
C Em A7
Dm
G E Am Dm
G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=86 | photo=notion-youth-songbook | notionPageId=1c7a5276-75f4-4719-8429-b98a72f8a2e3 | notionChordPageId=8a2cda02-2f11-4802-a702-5c262b51ce38 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1c7a527675f447198429b98a72f8a2e3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как часто мы блуждаем'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=86%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Как-то получилось', 'Молодёжный сборник', NULL, 'Куплет 1:
Как-то получилось, что сошлись дороги,
Вовсе не похожи, но сошлись в одну.
Если вдруг в дороге грусть тебя встревожит.
Знай, что я с любовью руку протяну.
Припев:
Если вдруг несчастье на тебя нагрянет (а-а-а)
Если на ресницах заблестит слеза.
Знай, что сквозь туманы я с любовью гляну
Осторожно в самые глаза.
Куплет 2:
С другом можно плакать, можно и молиться,
С другом можно просто сидя помолчать,
Кто сказал, что с другом можно не считаться?
Друга первым делом нужно уважать.
Куплет 3:
Разве друга ищут, разве выбирают?
Друг к тебе приходит только невзначай.
Да и другом разве каждого считают?
Недруга от друга нужно отличать.
Куплет 4:
Лишь, Христос, с тобою другом станет близким.
Я ищу общенья в быстром беге дней.
Ты придешь, я знаю, и склонишься низко,
Скажешь нежно слово в утешенье мне.', 'Куплет 1:
Em Am
H7 Em
Em Am
D H7
Припев:
Em Am
D G
Em Am
H7 Em
Куплет 2:
Em Am
H7 Em
Em Am
D H7
Куплет 3:
Em Am
H7 Em
Em Am
D H7
Куплет 4:
Em Am
H7 Em
Em Am
D H7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=87 | photo=notion-youth-songbook | notionPageId=ae58ad4f-6c01-4e9b-a4ab-f203a9b40786 | notionChordPageId=484a0f6b-9ed8-4979-82ae-cb989bc1ccb6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ae58ad4f6c014e9ba4abf203a9b40786', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Как-то получилось'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=87%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кистью Творца', 'Молодёжный сборник', NULL, 'Куплет 1:
Кистью Творца созданы небеса,
Небо и земля созданы Его рукой.
Я благодарю Тебя, мой Господь,
Мой Господь и славлю я Тебя!
Припев:
Краски Твои созданы из любви,
И душа моя лишь живёт Тобой.
Мне подарил этот прекрасный мир,
Благодать Твоя, Господи, надо мной.
Куплет 2:
Кистью Творца созданы ты и я,
По образу Его, как венец творения.
Я благодарю Тебя, мой Господь,
Мой Господь и славлю я Тебя!
Куплет 3:
Мой Господь, тебе я хочу всегда служить!
Как ещё Тебя я могу благодарить?!
Я благодарю Тебя, мой Господь,
Мой Господь и славлю я Тебя!', 'Куплет 1:
C F G Am
F G
C F E
Am F G
Припев:
Am F Dm G
F G C
Am F Dm G
F G Am
Куплет 2:
C F G Am
F G
C F E
Am F G
Куплет 3:
C F G Am
F G
C F E
Am F G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=88 | photo=notion-youth-songbook | notionPageId=8d23a531-e808-423a-af11-9c49075cac64 | notionChordPageId=abb3dd25-d704-4423-9786-3fa0aeb791cd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8d23a531e808423aaf119c49075cac64', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кистью Творца'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=88%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда бушует жизнь', 'Молодёжный сборник', NULL, 'Куплет 1:
Когда бушует жизнь, огнем меня крестя,
Одно твержу всегда себе на память:
Зачем же унывать? - Имею я Христа,
Что может у меня Его отнять?
Зачем же унывать? - Имею я Христа,
Что может у меня Его отнять?
Куплет 2:
А если иногда уносят поезда
Друзей моих в далекую разлуку.
Зачем же унывать? - Имею я Христа,
Что может у меня Его отнять?
Зачем же унывать? - Имею я Христа,
Что может у меня Его отнять?
Куплет 3:
Я знаю, узок путь и тесны те врата,
Что нас ведут от смерти к жизни вечной.
Но мне ли унывать - имею я Христа,
Что может у меня Его отнять?
Но мне ли унывать - имею я Христа,
Что может у меня Его отнять?', 'Куплет 1:
Em Am
H7 Em
G D H7 Em
Am H7 E7
Am Am Em C
Am H7 Em
Куплет 2:
Em Am
H7 Em
G D H7 Em
Am H7 E7
Am Am Em C
Am H7 Em
Куплет 3:
Em Am
H7 Em
G D H7 Em
Am H7 E7
Am Am Em C
Am H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=89 | photo=notion-youth-songbook | notionPageId=27a4df2b-c294-44dd-88c8-b5aa91e09b52 | notionChordPageId=bdf06b8f-5b23-43af-b6a0-148d8b14de9c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/27a4df2bc29444dd88c8b5aa91e09b52', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда бушует жизнь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=89%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда в пути душа утомляется', 'Молодёжный сборник', NULL, 'Куплет 1:
Когда в пути душа утомляется
Под бременем борьбы и труда,
||: Спешу я в церковь, где не кончается
Источник мира, радости никогда. :||
Куплет 2:
Под звуки псалмов общего пения
Я умиляюсь сердцем до слёз.
||: Чрез проповедников откровения
Души касается нежно так Христос. :||
Куплет 3:
И если в сердце боль затаилась,
Кем огорчён иль ранен стрелой,
||: Кровью Христа, из ран что струилась,
Я исцелён и, счастлив, иду домой. :||
Куплет 4:
Мой милый друг, душою израненный,
Ты посетил молитвенный дом,
||: Прими спасенье в день этот памятный
И вместе с нами радостно в путь пойдём! :||', 'Куплет 1:
Am Dm E Am
Dm G C Am
Dm7 Gm C Am
Dm E Am A
Куплет 2:
Am Dm E Am
Dm G C Am
Dm7 Gm C Am
Dm E Am A
Куплет 3:
Am Dm E Am
Dm G C Am
Dm7 Gm C Am
Dm E Am A
Куплет 4:
Am Dm E Am
Dm G C Am
Dm7 Gm C Am
Dm E Am A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=90 | photo=notion-youth-songbook | notionPageId=8debf778-d8a6-4a8a-b07a-be8fb4f2037d | notionChordPageId=634aabd3-0447-4155-9448-e730583ece65 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8debf778d8a64a8ab07abe8fb4f2037d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда в пути душа утомляется'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=90%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда в Твои слова вникаю', 'Молодёжный сборник', NULL, 'Куплет 1:
Когда в Твои слова вникаю,
Христос, Спаситель дивный мой,
Тогда всё глубже понимаю,
Что без Тебя я – прах земной.
Ты есть Лоза моя святая,
А я – лишь веточка Твоя,
И сок для жизни получаю
Я, мой Спаситель, от Тебя.
Куплет 2:
Твой сок во мне всё оживляет,
Несёт мне радость и покой,
Душа так близко ощущает
Тебя, Господь, Спаситель Мой.
Когда ж случается порою,
Что разобщаюсь я с Тобой,
Тогда терзаюсь я душою,
Нарушен в сердце мир святой.
Куплет 3:
И потому моё желанье
В Тебе, Христос мой, пребывать,
Чтоб в жизни все мои деянья
Твоею силой совершать.
Ты для меня – Лоза святая,
А я – лишь веточка Твоя.
Твоими соками питаясь,
Дай пребывать в Тебе всегда.', 'Куплет 1:
Dm
A
Gm A
Dm D
A# C
F A Dm
Gm A
Dm A Dm
Куплет 2:
Dm
A
Gm A
Dm D
A# C
F A Dm
Gm A
Dm A Dm
Куплет 3:
Dm
A
Gm A
Dm D
A# C
F A Dm
Gm A
Dm A Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=91 | photo=notion-youth-songbook | notionPageId=8719feb2-b87d-4f7d-b4d6-0f3076fc64a7 | notionChordPageId=ad7ec627-0068-4c39-a692-4502456640d7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8719feb2b87d4f7db4d60f3076fc64a7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда в Твои слова вникаю'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=91%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда весенний ветерок', 'Молодёжный сборник', NULL, 'Куплет 1:
Когда весенний ветерок колышет радостно цветок,
Когда от розы аромат прольется на цветущий сад,
Тогда волнуются сердца, тогда волнуются сердца,
И славят Господа Творца, о да, Творца.
Припев:
//: Цветы полей, цветы полей,
Вас сотворил Сам Царь царей. ://
Куплет 2:
Он орошает луг ручьем, головку лилии - росой,
А рощу дальнюю - дождем и шлет луч солнца золотой.
Не падай духом в скорби, друг, не падай духом в скорби, друг,
Ведь близок Бог, смотри вокруг, смотри вокруг.
Куплет 3:
Краса цветов - лишь до поры, зной сушит зелени ковры,
Цветы завянут, но наш Бог пребудет с нами средь тревог.
Зимой, в метель, в глухую ночь, зимой, в метель, в глухую ночь
Мы прославляем Божью мощь, да Божью мощь.', 'Куплет 1:
Em A D Hm
Em A D D7
Em A D Hm
Em A D D7
Припев:
Em A D Hm
Em D D7
Куплет 2:
Em A D Hm
Em A D D7
Em A D Hm
Em A D D7
Куплет 3:
Em A D Hm
Em A D D7
Em A D Hm
Em A D D7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=92 | photo=notion-youth-songbook | notionPageId=596ace4b-cf7c-4a74-82a3-f3ccca7ba6f7 | notionChordPageId=3e7337ef-a243-41fe-b0f7-679ebdb869d8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/596ace4bcf7c4a7482a3f3ccca7ba6f7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда весенний ветерок'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=92%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда смолкнет всё', 'Молодёжный сборник', NULL, 'Куплет 1:
Когда смолкнет всё, в тиши утонет звук,
Я к Тебе приду.
Принести хочу, из сердца моего
Нежную хвалу.
Припев:
Тебе я песню спою, Но не просто, чтоб спеть,
Ведь Ты не этого ждешь.
Ты видишь мысли мои, Ничего мне не скрыть,
Ты смотришь в сердце моё.
Я возвращаюсь к сердцу поклоненья,
Поклоненья Тебе, только Тебе, Иисус.
Прости, что я допустил сомненья,
Но теперь для Тебя, всё для Тебя, Иисус.
Куплет 2:
Драгоценный Царь, не выразить в словах
Чего достоин Ты.
Беден я и нищ, и все, что есть -Твоё,
Даже просто вздох.', 'Куплет 1:
D A Em
Em A
D A Em
A
Припев:
Em D A Em
Em D A Em
Em D A Em
Em D A Em
D A
Em G A D
D A
Em G A D
Куплет 2:
D A Em
Em A
D A Em
A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=93 | photo=notion-youth-songbook | notionPageId=7d9a51e4-4f2b-4e8f-a7d9-3d4fd0c3d865 | notionChordPageId=e03188ed-d565-4e38-bfa5-69ef220b040e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7d9a51e44f2b4e8fa7d93d4fd0c3d865', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда смолкнет всё'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=93%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Когда Христос меня простил', 'Молодёжный сборник', NULL, 'Куплет 1:
Когда Христос меня простил,
Мне землю в небо превратил;
Среди скорбей, борьбы земной
Там небо, где Христос со мной.
Припев:
Хвала Христу! Он спас меня,
Простил грехи, открыл Себя!
На суше, в море, над землей -
Там небо, где Христос со мной.
Куплет 2:
Небесный мир мне был далек,
Меня Христос к нему привлек,
Вошел Спаситель в жизнь мою,
С тех пор о Нем всегда пою.
Куплет 3:
Не важно, где теперь живу:
На высоте, внизу, во рву,
В стране родной, в стране чужой,-
Там небо, где Христос со мной.', 'Куплет 1:
C
Am
Dm
G E7
Припев:
Am Dm
G C E7
Am Dm
F E7 Am
Куплет 2:
C
Am
Dm
G E7
Куплет 3:
C
Am
Dm
G E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=94 | photo=notion-youth-songbook | notionPageId=f853a9a9-da34-4dfd-b103-7f39fc9aff34 | notionChordPageId=44e22363-c680-4349-a39e-117a4a2bfb67 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f853a9a9da344dfdb1037f39fc9aff34', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Когда Христос меня простил'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=94%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Косари на лугу', 'Молодёжный сборник', NULL, 'Куплет 1:
Косари на лугу размахалися острыми косами,
Что им Божий цветок, им бы кончить работу свою.
Я на милость Твою уповаю, Спаситель мой, Господи,
На милость, на милость, лишь только на милость Твою.
Куплет 2:
Только вера в Тебя, вот моя неизменная спутница.
Вера в то, что Ты всем управляешь Своею рукой.
И я знаю, Господь, что всегда за меня Ты заступишься,
И спасительным камнем Ты станешь пред острой косой.
Куплет 3:
А иначе, зачем Ты поил меня дивными росами?
Для чего показал мне любовь и Свою теплоту?
Для чего Ты наполнил меня чудо песнями, Господи?
Неужель для того, чтобы бросить под ноги скоту?
Куплет 4:
Косари на лугу отмахалися острыми косами,
Завершён сенокос, ну а я невредимым стою,
И как в прежние дни, упиваясь небесными росами,
Прославляю Тебя за любовь и за милость Твою.', 'Куплет 1:
Gm Cm
Gm D Gm
Cm Gm
Dm Gm
Куплет 2:
Gm Cm
Gm D Gm
Cm Gm
Dm Gm
Куплет 3:
Gm Cm
Gm D Gm
Cm Gm
Dm Gm
Куплет 4:
Gm Cm
Gm D Gm
Cm Gm
Dm Gm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=95 | photo=notion-youth-songbook | notionPageId=959ed66e-cce4-4cd3-8d5a-f21a5ee25aee | notionChordPageId=956903af-137d-47c4-9a34-db32bbbc0911 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/959ed66ecce44cd38d5af21a5ee25aee', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Косари на лугу'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=95%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Крылья зари', 'Молодёжный сборник', NULL, 'Куплет 1:
Господи, Ты испытал меня
И знаешь когда я сажусь,
Когда встаю, иду я, или отдыхаю
Тебе известны мои пути,
Еще нет слова на языке,
Его уже, Ты, Боже, знаешь совершенно
Припев:
Куда от Тебя я пойду? От Твоего лица не скроюсь,
На небо взойду – Ты там, сойду в глубины ада,
Возьму ли я крылья зари, переселюсь на край моря –
И там поведет меня Твоя милость
Куплет 2:
Скажу ли: «Может тьма меня сокроет,
И светлый день превратится в ночь?»
Но ночь – как день, и тьма – как свет перед Тобою.
Славлю Тебя, все дела Твои дивны
И веденье Твое мне не постичь,
Как высоки Твои все, Боже, помышления', 'Куплет 1:
Em
Em
Em D Em
Em
Em
Em D Em
Припев:
Em C G Am Em
Em C Am H
Em C G Am Em
Em C Am H Em
Куплет 2:
Em
Em
Em D Em
Em
Em
Em D Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=96 | photo=notion-youth-songbook | notionPageId=805fe242-4406-4dd5-b54a-1e2b540c8c21 | notionChordPageId=1c421e05-8edf-4328-9c03-93c3aedae3f4 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/805fe24244064dd5b54a1e2b540c8c21', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Крылья зари'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=96%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто бы дал мне слезы сокрушенья', 'Молодёжный сборник', NULL, 'Куплет 1:
Кто бы дал мне слезы сокрушенья,
Плакал бы я день и ночь.
Где найти для сердца утешенье,
Все сомненья б улетели прочь.
Куплет 2:
Льются слезы у царя Давида,
Разве мало серебра?
Но я плачу, потому что вижу:
Дух Святой уходит от меня.
Куплет 3:
Кто бы дал мне слезы, как
Мария Плакала у ног Христа,
И слезами их она омыла,
Для души отраду там нашла.
Куплет 4:
Кто бы дал мне слезы раскаянья,
Что лились из глаз Петра!
Тяжкую вину его омыли,
Грех и горе отречения.
Куплет 5:
Посмотри на слезы Иисуса,
Что лились из глаз тогда
За спасенье Иерусалима
И за грех ожесточения.
Куплет 6:
Боже, дай мне слезы таковые,
Чтобы был услышан я,
Чтобы я не плакал за дверями,
Где слеза уж больше не нужна.', 'Куплет 1:
Gm D7 Gm
A# F A#
Cm D7 Gm
D7 A Gm
Куплет 2:
Gm D7 Gm
A# F A#
Cm D7 Gm
D7 A Gm
Куплет 3:
Gm D7 Gm
A# F A#
Cm D7 Gm
D7 A Gm
Куплет 4:
Gm D7 Gm
A# F A#
Cm D7 Gm
D7 A Gm
Куплет 5:
Gm D7 Gm
A# F A#
Cm D7 Gm
D7 A Gm
Куплет 6:
Gm D7 Gm
A# F A#
Cm D7 Gm
D7 A Gm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=97 | photo=notion-youth-songbook | notionPageId=c7cd5991-e6f8-4010-a124-f3fb2e28dab7 | notionChordPageId=289d433a-de7a-4b78-972d-fef87e75ab46 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c7cd5991e6f84010a124f3fb2e28dab7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто бы дал мне слезы сокрушенья'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=97%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто есть на небе у меня?', 'Молодёжный сборник', NULL, 'Куплет 1:
Кто есть на небе у меня? Только Ты!
А в жизни только песнь моя: Мой Христос.
||: Он за меня в горниле был,
Меня Он кровью искупил
И душу с Богом примирил - Мой Христос! :||
Куплет 2:
Не милы мне богатств дары - Только Ты!
Я не хочу их мишуры - Мой Христос!
||: Мир вечного нам не даёт,
Все тленья облик в нем несёт,
Моя же радость не пройдёт - Мой Христос! :||
Куплет 3:
Хотя б я бедным плотью стал - Только Ты!
Он знает лучше! - я б сказал - Мой Христос!
||: Пусть в винограднике беда,
И пусть маслины без плода,
И пусть бичует мор стада - Мой Христос! :||
Куплет 4:
Хоть я среди вражды, огня - Только Ты!
И осаждает грех меня - Мой Христос!
||: Хоть мир готовит грозный бой,
Хоть все враги идут войной,
Я в Нем силен - прорву их строй - Мой Христос! :||
Куплет 5:
Когда ж расстанусь я с землёй - Только Ты!
В Его руках найду покой - Мой Христос!
||: Когда мне скорби дух стеснят,
Природы силы замолчат,
Я буду петь сквозь смерти яд: Мой Христос! :||', 'Куплет 1:
Em Am C H7
Em Am C H7
E7 Am D
G Em
Am H7 Em E
Куплет 2:
Em Am C H7
Em Am C H7
E7 Am D
G Em
Am H7 Em E
Куплет 3:
Em Am C H7
Em Am C H7
E7 Am D
G Em
Am H7 Em E
Куплет 4:
Em Am C H7
Em Am C H7
E7 Am D
G Em
Am H7 Em E
Куплет 5:
Em Am C H7
Em Am C H7
E7 Am D
G Em
Am H7 Em E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=98 | photo=notion-youth-songbook | notionPageId=9b33e469-2286-4527-95ad-32d10276884f | notionChordPageId=c2c656b6-5b04-4b31-8b47-148fc2298820 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9b33e4692286452795ad32d10276884f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто есть на небе у меня?'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=98%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто же я', 'Молодёжный сборник', NULL, 'Куплет 1:
Кто же я, что Царя Вселенной всей
Волнует боль моя и мир в душе моей?
Кто же я, что чудесный Божий свет
Ведет меня всегда, когда мира в сердце нет?
Припев:
Не за то, что сделал я, но по милости Твоей.
Не за все мои дела Ты любовь даруешь мне.
Я - лишь цветок, что расцветает и мгновенно увядает.
Пришел в мир и исчезну, как утренний туман.
Но Ты мольбам моим внимаешь. Если упаду, прощаешь.
Ты сказал мне, что я Твой, навсегда, навсегда.
Куплет 2:
Кто же я, что Всевидящий Господь,
Простив мои грехи, дарует мне любовь?
Кто же я, чтобы Бог, смиривший шторм,
Дарил мне Свой покой, когда вокруг лишь зло?', 'Куплет 1:
G Em
D C D C D
G Em
D C D C D
Припев:
C D Em D
Em D C D
G Em D C
D C D
G Em D C
D C G C Em D
Куплет 2:
G Em
D C D C D
G Em
D C D C D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=99 | photo=notion-youth-songbook | notionPageId=0a9d92ed-c6ad-4daa-9c61-1f33ed9bc666 | notionChordPageId=80d24c8f-4504-431b-a144-367f90353d58 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0a9d92edc6ad4daa9c611f33ed9bc666', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто же я'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=99%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто из царей', 'Молодёжный сборник', NULL, 'Куплет 1:
Идя за звездой в чужие края
Мы так ожидали увидеть Царя
Но не младенца…
Слабый и малый завёрнутый в плед
Герой подаривший надежду и свет
Мы ждали Спасителя Тот что нас сможет спасти!
Припев:
Но Кто из царей покинет свой трон?
Кто из господ оставит свой дом?
Кто из великих сойдет с высоты до меня?
Кто из богов откроет сердца
Миру который блуждает впотьмах
Кто из отцов сына отдаст за меня?
Куплет 2:
Свой дар для младенца Христа принесем
Славу и честь как царю вознесем
Мы ждали Его!
Ладан Священнику злато Царю
И смирну несущему жизнь ко кресту
Мы верим Он Тот, Кого мы так ждали давно!', 'Куплет 1:
A
F#m
Hm
A
F#m
Hm E
Припев:
A
F#m
Hm E
A
F#m
Hm E
Куплет 2:
A
F#m
Hm
A
F#m
Hm E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=100 | photo=notion-youth-songbook | notionPageId=f28dacd5-5b98-4f02-b329-237f1b379241 | notionChordPageId=f4a80128-d732-40d1-b270-8d07eb9b5bab | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f28dacd55b984f02b329237f1b379241', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто из царей'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=100%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Кто я без Тебя', 'Молодёжный сборник', NULL, 'Куплет 1:
Хочу я жить под кровом Твоим,
Тонуть в Твоей великой любви,
Смотреть лишь на Тебя.
Лицо Своё яви, наполни весь мой мир.
Припев:
Мой Господь, лишь только Тобой дышу я,
Словом Твоим живу я. Кто я без Тебя?
Мой океан, в Твоей любви тону я,
И сердце моё ликует: «Иисус, Ты жизнь моя!
Иисус, Ты жизнь моя!»
Куплет 2:
Ты всё, что нужно в жизни моей.
Меня наполни славой Своей.
Я светом быть хочу
И в небеса лечу, чтоб ближе быть к Тебе
Куплет 3:
Мой каждый шаг всё ближе к Тебе.
Твоя любовь так манит к Себе.
Всё то, что есть во мне,
И всё, чем я живу, принадлежит Тебе.', 'Куплет 1:
C F
C F
Am C F
C Dm C Gsus G
Припев:
Dm E7
Am G F
Dm E7
Am G F
E
Куплет 2:
C F
C F
Am C F
C Dm C Gsus G
Куплет 3:
C F
C F
Am C F
C Dm C Gsus G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=101 | photo=notion-youth-songbook | notionPageId=7455ae64-42ed-41d4-9e5b-adc1e5634c0e | notionChordPageId=47b1f592-14ae-47a8-8d26-f4bcf495fc4a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7455ae6442ed41d49e5badc1e5634c0e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Кто я без Тебя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=101%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Куда б мы ни ехали', 'Молодёжный сборник', NULL, 'Куплет 1:
Куда б мы ни ехали, куда б ни бежали,
Везде есть проблемы, везде есть печали…
А все потому, чтоб мы понимали -
Мы здесь ненадолго, мы жители рая!
Припев:
||: Так может, потому и приходят печали,
Чтобы мы с тобой о небе скучали,
Чтобы всей душой стремились в небеса
Куда не постучится больше беда. :||
Куплет 2:
Когда есть проблемы, когда есть печали…
Мы в громкой молитве к Иисусу взываем:
Гряди же скорей! Мы Тебя ожидаем!
Возьми нас к Себе, где не будет печали!
Припев:
||: Так может, потому и приходят печали,
Чтобы мы с тобой о небе скучали,
Чтобы всей душой стремились в небеса
Куда не постучится больше беда. :|| Больше беда.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=102 | photo=notion-youth-songbook | notionPageId=4b9a8ff4-24bf-4fc6-a363-6a207efe645a | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/4b9a8ff424bf4fc6a3636a207efe645a | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Куда б мы ни ехали'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=102%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Куда мы идем', 'Молодёжный сборник', NULL, 'Куплет 1:
Куда мы идем, только Он знает.
Падает снег, но Он растает.
Жизнь скоро пройдет, а за ней вечность.
Что нас всех ждет? Нас ждет бесконечность.
Припев:
Бесконечный ад, бесконечный рай.
Надо выбирать, надо выбирать.
Скоро жизнь пройдет, скоро жизнь пройдет
Что тебя там ждет, что тебя там ждет?
Куплет 2:
Жизнь это тест, тест на пригодность.
Вечность летать или вечность ползать,
Вечность любви без всяких сомнений,
Вечность в огне средь слез и мученья.
Куплет 3:
Божья любовь она бесконечна.
Пролита кровь, чтоб мы жили вечно.
Выбери жизнь, выбери счастье.
Крест свой нести сквозь бури, ненастья.', 'Куплет 1:
D A Hm G
D A Hm G
D A Hm G
D A Hm G
Припев:
Hm G D A
Hm G D A
Hm G D A
Hm G D A
Куплет 2:
D A Hm G
D A Hm G
D A Hm G
D A Hm G
Куплет 3:
D A Hm G
D A Hm G
D A Hm G
D A Hm G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=103 | photo=notion-youth-songbook | notionPageId=f751b98b-8c4d-4508-9d80-cb277bfcb2c8 | notionChordPageId=c932ccf2-242b-4f55-a180-365f81e37be9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f751b98b8c4d45089d80cb277bfcb2c8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Куда мы идем'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=103%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Лети', 'Молодёжный сборник', NULL, 'Куплет 1:
Каждый день смотрю на небеса
Ожидая Твой ответ внутри
Дал мне крылья словно паруса
Сказал лети
Припев:
Я знаю точно Ты со мной
С Тобою всё пройду Бог мой
Сквозь бури, ветер, ураган
Лечу в Твой покой
От бренных дел и суеты
От темноты и пустоты
Веди меня в Свой чудный свет
Бог мой
Куплет 2:
Я как почва Ты моя роса
Живою водою напои
Покажи мне снова чудеса
Скажи лети', 'Куплет 1:
F G Am
F G Dm
F G Am
F E
Припев:
Am F
C G
Am F
C E
Am F
C G
Am F
F F E
Куплет 2:
F G Am
F G Dm
F G Am
F E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=104 | photo=notion-youth-songbook | notionPageId=3d15e3cc-a2f3-41fb-a240-cd66d75d097d | notionChordPageId=ed356e62-d658-41ed-b4a0-cc1081ef573c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3d15e3cca2f341fba240cd66d75d097d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Лети'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=104%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Льются слёзы печали', 'Молодёжный сборник', NULL, 'Куплет 1:
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
Припев:
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
Куплет 2:
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
Куплет 3:
Я в восторге сердечном
Пред Христом преклоняюсь
Он вручил мне с любовью
Драгоценнейший дар.
Благодатью Христовой
От греха я спасаюсь
Его царства святого
Я наследником стал.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=105 | photo=notion-youth-songbook | notionPageId=f512fd68-5c85-4075-b74f-a8e6caa926fd | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/f512fd685c854075b74fa8e6caa926fd | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Льются слёзы печали'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=105%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Люби...', 'Молодёжный сборник', NULL, 'Куплет 1:
Люби, когда другой тебя толкает,
Люби, когда другой не понимает,
Люби, когда другой тебя подводит,
Люби, когда другой тебя обходит.
Припев:
Моя любовь в словах границ не знает,
Но жаль, на свете нету громких слов,
Любовь Христа на деле отражает,
Что Бог один есть вечная любовь.
(Что Бог один есть вечная любовь.)
Куплет 2:
Люби, когда увидишь лицемерье,
Люби, когда заметишь недоверье,
Люби, когда фальшивость в сердце встретишь,
Люби, когда любовь Ты не приметишь.
Куплет 3:
Люби – и ты не будешь лицемерить,
Люби – и ты поймёшь, как всё доверить,
Люби – пусть сердце Бога отражает,
Люби – любовь любовью отвечает.', 'Куплет 1:
Em
C
Am
D H
Припев:
Am D
G Em
Am H
Em E
Em H Em
Куплет 2:
Em
C
Am
D H
Куплет 3:
Em
C
Am
D H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=106 | photo=notion-youth-songbook | notionPageId=9e83418b-a755-4e8c-9de7-9dfc438faf28 | notionChordPageId=e81368b3-7f28-419a-b57b-57cc81b48cc8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9e83418ba7554e8c9de79dfc438faf28', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Люби...'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=106%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любит Иисус меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Любит Иисус меня, любит меня,
Песня об этом пусть будет моя.
И не скрываю я, пусть знают все:
Любит Иисус меня, Его люблю я!
Припев:
Он любит меня, Его люблю я,
Чудесная дружба с Ним у меня.
Всегда и везде мне с Ним хорошо,
Он близок в беде, Он рядом со мной.
(Он близок в беде, Он рядом со мной.)
Куплет 2:
Вечная радость Иисусу служить,
И в этом мире с Ним вместе жить.
Мир предлагает мне дружбу свою,
Но говорю я: нет! И песню пою.
Куплет 3:
Друг, подойди к Христу, сердце открой,
Руку отдай свою в руку Его.
Вечную радость ты обретешь
И песню новую с Ним запоешь.', 'Куплет 1:
D Em
A D
D Em
A D D7
Припев:
Em A
D Hm
Em A
D D7
D A D
Куплет 2:
D Em
A D
D Em
A D D7
Куплет 3:
D Em
A D
D Em
A D D7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=107 | photo=notion-youth-songbook | notionPageId=0a5a9e84-2d57-4dbb-b9fd-5b790f223b2e | notionChordPageId=3fc8d47c-ae6d-43e6-9222-4d7c8d483337 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0a5a9e842d574dbbb9fd5b790f223b2e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любит Иисус меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=107%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любовь - Евангельское слово', 'Молодёжный сборник', NULL, 'Куплет 1:
Любовь - Евангельское слово
Превыше всех на свете слов!
Оно - основа всех основ,
Оно весь мир спасти готово
Любовь - Евангельское слово!
Куплет 2:
Оно ни кем не сокрушимо
Твердыня вечная Христа.
В нем жизни свет и красота,
Оно лишь сердцем постижимо
Твердыня вечная Христа.
Куплет 3:
Как много надо умаляться,
Чтоб Cлово это приобресть.
Оно несет Благую весть,
И сердце хочет умилятся
Оно несет благую весть.
Куплет 4:
В нем тайна жизни боготворной,
В нем корень всех на свете слов,
В нем искупляющая кровь.
Любовь да будет не притворной
В нем тайна жизни боготворной.', 'Куплет 1:
C#m A E H7
C#m A H7
G#m A E
H7 C#m
A H7
Куплет 2:
C#m A E H7
C#m A H7
G#m A E
H7 C#m
A H7
Куплет 3:
C#m A E H7
C#m A H7
G#m A E
H7 C#m
A H7
Куплет 4:
C#m A E H7
C#m A H7
G#m A E
H7 C#m
A H7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=108 | photo=notion-youth-songbook | notionPageId=09da7197-572e-404a-be5a-066db2027166 | notionChordPageId=aa4306db-26a6-4665-bb52-e7cb46c283c5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/09da7197572e404abe5a066db2027166', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любовь - Евангельское слово'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=108%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любовь Христа верна и чиста', 'Молодёжный сборник', NULL, 'Куплет 1:
Мы каждый день встречаемся вновь
С прекрасным словом, словом “любовь”,
Мы каждый день за ней летим в мечтах своих,
Но настоящей любви, увы
Мы в этом мире не нашли,
На наш вопрос один ответ:
Любви без Бога нет.
Припев:
Любовь Христа верна и чиста,
Она и ласкова, и нежна,
Она объемлет всех людей
И покорит силой своей.
Держитесь этой вы любви,
Она вас к небу приведет,
Где Иисус спасенных ждет.
Куплет 2:
Но настоящая любовь
Приходит с синих облаков.
Её дарует вечный Бог, Творец миров.
Она несется и парит,
И каждый может получить
Без денег, злата, серебра
Любовь Христа.', 'Куплет 1:
Em
Am
H7 Em H7
Em
Am
H7
Em
Припев:
Em
Am
D
G H7
Em
Am
H7 Em
Куплет 2:
Em
Am
H7 Em H7
Em
Am
H7
Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=109 | photo=notion-youth-songbook | notionPageId=085692d9-b323-4bf6-9ad1-33cb2fb0d77f | notionChordPageId=aa4eac71-981f-46ec-b1fd-3fd94c4f5b23 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/085692d9b3234bf69ad133cb2fb0d77f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любовь Христа верна и чиста'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=109%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Любоў Хрыстова', 'Молодёжный сборник', NULL, 'Куплет 1:
Любоў Хрыстова! Яна, як сонца,
Што ззяе ў небе над усёй зямлёй.
Любоў Хрыстова! Што параўнацца
Змагло б у свеце з любоўю той?
Припев:
Любоў святая, любоў Хрыста,
Яна заўсёды са мной была,
Калi я падаў, пяшчотна падымала
I зноў да Неба мяне вяла.
Калi я падаў, пяшчотна падымала
I зноў да Неба мяне вяла.
Куплет 2:
Любоў Хрыстова! Там на Галгофе
Страдаў Збавiцель за грэшных нас.
Любоў Хрыстова! У пакутах цяжкiх
Ад страшнай долi Хрыстос нас спас.
Куплет 3:
Любоў Хрыстова, яна і сёння
Да сябе кліча, прыйдзі цяпер.
Прыйдзі да Ісуса, спяшайся хутка,
Пакуль адкрыта да Бога дзвер.', 'Куплет 1:
Em C
Am H7 Em H7
Em C
Am H7 Em E
Припев:
Am H7 Em
C D G
Am H7 Em
C D G
Am H7 Em
Am H7 Em
Куплет 2:
Em C
Am H7 Em H7
Em C
Am H7 Em E
Куплет 3:
Em C
Am H7 Em H7
Em C
Am H7 Em E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=110 | photo=notion-youth-songbook | notionPageId=31d04827-dc7e-4e48-b9e2-d0301b994fce | notionChordPageId=78dab9b4-1ce5-47ac-a4c6-9c1ed12a935b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/31d04827dc7e4e48b9e2d0301b994fce', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Любоў Хрыстова'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=110%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Люди ищут вокруг', 'Молодёжный сборник', NULL, 'Куплет 1:
Люди ищут вокруг днём и в полночь идут
Страх наполнил глаза что принесёт им судьба
С каждым днем жизнь идет одинаково всё
Стоит просто найти время к Богу прийти
Припев:
Помолится и склонится
Он откроет глаза это будет не зря
Суету брось поверь Богу
Он свободу даст
Куплет 2:
Каждый раз ты забыл к Богу снова прийти
Волноваться начнешь и в тупик вновь зайдешь
Только Бог может знать жизнь твою наперёд
Бог наш полон любви ты к Нему поспеши', 'Куплет 1:
Fm A#m D# G# C
Fm A#m C#7 C7
Fm A#m D# G# C
Fm A#m C#7 C7
Припев:
Cm A#m
D# G# C
Fm A#m
C#7 C7 Fm
Куплет 2:
Fm A#m D# G# C
Fm A#m C#7 C7
Fm A#m D# G# C
Fm A#m C#7 C7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=111 | photo=notion-youth-songbook | notionPageId=2c93ac07-50e9-4f83-ae56-77c2e25f67d1 | notionChordPageId=15350e0d-9d12-4465-90ea-0a59c03e9478 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2c93ac0750e94f83ae5677c2e25f67d1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Люди ищут вокруг'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=111%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Манит сердце мечтою', 'Молодёжный сборник', NULL, 'Куплет 1:
Манит сердце мечтою
Высь небес голубая -
Нашей общей мечтою
Стала вера живая.
Припев:
Он нас сделал родными,
Он нас сделал друзьями,
Дал нам новое имя -
Нас зовут христиане.
Куплет 2:
Иисус стал нам другом -
Мы на деле узнали:
Он врачует недуги,
Удаляет печали.
Куплет 3:
Он дарует прощенье,
Мир и счастье без меры
И второе рожденье,
Только истинно веруй.', 'Куплет 1:
Dm
Gm
A7
Dm
Припев:
D Gm
C F
Dm Gm
A7 Dm
Куплет 2:
Dm
Gm
A7
Dm
Куплет 3:
Dm
Gm
A7
Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=112 | photo=notion-youth-songbook | notionPageId=4722dbe8-a861-465c-adbc-9df5c1c19004 | notionChordPageId=0879f978-fc76-4930-9ff5-f3f21e4890f1 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4722dbe8a861465cadbc9df5c1c19004', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Манит сердце мечтою'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=112%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мария спешила скорей', 'Молодёжный сборник', NULL, 'Куплет 1:
Мария спешила скорей
В сиянье первых лучей
Увидеть во гробе Христа
В то утро она не смогла
Припев:
Потому что Он воскрес – это радость до небес
Это счастье и благая весть
Потому что Он воскрес – это радость до небес
Пусть летит над всей землей эта весть.
Куплет 2:
И в любящем сердце Петра
Звезда воскресенья взошла
Когда принесли ему весть
Те ангелы светлых небес
Куплет 3:
Расскажут об этом цветы
Споют голубые ручьи
Христос и сегодня живой
И снова Он рядом с тобой', 'Куплет 1:
G Em
C D
G E
Am D
Припев:
C D Hm E
Am D Gsus G
C D Hm E
Am D G
Куплет 2:
G Em
C D
G E
Am D
Куплет 3:
G Em
C D
G E
Am D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=113 | photo=notion-youth-songbook | notionPageId=aa530eb0-fc11-42ed-962e-88eb3e823995 | notionChordPageId=9968fdb4-7925-4589-818a-39beffe7f9ee | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/aa530eb0fc1142ed962e88eb3e823995', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мария спешила скорей'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=113%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Милости Твоей полна вся земля', 'Молодёжный сборник', NULL, 'Куплет 1:
Милости Твоей полна вся земля,
Милости Твоей полна жизнь моя,
Милость Свою Ты превознёс над судом,
Искупил меня и ввёл в Свой дом.
Припев:
Ты спас меня и оправдал, освободил от вины,
Ты спас меня и оправдал, освободил от вины,
Мост:
Благодарю Тебя,
Благодарю Тебя,', 'Куплет 1:
Em A A7
D Hm
Em F#
Hm A D
Припев:
Em A D Hm Em F# Hm
Em A D Hm Em F# Hm
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=114 | photo=notion-youth-songbook | notionPageId=bd1b6653-b08d-4d46-babd-4db0d7abedc4 | notionChordPageId=3cee34b7-09e9-4f4b-9214-db0c5a0284b4 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bd1b6653b08d4d46babd4db0d7abedc4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Милости Твоей полна вся земля'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=114%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Милость Божья', 'Молодёжный сборник', NULL, 'Куплет 1:
От погибели спасла меня милость Божья.
В рве отчаянья нашла меня милость Божья.
То, что я ещё живу, что я Господу служу, –
Это милость Божья, это милость Божья
Куплет 2:
Что грехи мои Он смыл – это милость Божья.
И Свой Дух Святой излил – это милость Божья.
То, что вера мне дана и ведёт меня она, –
Это милость Божья, это милость Божья
Куплет 3:
Вновь и вновь благодарю эту милость Божью
И желанием горю славить милость Божью,
Эту бездну доброты, эту силу чистоты –
Это милость Божья, это милость Божья
Куплет 4:
Всё однажды здесь пройдёт, даже милость Божья.
От земли Бог заберёт свою милость Божью.
Там, где место для святых, будет вечно им светить –
Это милость Божья, это милость Божья', 'Куплет 1:
Dm Gm
C A Dm D
Cm D
Gm A Dm D
Куплет 2:
Dm Gm
C A Dm D
Cm D
Gm A Dm D
Куплет 3:
Dm Gm
C A Dm D
Cm D
Gm A Dm D
Куплет 4:
Dm Gm
C A Dm D
Cm D
Gm A Dm D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=115 | photo=notion-youth-songbook | notionPageId=839d1652-dd17-4232-ada6-1718886f39cf | notionChordPageId=5b0d2a81-0409-4c7e-8e18-3a4c9a1547d5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/839d1652dd174232ada61718886f39cf', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Милость Божья'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=115%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мимо текла, текла река', 'Молодёжный сборник', NULL, 'Куплет 1:
Мимо текла, текла река, плыли куда-то облака,
Шёл человек, была дорога нелегка
И человек мечтал о том, чтобы построить себе дом
И поселится счастье в нём, в доме одном.
Куплет 2:
Часто бывало уставал, но неизменно напевал
Песню любимую свою, ту, что пою
Дом как известно всем давно, это не стены и окно
Даже и стулья со столом это не дом.
Куплет 3:
Дом - это там, куда готов ты возвращаться вновь и вновь,
Яростным, добрым, нежным, злым, еле живым
Дом - это там, где нас поймут, там, где надеются и ждут,
Там, где забудешь о плохом - это твой дом.
Куплет 4:
За облаками в вышине дом приготовлен вам и мне,
Дом приготовленный Отцом, чтобы жить в нём,
Но чтобы в этом доме жить, нужно в сердцах своих хранить
Мир и тепло, любовь и свет, вечный завет.', 'Куплет 1:
Dm Gm Dm
Gm C F D7
Gm F Dm
Gm A Dm D7
Куплет 2:
Dm Gm Dm
Gm C F D7
Gm F Dm
Gm A Dm D7
Куплет 3:
Dm Gm Dm
Gm C F D7
Gm F Dm
Gm A Dm D7
Куплет 4:
Dm Gm Dm
Gm C F D7
Gm F Dm
Gm A Dm D7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=116 | photo=notion-youth-songbook | notionPageId=5b8315eb-8637-48bc-aaa6-c7f4805d9692 | notionChordPageId=c484cb2d-aee1-44bf-b729-7990e0227677 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5b8315eb863748bcaaa6c7f4805d9692', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мимо текла, текла река'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=116%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мир вам', 'Молодёжный сборник', NULL, 'Куплет 1:
Мир вам, настал общения час,
Мир вам, и мы приветствуем вас,
Мир вам, пусть будет слышен смех детей,
Мир вам, и больше радостных дней.
Мир вам, сердца пусть будут добрей,
Мир вам, вы не судите людей,
Мир вам и вашим близким, и друзьям
Мир братья, сестры вам.
Припев:
Мир вам, братья, сестры, мир вам, так же просто
Вы говорите всем друзьям.
Мир вам, и с любовью счастья и здоровья,
Мир братья, сестры вам.
Куплет 2:
Мир вам, мы говорим в этот час,
Мир вам, Господь да будет средь вас.
Мир вам, пусть крепнет вера каждый час,
Мир вам, недуг оставит пусть вас.
Мир вам, огонь любви пусть горит,
Мир вам, пусть крепче дом ваш стоит,
Мир вам, конца не будет вашим дням,
Мир братья, сестры вам.', 'Куплет 1:
Hm Em F#
Hm Em A
D H7 Em
Em G F#
Hm Em F#
Hm Em A
D H7 Em
Em F# Hm
Припев:
Em Hm
Em A D H7
Em Hm
Em F# Hm
Куплет 2:
Hm Em F#
Hm Em A
D H7 Em
Em G F#
Hm Em F#
Hm Em A
D H7 Em
Em F# Hm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=117 | photo=notion-youth-songbook | notionPageId=d0b87b98-9968-4a0c-af1b-f2442ec20186 | notionChordPageId=62b4cd56-7af4-468b-92fe-30f66d4ef10a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d0b87b9899684a0caf1bf2442ec20186', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мир вам'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=117%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мне есть за что благодарить', 'Молодёжный сборник', NULL, 'Куплет 1:
Мне есть за что благодарить Творца -
Он снял с меня греховную проказу.
О, пусть теперь польется без конца
Хвала Ему в поэмах и рассказах.
Припев:
Вот почему мне хочется любить
Его сильней, и искренней, и чище.
Мне есть за что Христа благодарить –
Он мне купил небесное жилище.
Куплет 2:
Душа взывать к Отцу не устает,
Где падал я - прощение просил я.
Ведь Он в беде мне руку подаёт,
Ведь Он моё - прибежище и сила.
Куплет 3:
Всё от Него, и всё идёт к Нему,
Душа поёт небесным отголоском.
Придёт мой день - я ноги обниму
Того, Кто умер на кресте Голгофском.', 'Куплет 1:
Hm F#m Hm
Em F#7 Hm
Hm F#7 G
Em F#7 Hm
Припев:
Em F#7 Hm
Em A Am H7
Em F#7 Hm
G F#7 Hm
Куплет 2:
Hm F#m Hm
Em F#7 Hm
Hm F#7 G
Em F#7 Hm
Куплет 3:
Hm F#m Hm
Em F#7 Hm
Hm F#7 G
Em F#7 Hm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=118 | photo=notion-youth-songbook | notionPageId=e686c2cf-a797-47d2-a85e-ae90443349d3 | notionChordPageId=2f3ee12e-701a-406c-9ac1-19dff1c4a5e2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e686c2cfa79747d2a85eae90443349d3', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мне есть за что благодарить'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=118%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мне кажется завтра', 'Молодёжный сборник', NULL, 'Куплет 1:
Нам кажется, завтра мы будем прилежней
И лучше, полезней, добрей.
Сегодня мы грубы, а завтра мы нежны,
И завтра - мы будем мудрей.
Мы завтра проведаем старого друга
И завтра напишем письмо
И завтра окажем кому-то услугу
Не только своим и чужим.
Не только своим и чужим.
Припев:
Так в планах на завтра, что скрыто в тумане
За годом проносится год.
А что если завтра возьмет и обманет?
И завтра совсем не придет.
И завтра совсем не придет.
Куплет 2:
Мы завтра покаемся в жизни бесплодной
В последнем предсмертном бреду
Оденем раздетых, накормим голодных
Разделим чужую беду.
Мы завтра поймем, что такое Спасенье
И завтра пойдем за Христом
Мы завтра пред Богом падем на колени
Не ныне, а завтра, потом.
Не ныне, а завтра, потом.', 'Куплет 1:
C
Am
F Fm
G
C
Am
F Fm
G
F G C
Припев:
F G
Am
F Fm
G
F G C
Куплет 2:
C
Am
F Fm
G
C
Am
F Fm
G
F G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=119 | photo=notion-youth-songbook | notionPageId=818b46da-8b2c-4cda-bfb8-852f25fd05fc | notionChordPageId=72b5f6c8-8976-4127-a6e4-51ebac8300a5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/818b46da8b2c4cdabfb8852f25fd05fc', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мне кажется завтра'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=119%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Много лет прошло', 'Молодёжный сборник', NULL, 'Куплет 1:
Много лет прошло с времен Голгофы,
Но Христос оставил ее след,
А душа все задает вопросы –
Почему Христа распял ты, человек?
Но достоин смерти, наказанья
Был Варрава убийца и злодей
А Христос понес все поруганья
За что, скажите, за нас гибнущих людей?
Припев:
Я подошел к ногам Христа, вопросом мучая себя -
За что же, Бог мой, люди распяли Тебя?
А Он взглянул в мои глаза, любовью ласковой горя,
Сказал – «за то, сын Мой, что Я люблю тебя»
Куплет 2:
Вы спросите люди Вартимея
Как Христос открыл ему глаза,
Как вдове Он умершего сына
Возвратил из смертного одра?
Так за что же руки пригвоздили
Иисусу острием гвоздей,
Руки те, что всем добро творили
И как любили нежно ласкать детей.', 'Куплет 1:
Em Am
C H Em
G D H
Em Am H
Em Am
C H Em
G D H
Em Am H
Припев:
Am H Em D C
Am H Em E7
Am H Em D C
Am H7 Em
Куплет 2:
Em Am
C H Em
G D H
Em Am H
Em Am
C H Em
G D H
Em Am H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=120 | photo=notion-youth-songbook | notionPageId=8dbd4194-4d00-47be-8d1f-67ad6ead7f4a | notionChordPageId=711e4563-2420-4e6a-a225-7c5ebcb0b2ec | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8dbd41944d0047be8d1f67ad6ead7f4a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Много лет прошло'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=120%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Много лет учили тебя и меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Много лет учили тебя и меня:
Чтобы лодка жизни удачно плыла,
Главное - не бросить вёсла свои,
Но, Иисус, однажды открылся мне Ты.
Припев:
Ты мой белый парус, моя ладья,
Рассекая волны, плывёт в небеса.
Иисус мой парус, бросил вёсла я,
Ветер благодати влечёт меня.
Куплет 2:
Берега не видно, всё объяла мгла.
Яростные волны бьются о борта.
Вёсла переломаны, только надо мной
Всё такой же белый парус мой.
Куплет 3:
В нашей жизни вёсла - это дела,
Что без Бога сделали, чтоб спасти себя.
Спасенье приготовлено Богом моим,
Белым, белым парусом моим.', 'Куплет 1:
Am Dm
E Am E
Am Dm
Am E Am
Припев:
Am Dm G C
Am Dm E Am
Am Dm G C
Am Dm E Am
Куплет 2:
Am Dm
E Am E
Am Dm
Am E Am
Куплет 3:
Am Dm
E Am E
Am Dm
Am E Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=121 | photo=notion-youth-songbook | notionPageId=8536df5e-69fd-4e72-b768-a119bf69a1f9 | notionChordPageId=c0da7889-302f-4bc4-b518-bbd9d06808b0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8536df5e69fd4e72b768a119bf69a1f9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Много лет учили тебя и меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=121%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Много много километров', 'Молодёжный сборник', NULL, 'Куплет 1:
Много много километров земного пути
Через бури, через ветры предстоит пройти.
Нам светят в неба звезды, а мы роняем слезы,
Устаем мечтать, устаем идти
Припев:
Но надо быть верным, честным сильным, не бояться обид,
И не жалеть своих усилий чтобы грех победить
Иди смелей вперед, Господь тебя зовет
Поднять глаза на небеса
Куплет 2:
Время нас не ждет в дороге, торопит решать
Как забыть свои тревоги и сильнее стать
И снова светят звезды, а мы роняем слезы
Устаем идти, устаем мечтать', 'Куплет 1:
D Hm G A
D Hm G A
G A D Hm
G A
Припев:
D Hm G A
D Hm G A
G A D Hm
G A D
Куплет 2:
D Hm G A
D Hm G A
G A D Hm
G A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=122 | photo=notion-youth-songbook | notionPageId=53a99305-01b9-4f87-a971-89c12724b77b | notionChordPageId=54d723b6-7d5e-4319-acf1-d63a04fe6ed8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/53a9930501b94f87a97189c12724b77b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Много много километров'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=122%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мой Господь, в этот час', 'Молодёжный сборник', NULL, 'Куплет 1:
Мой Господь, в этот час я склоняюсь в мольбе,
И все нужды мои приношу я Тебе.
В жизни бурь и тревог Ты укроешь меня.
Путь весь знаешь, мой Бог, он не скрыт от Тебя.
Припев:
Ты, Господь, лишь Ты любовь моя,
Щит мой и Скала,
Лишь Ты моя защита и опора.
Ты, Господь, лишь Ты любовь моя,
В Тебе укроюсь я,
Ведь Ты моя защита и опора.
Куплет 2:
Не страшна мне с Тобой даже смертная тень,
Обрету я покой в небе в солнечный день.
Знаю, слёзы мои Ты с любовью отрёшь,
Все ошибки в пути Ты простишь и поймёшь.
Куплет 3:
А пока на земле буду славить Тебя,
Буду сердцем я петь, ожидая любя.
Знаю, скоро придёшь, скоро встречу Тебя,
Свою Церковь возьмёшь от скорбей и от зла.', 'Куплет 1:
Em C D H
Em C D H
Am H Em C
Am H Em H
Припев:
Em Am D
G C
Am H
Em Am D
G C
Am H
Куплет 2:
Em C D H
Em C D H
Am H Em C
Am H Em H
Куплет 3:
Em C D H
Em C D H
Am H Em C
Am H Em H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=123 | photo=notion-youth-songbook | notionPageId=6760712b-d2fc-4447-ac80-4164dc835bdd | notionChordPageId=8f33b773-49a6-412e-9f53-cee1179f537c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/6760712bd2fc4447ac804164dc835bdd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мой Господь, в этот час'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=123%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Молитва — это крик души', 'Молодёжный сборник', NULL, 'Куплет 1:
Молитва — это крик души, чем искренней, тем тише
И так легко когда в тиши, ее Господь услышит.
Она, как самый громкий плач, не пред людьми, пред Богом,
В надежде, что небесный врач, поможет нам во многом.
Припев:
Молитва- это Божий дар,
Одно из средств немногих,
Через нее и стар и мал,
Ведут беседу с Богом.
Куплет 2:
Она глоток живой воды, залог успешной битвы,
Она преграда от беды, постигшим суть молитвы.
Она орудие труда, она души блаженство,
Через нее везде, всегда, приходят к совершенству.
Куплет 3:
Но жаль молитва не для всех, убежище от бедствий,
Творивший постоянно грех, теряет это средство.
Как пустоцвет неверных чувств, она тогда бесплодна,
Лукавство, лесть из грешных уст, для Бога не угодны!', 'Куплет 1:
Em C Am H
Em C Am C H
Am D G C
Am Em Am H E
Припев:
E C#m
E H
E C#m
E H E
Куплет 2:
Em C Am H
Em C Am C H
Am D G C
Am Em Am H E
Куплет 3:
Em C Am H
Em C Am C H
Am D G C
Am Em Am H E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=124 | photo=notion-youth-songbook | notionPageId=820d8394-a34b-4e3d-9b9f-21ee605b9856 | notionChordPageId=f5eb307b-f013-46d9-9227-281e8ec414ea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/820d8394a34b4e3d9b9f21ee605b9856', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Молитва — это крик души'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=124%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Молодые', 'Молодёжный сборник', NULL, 'Куплет 1:
Молодые, вы рождённы для Бога жить,
Чтобы в мире Иисусу Христу служить;
Молодые, перед вами Господь идёт.
Он - надёжная опора и наш Друг во всём.
Припев:
Посвятим же Христу годы жизни нашей,
Отдавшись Ему до конца,
Ведь знаем все мы, что наградой нашей,
Будут небеса!
(Будут небеса!) – за вторым разом
Куплет 2:
В этом мире, где вокруг есть злоба и боль,
Молодые, вы должны быть как свет и соль,
Чтобы люди, увидав в вас Иисуса любовь,
Обернулись и вернулись блудным сыном домой.
Куплет 3:
Молодые, да хранит вас Господь во всём,
В этом мире, где вокруг есть злоба и боль!
Молодые, будьте верны Иисусу Христу,
Чтобы в мире этом лютом победить сатану.', 'Куплет 1:
Am Dm
G C E7
Am Dm
F Dm E7
Припев:
Dm G
C Am
Dm E7
Am
Dm E7 Am
Куплет 2:
Am Dm
G C E7
Am Dm
F Dm E7
Куплет 3:
Am Dm
G C E7
Am Dm
F Dm E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=125 | photo=notion-youth-songbook | notionPageId=9842986c-3fae-4eb6-9ac7-4e858679250f | notionChordPageId=86be5c09-12ba-4850-98b3-b8bcaacd19c8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9842986c3fae4eb69ac74e858679250f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Молодые'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=125%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Моя молитва да стремится', 'Молодёжный сборник', NULL, 'Куплет 1:
Моя молитва да стремится
К Тебе как-будто фимиам
И мое сердце обратится
В прекрасный Твой небесный храм
Припев:
Боже я молюсь заБеларусь!
Боже молю Тебя за людей
Ты их прости, Ты их спаси
И милость Свою нам яви
Боже я знаю, что Ты будешь с нами
В храме Своем под небесами
Радость и мир Ты даровал
И жизнь за людей отдал
И в Книгу Свою нас записал
Куплет 2:
Ты в Своем Слове обещаешь
Всем, кто Тебя ни призовет,
Что Ты услышишь в день печали
С души греховной снимешь гнет!
Куплет 3:
Пошли, Господь, нам силу свыше
Людей любить и звать к Тебе
Когда мы молимся – услышь нас
И помощь дай Свою с небес!', 'Куплет 1:
Em C
Am H7 Em
Em C
Am H7 Em
Припев:
D G D
Em H7
C D
Hm Em
D G D
Em H7
C D
H7 Em
C H7
Куплет 2:
Em C
Am H7 Em
Em C
Am H7 Em
Куплет 3:
Em C
Am H7 Em
Em C
Am H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=126 | photo=notion-youth-songbook | notionPageId=108b6f4e-245e-401c-a789-4e3817dcfa08 | notionChordPageId=4de00650-657f-4805-8756-32424d9bb6e2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/108b6f4e245e401ca7894e3817dcfa08', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Моя молитва да стремится'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=126%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мы – лишь мгновенье', 'Молодёжный сборник', NULL, 'Куплет 1:
Мы – лишь мгновенье, Ты – сама вечность
Мира Создатель, Царь всех сердец.
Мы – дуновенье, Ты – бесконечность
Жизни податель, Бог и Отец.
Припев:
Святый, святый Бог вседержитель
Славен в небе и не земле
Честь, хвалу, Господь и Спаситель
Воздаем Тебе, воздаем Тебе!
Куплет 2:
В трудностях наших Ты подкрепляешь
Верный и сильный, чтобы спасать.
Слабых упавших Ты поднимаешь,
Даришь обильно нам благодать.', 'Куплет 1:
C G Dm Am
F C A# G
C G Dm Am
F C A# G
Припев:
Am F C G
Am F C G
Am F C G
Dm Am G Dm Am G
Куплет 2:
C G Dm Am
F C A# G
C G Dm Am
F C A# G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=127 | photo=notion-youth-songbook | notionPageId=8a626bb8-da3f-412e-bd66-062313494097 | notionChordPageId=b4f15d48-8526-441d-afb6-c7c7b053f8e4 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8a626bb8da3f412ebd66062313494097', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мы – лишь мгновенье'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=127%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Мы нужны друг другу', 'Молодёжный сборник', NULL, 'Куплет 1:
Мы нужны друг другу, Бог нас спас не зря,
Чтобы с тобою были мы друзья.
Так давай служить теперь ты мне, а я тебе,
Чтоб Царство Божье было на земле.
Припев:
Мы – одна семья, мы – одна семья,
Пролилась за нас Иисуса кровь.
Мы теперь друзья, мы теперь друзья,
И в сердцах у нас Его любовь.
Куплет 2:
Мы нужны друг другу Бог нас спас не зря
В Царство Божье мы идем, друзья.
Так давайте сохраним мы веру на земле,
Чтоб царствовать нам с Богом во Христе!', 'Куплет 1:
F C Dm
A# C F C
F C Dm
A# C F
Припев:
A# C Am Dm
A# C F
A# C Am Dm
A# C F
Куплет 2:
F C Dm
A# C F C
F C Dm
A# C F', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=128 | photo=notion-youth-songbook | notionPageId=52af40bc-a24f-4013-bb0f-3a2c2d35946a | notionChordPageId=7be2980c-5349-4114-bd20-7f88d8b1eaf3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/52af40bca24f4013bb0f3a2c2d35946a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Мы нужны друг другу'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=128%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'На всяком месте', 'Молодёжный сборник', NULL, 'Куплет 1:
На всяком месте до краёв земли
Я знаю Ты всегда со мной.
И каждый раз звучат слова Твои:
«Ведь я люблю тебя давно!»
Ты заповедал сердцу свято жить,
Мне помогая на пути.
На все обетования Твои
Надеюсь, чтобы вечно жить.
Припев:
Я Тебя жду день за днём,
Солнечным утром, в лунной ночи.
Слиться с Тобою всей душой
И пребывать в святой любви.
Куплет 2:
Мне нравится внимать Твоим Словам -
Они животворят меня.
К ногам Твоим склоняться жажду я
И их слезами умывать.
Ты что-то изменил в моей душе,
Призвав меня познать Тебя
И заключив со мной в Крови ЗАВЕТ,
Чтоб жить с Тобою в небесах!
Куплет 3:
Вознёсся в славе, чтоб опять прийти,
Свершить спасенье всей Земли.
Тогда узрят Тебя глаза мои
И Дух возрадуется мой.
Ты новый Город создал для меня
И там уже не будет слёз;
И жизнь моя рекою потечёт,
Там солнцем будет Сам Христос!', 'Куплет 1:
G Em
C D
Hm Em
C D G
G Em
C D
Hm Em
C D G
Припев:
C D
G Em
C G
C D G
Куплет 2:
G Em
C D
Hm Em
C D G
G Em
C D
Hm Em
C D G
Куплет 3:
G Em
C D
Hm Em
C D G
G Em
C D
Hm Em
C D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=129 | photo=notion-youth-songbook | notionPageId=df2ac51d-54cf-41cd-bc79-d6cd6758e13b | notionChordPageId=a6353397-bc53-45fb-8fdf-06bc2655652e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/df2ac51d54cf41cdbc79d6cd6758e13b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'На всяком месте'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=129%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'На Тебя мы уповаем', 'Молодёжный сборник', NULL, 'Куплет 1:
Наша надежда - Ты Христос.
Ты наше счастье, наша любовь,
Ты наша радость, Ты наша жизнь.
Ведь Ты нас любишь и хранишь!
Припев:
На Тебя мы уповаем, на Тебя жизнь полагаем,
На Тебя взор устремляем, ввысь, в небеса.
Куплет 2:
Ты пострадал за нас, Христос,
Ты на кресте пролил Свою Кровь.
Ты нам спасенье ныне принёс,
Ты нас избавил от горя и слёз.', 'Куплет 1:
Dm F C
A Dm
Dm F C
Gm A A7
Припев:
Gm Dm
A Dm D7
Куплет 2:
Dm F C
A Dm
Dm F C
Gm A A7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=130 | photo=notion-youth-songbook | notionPageId=dd1f40a0-db09-43b3-b071-be5afb61e341 | notionChordPageId=73213b9e-d8be-4ddb-a58e-b7ee09b7047a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/dd1f40a0db0943b3b071be5afb61e341', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'На Тебя мы уповаем'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=130%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'На Христа взирая', 'Молодёжный сборник', NULL, 'Куплет 1:
На Христа взирая, жизнь Ему отдай,
Грешных призывая, даст им рай.
За тебя страдая, взял Он грех твой Сам,
На Христа взирая, верь словам.
Припев:
Взгляд не своди с Иисуса ты,
Будет он ночью-днём Вождём.
Взгляд не своди с Иисуса ты,
Он наш Вождь.
Куплет 2:
На Христа взирая, в бой за Ним вступай,
Будет битва злая, ты не унывай.
Пусть душа больная слаба пред врагом,
На Христа смотря, победа в Нём.
Куплет 3:
На Христа взирая, труд свершай ты свой,
И свой день кончая, в Нём найдёшь покой.
И рука святая приготовит пир,
На Христа взирая, в Нём твой мир.', 'Куплет 1:
Em Hm C G
Am F#m H
Em Hm C G
Am F#m H
Припев:
Am D G C
Am H Em
Am D G C
Am H
Куплет 2:
Em Hm C G
Am F#m H
Em Hm C G
Am F#m H
Куплет 3:
Em Hm C G
Am F#m H
Em Hm C G
Am F#m H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=131 | photo=notion-youth-songbook | notionPageId=97616c5e-4b67-4abe-9cb9-5de77a5b1fa4 | notionChordPageId=79ceeb46-b66f-4116-991b-70921f831113 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/97616c5e4b674abe9cb95de77a5b1fa4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'На Христа взирая'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=131%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Над церковными куполами', 'Молодёжный сборник', NULL, 'Куплет 1:
Над церковными куполами
Небо синее-синее-синее.
Я иду под моими ногами
Беларусь пролегла родимая.
Припев:
Тихим светом далёким светится
Небо звёздами озарённое,
И легко душе моей верится
В вечный рай, где живут спасённые.
Куплет 2:
В чистом небе поют херувимы,
Сердце бъется от счастья и радости.
Для меня этот мир - любимый:
Полон света, добра и благодасти.
Куплет 3:
На земле моя жизнь окончится,
Пролетит незаметно, как птица.
И мне очень, очень хочется
За мою Беларусь молиться!', 'Куплет 1:
Am Dm
E7 Am
C
Dm E7
Припев:
Am Dm
G7 C
F Dm
F E7 Am
Куплет 2:
Am Dm
E7 Am
C
Dm E7
Куплет 3:
Am Dm
E7 Am
C
Dm E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=132 | photo=notion-youth-songbook | notionPageId=7be648d7-8137-426d-a48a-f12168bec8ce | notionChordPageId=26167861-2047-48f8-87e1-695b0f85d6e8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7be648d78137426da48af12168bec8ce', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Над церковными куполами'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=132%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Научи меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Научи меня, мой Господь, во всём
Волю исполнять лишь Твою.
Чтобы мне по слову Твоему доказать,
Как Тебя я, Спаситель, люблю.
Припев:
Научи меня среди тысячи
Голос слышать лишь Твой,
Научи меня за Тобой идти
В край желанный, дорогой.
Куплет 2:
Научи меня в грешном мире жить,
Чтобы свет Твой сиял во тьме,
Где не может скрыться город большой,
Стоя на высоком холме.
Куплет 3:
Научи меня жизнь свою прожить,
Чтоб в конце услышать слова:
Добрый верный раб скорее войди,
В радость Господина своего.', 'Куплет 1:
Em Am
H Em
Em Am
H Em
Припев:
Am D
G Em
Am H
Em E
Куплет 2:
Em Am
H Em
Em Am
H Em
Куплет 3:
Em Am
H Em
Em Am
H Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=133 | photo=notion-youth-songbook | notionPageId=ff3615bc-4736-4a6a-b8ca-11e83940df6e | notionChordPageId=3dd95900-f309-4719-a7ae-e195a83aa265 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ff3615bc47364a6ab8ca11e83940df6e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Научи меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=133%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Начиная новый день', 'Молодёжный сборник', NULL, 'Куплет 1:
Начиная новый день, слышу голос Твой.
Я смотрю на небеса, знаю - Ты со мной.
Пусть, Иисус, Твоя рука поведёт меня.
Я люблю Тебя, Господь, Ты храни меня.
Припев:
Только Ты радость даёшь,
Каждый день за Cобою ведёшь.
Ты омыл душу мою,
Для Тебя живу и пою.
Куплет 2:
Я Тебя благодарю за любовь и мир.
Ты от смерти и греха нас освободил.
В город света и любви нам открыта дверь.
Слава, всемогущий Бог, мы с Тобой теперь.
Куплет 3:
Я хочу, чтоб сегодня горели сердца.
Пусть сияет в них свет от великого Бога - Отца.
Пусть ещё миллионы заблудших людей.
Наконец-то поймут, Кто для них всех нужней.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=134 | photo=notion-youth-songbook | notionPageId=a388cd41-df97-4483-a8c2-70017e780b6a | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/a388cd41df974483a8c270017e780b6a | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Начиная новый день'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=134%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Наш Бог Великий', 'Молодёжный сборник', NULL, 'Куплет 1:
Воду в вино превратил,
Слепые глаза Ты открыл:
Нет таких Бог, нет как Ты!
Ты нас из праха поднял,
Свет Твой во тьме воссиял:
Нет таких Бог, нет как Ты!
Припев:
Наш Бог Великий, Он Всемогущий!
Бог, Ты превыше всего, что дышит!
Наш Бог целитель, всё в Его силе
Наш Бог, Наш Бог!
Мост:
И если Бог с нами,
Кто против нас восстанет?
И если Бог с нами,
Кто может против быть?', 'Куплет 1:
G#m E H
G#m E H
C#m F#
G#m E H
G#m E H
C#m F#
Припев:
G#m E
H F#
G#m E
H F#
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=135 | photo=notion-youth-songbook | notionPageId=92d99b0c-c6c4-43e2-adb4-635ca3052558 | notionChordPageId=6b086cc3-d547-4da4-8032-bd956014a9eb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/92d99b0cc6c443e2adb4635ca3052558', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Наш Бог Великий'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=135%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Наш Бог так велик', 'Молодёжный сборник', NULL, 'Куплет 1:
В сиянии Царя блеск величия
Пусть вся земля поёт, в радости поёт
Он в свет одел Себя и в страхе меркнет тьма
От голоса Его, от голоса Его
Припев:
Наш Бог так велик, пой со мной
Наш Бог так велик, пусть видят все
Наш Бог, наш Бог так велик!
Куплет 2:
Он стоит века, все дни в Его руках
Начало и конец, Начало и конец
Господь наш триедин: Дух, Отец и Сын
Великий Он Творец, Великий Он Творец!
Мост:
Он превыше всех имён
Всей хвалы достоин Он!
И душа поёт:
Наш Бог так велик!', 'Куплет 1:
G Em7
C D
G Em7
C D
Припев:
G
Em7
C D G
Куплет 2:
G Em7
C D
G Em7
C D
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=136 | photo=notion-youth-songbook | notionPageId=4a33c3ab-85d1-4f5c-86f6-7a9322cedc36 | notionChordPageId=3972c2f1-c591-4621-90aa-87a703a29302 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4a33c3ab85d14f5c86f67a9322cedc36', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Наш Бог так велик'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=136%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Наша жизнь - это путь', 'Молодёжный сборник', NULL, 'Куплет 1:
Наша жизнь - это путь на небеса.
День за днем устремляясь вдаль,
Вспомни жизнь и Господни чудеса,
Пусть уйдет роковая печаль
Пой бодрей, сердцу станет веселей,
Со Христом пройдем сквозь огонь, смело.
Наша жизнь - это путь на небеса
Всех искупленных кровью Христа.
Куплет 2:
Наша жизнь - это путь на небеса,
Где гора средь огнистых камней.
Там поют неземные голоса
Песни славы Царю Царей.
Там вовек солнце правды не зайдет,
Не увидим больше мы там ночи.
Наша жизнь - это путь на небеса
Всех искупленных кровью Христа.
Куплет 3:
Наша жизнь - это путь на небеса
По долам каменистых дорог.
Он ведет нас в обители Христа,
Где покой для израненных ног.
Там наш город из золотых камней,
Где течет река посреди рая.
Наша жизнь - это путь на небеса
Всех искупленных кровью Христа.
Куплет 4:
Наша жизнь - это путь на небеса
Сквозь борьбу забывая покой.
День придет и усталые глаза
Засверкают победной слезой.
Все не зря и победа, как венец
Увенчает нас только верь свято.
Наша жизнь - это путь на небеса
Всех искупленных кровью Христа.', 'Куплет 1:
Dm Gm
A# C Dm
Dm Gm
A# C Dm
Gm Dm
Gm A# F
Dm Gm
A# C Dm
Куплет 2:
Dm Gm
A# C Dm
Dm Gm
A# C Dm
Gm Dm
Gm A# F
Dm Gm
A# C Dm
Куплет 3:
Dm Gm
A# C Dm
Dm Gm
A# C Dm
Gm Dm
Gm A# F
Dm Gm
A# C Dm
Куплет 4:
Dm Gm
A# C Dm
Dm Gm
A# C Dm
Gm Dm
Gm A# F
Dm Gm
A# C Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=137 | photo=notion-youth-songbook | notionPageId=f758b27b-2b8d-448e-86ac-09b04363b8ea | notionChordPageId=3504de51-1336-4bdc-a379-5724e0d7ba31 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f758b27b2b8d448e86ac09b04363b8ea', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Наша жизнь - это путь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=137%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Небеса ожидают меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Небеса ожидают меня,
Радость ждёт неземная меня,
Будет встреча с Иисусом Христом,
Святым Духом, Небесным Отцом.
Припев:
И венец, ну конечно, венец,
Тот, что мне приготовил Отец!
И венец, ну конечно, венец,
Тот, что мне приготовил Отец!
Куплет 2:
Город ждёт неземной красоты.
Всюду ангелы, всюду цветы,
Лица милых родных мне друзей,
И Спаситель стоит у дверей.
Куплет 3:
Будет встреча с Иоанном, Петром,
И святых без числа целый сонм.
Подойдут и обнимут меня,
Радость будет моя без конца.', 'Куплет 1:
Em Am
H7 Em
Em Am
H7 Em
Припев:
Em E7 Am
D7 G
C Am
H7 Em
Куплет 2:
Em Am
H7 Em
Em Am
H7 Em
Куплет 3:
Em Am
H7 Em
Em Am
H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=138 | photo=notion-youth-songbook | notionPageId=e62c064c-171b-41a2-a4ca-3fa2658e1106 | notionChordPageId=261a5d25-5baa-4d28-a005-5e812a7871cb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e62c064c171b41a2a4ca3fa2658e1106', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Небеса ожидают меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=138%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Небесная родина', 'Молодёжный сборник', NULL, 'Куплет 1:
Я иду туда, где царит весна,
Где цветут сады и все поля.
Птицы там поют и поет земля,
Я иду туда, я иду туда.
Припев (2 раза):
Небесная родина - там где ждет меня Отец.
Небесная родина - где сияет вечный Божий свет.
Куплет 2:
Там не будет больше горя слез,
Там царит любовь и доброта.
И в мечтах своих моя душа,
Рвется в Небеса, рвется в Небеса.
Куплет 3:
И пускай бывает жизнь трудна,
И бушует море, бьет волна.
Все же верю я, что придет весна,
Я дойду туда, я дойду туда.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=139 | photo=notion-youth-songbook | notionPageId=105ca539-dd6f-4d6d-ae67-16deee4076ba | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/105ca539dd6f4d6dae6716deee4076ba | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Небесная родина'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=139%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Небо, небо, небес', 'Молодёжный сборник', NULL, 'Куплет 1:
Поднимаю глаза и смотрю в небеса,
Там я вижу Христа одесную Отца.
Небо, небо, небес приготовил Он мне,
Цель моя и мечта — неба вся красота!
Припев:
/ Небо, небо, небес,
Город вечных чудес,
Я мечтаю о нем, там
Мечтаю и здесь.
Небо, небо, небес,
Путь туда через крест. /2р.
Куплет 2:
Чтобы в небо попасть, нужно жизнь так прожить,
Чтобы Бог мог сказать: «Ты достоин в нём жить,
Ты достоин смотреть Иисусу в глаза,
Если только войдёшь ты к Нему в небеса».
Куплет 3:
Не слыхал человек, не видал того глаз,
Как там, в небе небес, что там будет для нас.
Но я знаю одно — красотой тех небес
Будет Тот, Кто понёс на Голгофу наш крест.', 'Куплет 1:
Am Dm E7 Am
Am Dm G C Am
Am Dm G C Am
Am Dm E7 Am
Припев:
Am Dm
Dm G
G C
C Am
Am Dm E7
E7 Am
Куплет 2:
Am Dm E7 Am
Am Dm G C Am
Am Dm G C Am
Am Dm E7 Am
Куплет 3:
Am Dm E7 Am
Am Dm G C Am
Am Dm G C Am
Am Dm E7 Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=140 | photo=notion-youth-songbook | notionPageId=21ec9972-c61d-4258-a0d8-6382d4c7d09c | notionChordPageId=66365aa4-c2a3-40cf-936c-b4909bcd752e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/21ec9972c61d4258a0d86382d4c7d09c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Небо, небо, небес'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=140%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Нет другой истории', 'Молодёжный сборник', NULL, 'Куплет 1:
Нет другой истории прекрасной и знакомой
Истории, проникнувшей в сердца
Как мир был погружён в таинство неземное
В святую ночь рождения Христа
История отсчета жизни совсем новой
История отсчета жизни со Христом
Спасенье дать всем нам было Божьей волей
Мы счастье обрели все в Нём!
Припев:
Рождение любви, рождение добра
Рождение мечты надежды и тепла
Рождение Его, подарок Бога нам
Ведь в Сыне Своём Господь явился нам
Мост:
Родился Тот, чье имя знает каждый
Родился Тот,прославлен Кто в веках
Иисус - Спаситель и смиренный Агнец
Родился Он,Чтоб с Ним нам побеждать
Родился Царь,чтоб царствовать вовеки
Своей любовью изменить мир смог
И чрез Него мы стали Божьи дети
Рожденный от Бога - есть Бог!', 'Куплет 1:
D A
Hm A G
D A
Hm A G
D A
Hm A G
D A
G A
Припев:
D A
Hm G
D A
Hm G
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=141 | photo=notion-youth-songbook | notionPageId=b22ec591-125f-4a3c-9ee1-fe699ef51e3c | notionChordPageId=02458177-3db1-4d18-b198-dc7edd88029f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b22ec591125f4a3c9ee1fe699ef51e3c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Нет другой истории'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=141%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Нет небу синему конца', 'Молодёжный сборник', NULL, 'Куплет 1:
Нет небу синему конца,
Везде видна рука Творца,
Сияют звезды в голубой дали,
Сияют звезды в голубой дали,
Припев:
Любовь прекрасна и любовь нежна,
Она нам Господом с небес дана,
Как солнца луч среди заоблачных миров,
Пусть никогда не умолкает в вас любовь.
Куплет 2:
Христос принес огонь любви,
Чтоб люди свято жить могли,
Любовью вечной возлюбил весь мир,
Чтобы, как Он, любили мы.
Куплет 3:
Средь грома жизненных невзгод,
Среди туманов, непогод,
Под шум дождей и шум ветров
Храните нежную любовь.', 'Куплет 1:
Em C G H
Em H C
G C
G Am H
Припев:
E A
E A
E C#m A Am
A H C D E Em
Куплет 2:
Em C G H
Em H C
G C
G Am H
Куплет 3:
Em C G H
Em H C
G C
G Am H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=142 | photo=notion-youth-songbook | notionPageId=4ff83597-1060-412b-9da9-4725ea41510e | notionChordPageId=9e8f9a46-d8cb-48c3-b6ba-5cde2cb6f3c8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4ff835971060412b9da94725ea41510e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Нет небу синему конца'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=142%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Нет, не я, но Христос во мне', 'Молодёжный сборник', NULL, 'Куплет 1:
Бесценный дар, Иисус, мой Искупитель,
Вся благодать небес сокрыта в Нём.
Моя любовь, и праведность, и сила,
Глубокий мир, и радость, и покой.
И я держусь надежды в Иисусе,
Жизнь Ему доверил я вполне,
И теперь с торжеством, петь могу:
”Я спасён лишь Христом, что живет во мне!”
Куплет 2:
Сгустилась ночь, но знаю, не покинет,
Спаситель мой останется со мной.
Свершаю труд я в слабости, а силу,
В нужде моей всегда проявит Он.
Уверен я, мой Пастырь - мне защита,
С Ним пройду долиною теней.
И, воспрянув от бед, я увижу рассвет,
Но не сам, чрез Христа во мне.
Куплет 3:
Смотрю вперёд, без страха и сомненья,
Мой грех прощён, оплачен он сполна.
Ценой Крови мне куплено прощенье,
И смерть навек Христом побеждена.
Всем сердцем я держусь за ту победу,
Иисус - Ходатай мой навек!
Был я скован грехом, стал свободным я в Нём!
Нет, не сам, чрез Христа во мне.
Куплет 4:
Идти за Ним я с каждым вздохом жажду,
Ведь Он сказал, что приведёт домой.
И обновит, чтоб в радости, однажды,
Ввести туда, где трон Его Святой.
||: И я держусь надежды в Иисусе,
Одному Ему хвала вовек!
И свершив жизни путь, будет песнь моих уст:
”Нет, не я, но Христос во мне!” :||', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=143 | photo=notion-youth-songbook | notionPageId=281b8b55-3bc3-4921-a368-f9b63eb539ad | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/281b8b553bc34921a368f9b63eb539ad | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Нет, не я, но Христос во мне'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=143%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Новый год', 'Молодёжный сборник', NULL, 'Куплет 1:
Прошел незаметно весь год
И новый встречаем мы снова
Что новый нам год принесёт
И будем ли к встречи готовы
Припев:
Новый год, пусть радость принесёт
Пусть счастье принесёт, Тебе и Мне
Лишь с Христом не страшен путь земной
Не страшно жить на этой мне земле
Куплет 2:
Мы ждём новый год и порой
Не думаем, не ожидаем
А может он скорби несет
А может разлуку, печали
Куплет 3:
Давайте ж молиться друзья
И жить, как Христос завещал нам
Мы будем счастливы тогда
И жизнь проживём не напрасно.', 'Куплет 1:
Am H7
Dm E Am
A7 Dm
F E
Припев:
Dm Am
Dm G C A7
Dm Am
F E Am
Куплет 2:
Am H7
Dm E Am
A7 Dm
F E
Куплет 3:
Am H7
Dm E Am
A7 Dm
F E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=144 | photo=notion-youth-songbook | notionPageId=5b13d5e9-00af-4c99-a7fa-c727e156a53f | notionChordPageId=37668f59-7eb2-4805-907f-72cca1224a3a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5b13d5e900af4c99a7fac727e156a53f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Новый год'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=144%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ныне поздравляют', 'Молодёжный сборник', NULL, 'Куплет 1:
Ныне поздравляют все друзья тебя,
И тебе желают счастья и добра.
Припев:
Пусть пребудет Божий мир с тобой всегда
Пусть пребудет Божий мир с тобой всегда
И хранит тебя на многие года
И хранит тебя на многие года.
Куплет 2:
Вот уж (много) лет Господь тебя хранил
Хочет Он, чтоб ты Ему всегда служил.
Куплет 3:
Пусть Господь Спаситель Сам тебя ведет
В вечную обитель, где Он Сам живёт.', 'Куплет 1:
D Em
A7 D
Припев:
D Em
A7 D
H7 Em
A D
Куплет 2:
D Em
A7 D
Куплет 3:
D Em
A7 D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=145 | photo=notion-youth-songbook | notionPageId=3fa70b77-ec50-4332-a212-62ab54849d1b | notionChordPageId=a14c45f8-f422-4ff9-a017-2d95294848fd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3fa70b77ec504332a21262ab54849d1b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ныне поздравляют'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=145%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'О, молитва', 'Молодёжный сборник', NULL, 'Куплет 1:
О молитва, о молитва! В жизни Богом ты дана.
В скорбной жизни среди битвы Поднимала ты меня.
Темной ночью я не спал, На коленях все стоял
И душою с Богом говорил: "Ты услышь меня, мой Бог,
Среди жизненных Тревог Помоги, я выбился из сил!"
Куплет 2:
За окном бушует ветер, Хлещет снегом ледяным,
И такой же бурей в сердце В этот вечер я томим.
Но, смирившийся во прах, Со слезами на очах
Я в скорбях Иисуса умолял: "О мой Бог! Ты знаешь все,
На душе так тяжело, Я измучен и почти упал".
Куплет 3:
О молитва, о молитва! Благодарностью горю,
Прославляю Божью силу, Благодати глубину.
Боже! Ты в любви святой Укреплял дух слабый мой,
Когда в бурю падал я без сил. К небесам сердечный вздох
Возносился средь тревог, Я в молитве радость получал.', 'Куплет 1:
Em Am Em H Em
Em Am Em H Em
E Am D G Em
Am D G Am D
G Em Am H Em
Куплет 2:
Em Am Em H Em
Em Am Em H Em
E Am D G Em
Am D G Am D
G Em Am H Em
Куплет 3:
Em Am Em H Em
Em Am Em H Em
E Am D G Em
Am D G Am D
G Em Am H Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=146 | photo=notion-youth-songbook | notionPageId=a9a70757-1ce1-489f-ac5f-6fd776514549 | notionChordPageId=6f44cf5d-5996-487c-accc-b027c4a0ec3f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a9a707571ce1489fac5f6fd776514549', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'О, молитва'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=146%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'О, Ты велик', 'Молодёжный сборник', NULL, 'Куплет 1:
Прихожу к Тебе я с хвалою -
Чудеса Твои велики
И любовь Твоя сильна.
Припев:
О, Ты велик,
Ты прекрасен и велик,
И другого нет как Ты.
И другого нет как Ты.
Куплет 2:
Буду петь Тебе я вечно
За Твою любовь и милость,
Что даришь Ты нам с небес.
Куплет 3:
Ты один достоин всей хвалы,
Превозносим к небу руки -
В Тебе радуемся мы.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=147 | photo=notion-youth-songbook | notionPageId=fd57e227-e505-44b5-baca-5be1526fc133 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/fd57e227e50544b5baca5be1526fc133 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'О, Ты велик'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=147%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Одиноко смотрят звезды', 'Молодёжный сборник', NULL, 'Куплет 1:
Одиноко смотрят звезды, Одиноко плачет небо,
Одиноко ветер носит листья за окном.
В сердце раненом обидой Навсегда уходит совесть.
Где же радость, где же правда, Где же та любовь?
Припев:
Можешь жить другой судьбой, Потому что Бог нас любит.
Можешь, потому что Он святой И не разлюбит.
Ты посмотри на кровь Христа, На Его страданья.
Он не оставит никогда, Он не оставит тебя.
Куплет 2:
Видел в жизни ты так много, Перепробовал немало.
Знаешь, что с волками жить, Так по-волчьи вой.
Ты не веришь даже тем, кому ты Доверял так много.
И не веришь, что ты можешь Жить другой судьбой.
Куплет 3:
Все проносится так быстро И над временем нет власти.
Как бы ты хотел вернуть прошлое назад.
И ты мечешься по жизни, Хочешь вырвать куш свободы,
Но я знаю, бесполезно, Если нет Христа.', 'Куплет 1:
Dm C A# A7
Dm C A# A7
Dm C A# A7
Dm C A# A7
Припев:
Gm A7 Dm A#
Gm A7 Dm D7
Gm A7 A# F
Gm A Dm D7
Куплет 2:
Dm C A# A7
Dm C A# A7
Dm C A# A7
Dm C A# A7
Куплет 3:
Dm C A# A7
Dm C A# A7
Dm C A# A7
Dm C A# A7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=148 | photo=notion-youth-songbook | notionPageId=043847d8-b0cf-4c87-9c92-7c7ba2b90646 | notionChordPageId=6b3815bd-305a-4cd7-8f89-e4dfe8170c8c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/043847d8b0cf4c879c927c7ba2b90646', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Одиноко смотрят звезды'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=148%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Однажды я сказал', 'Молодёжный сборник', NULL, 'Куплет 1:
Однажды я сказал, что сохраню тебя,
Однажды Я сказал – солгу ли Я?
Горы содрогнутся и сгорит земля
Но с тобою вечно будет милость Моя
Припев:
Я не человек Я не предам тебя
Я не брошу за порог во время дождя
Камень не подам вместо хлеба Я
Если слезы на глазах Я успокою тебя
Куплет 2:
Если раны кровоточат у Меня есть елей
Для израненного сердца для души твоей
Но сегодня на мгновенье Я оставлю тебя
Испытать и переплавить средь страданий и зла
Куплет 3:
Я хочу чтоб ты был сильный закаленный солдат
Не дрожал перед врагами пусть трепещет ад
Ты еще расправишь крылья и взлетишь высоко
Кто сказал что побеждать так просто и легко?', 'Куплет 1:
Am F C G
Am F C G
Am F C G
Am F C G
Припев:
Am F
C G Em7
Am F
C G
Куплет 2:
Am F C G
Am F C G
Am F C G
Am F C G
Куплет 3:
Am F C G
Am F C G
Am F C G
Am F C G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=149 | photo=notion-youth-songbook | notionPageId=0422a625-287c-48ac-ad86-36d79ed84f9d | notionChordPageId=abc2bbd1-a1d8-4479-bbdb-5b9bafa64ea9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0422a625287c48acad8636d79ed84f9d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Однажды я сказал'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=149%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он здесь', 'Молодёжный сборник', NULL, 'Куплет 1:
Он здесь, Он здесь,
Хочет встретиться с тобой, Он здесь.
Пред Тобою, мой Господь,
Преклоняются сердца,
Знаю, Всемогущий Бог, что Ты здесь.
Куплет 2:
Он здесь, Он здесь,
Хочет встретиться с тобой, Он здесь.
Нежно глас Его звучит,
Для тебя Он говорит,
Свет любви Его святой всегда горит.
Куплет 3:
Он здесь, Он здесь,
Хочет встретиться с тобой, Он здесь.
Хочет встретиться с тобой,
Чтобы дать душе покой,
Двери сердца для Иисуса ты открой!', 'Куплет 1:
D Em A D D7
G A D D7
G A
F#m Hm
Em A D D7
Куплет 2:
D Em A D D7
G A D D7
G A
F#m Hm
Em A D D7
Куплет 3:
D Em A D D7
G A D D7
G A
F#m Hm
Em A D D7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=150 | photo=notion-youth-songbook | notionPageId=6d2e759a-43aa-4976-b5e8-4176660c5b9e | notionChordPageId=f6296510-eeaf-4c61-87f9-077ac158e2a9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/6d2e759a43aa4976b5e84176660c5b9e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он здесь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=150%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он не сошёл с креста', 'Молодёжный сборник', NULL, 'Куплет 1:
Тебя распяли, мой Господь, а Ты с креста благословлял,
Тебя хулили и кляли, а Ты им, Боже, всё прощал.
Они с Тобою на кресте свои надежды хоронили
О царстве славы на земле, о небесах же позабыли…
Припев:
Он не сошёл с креста, распятый Царь Своим твореньем!
Он не сошёл с креста! Он принял смерть без сожаленья!
Он не сошёл с креста! И в муках боль превозмогая,
Он взывал: «Прости им, как Я прощаю!»
Куплет 2:
Им нужно было всё и здесь, им нужен был земной правитель,
Они не поняли Тебя и не признали, Искупитель.
Стекала струйкой кровь из ран, собою землю орошая,
И содрогались небеса, за ходом действий наблюдая.
Куплет 3:
Слеза упала на ладонь, пронзенную руками грешных,
То небо плакало о Нём, рыдая тихо, безутешно.
Отвергнут, брошен и забыт… Толпа ушла не понимая,
Что в этот миг там, на кресте, Твои страданья их спасали.
Куплет 4:
Воскрес из мёртвых, победил ценою жизни смерти жало!
С Отцом Собою примирил Он нас — и пропасти не стало.
Он на Себе замкнул войну добра и зла, во веки сущих,
И победил! О, мой Господь! Ты — Царь царей, Бог Всемогущий!', 'Куплет 1:
Dm F Gm A
Dm F A# C
F Dm Gm A
A# Gm A
Припев:
Dm F Gm A
Dm F Gm A
F A# Gm A
A# Gm A
Куплет 2:
Dm F Gm A
Dm F A# C
F Dm Gm A
A# Gm A
Куплет 3:
Dm F Gm A
Dm F A# C
F Dm Gm A
A# Gm A
Куплет 4:
Dm F Gm A
Dm F A# C
F Dm Gm A
A# Gm A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=151 | photo=notion-youth-songbook | notionPageId=76d33fe7-0549-424b-95bd-06c60b1ca59d | notionChordPageId=faa37a59-0ed6-47eb-bce1-609bca817dac | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/76d33fe70549424b95bd06c60b1ca59d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он не сошёл с креста'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=151%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он пришёл, спасая всех', 'Молодёжный сборник', NULL, 'Куплет 1:
Он пришёл, спасая всех от земных тревог
Настоящий человек, настоящий Бог.
Самарянкой найден свет у Христовых ног
Плакал Он как человек, а прощал как Бог.
Куплет 2:
Буря, шторм – не виден брег. Волны бьют челнок.
На корме спит человек, шторм смиряет Бог.
Ад и смерть, злобу и грех победить Он смог
Умер Он как человек, а воскрес как Бог.
Куплет 3:
Кто к Нему свой смертный груз с верой не принёс
Тем известен Иисус, не знаком Христос.
Он для них философ, лекарь, гений, вождь, пророк
Им известен человек, но не ведом Бог.
Куплет 4:
Он пришёл, спасая всех от земных тревог
Настоящий человек, настоящий Бог.
Вознесён во славе вверх, Тот, Кто в яслях был
Он пришёл как человек, Богом уходил.', 'Куплет 1:
Dm C
A# Am Dm
A# F Gm Dm
Gm Dm Am Dm
Куплет 2:
Dm C
A# Am Dm
A# F Gm Dm
Gm Dm Am Dm
Куплет 3:
Dm C
A# Am Dm
A# F Gm Dm
Gm Dm Am Dm
Куплет 4:
Dm C
A# Am Dm
A# F Gm Dm
Gm Dm Am Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=152 | photo=notion-youth-songbook | notionPageId=ec59b91f-b8c2-44e4-856c-30ee2ee0f6a9 | notionChordPageId=a3f9a8eb-798e-48b2-8d34-ee455c91e990 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ec59b91fb8c244e4856c30ee2ee0f6a9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он пришёл, спасая всех'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=152%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Он родился для меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Тишина, ночное небо в домах тепло и светло
Иисус, Сын неба родился и настало в сердцах торжество
Вдруг Ангел явился с неба сказал всем “Радуйтесь”
В этот день на всей планете разнеслась весть о Христе
Припев:
Он родился для меня в ночь когда взошла звезда
Все заняты были своими делами но пастухам Он явился тогда
В эту чудную ночь Он пришел чтобы каждый мир с Богом нашел
Сегодня есть шанс для тебя и меня Иисус ожидает всех нас.
Куплет 2:
Его рождение сердце греет тебе дарит и радость и мир
С озарённым сердцем ты принеси к ногам Иисуса дары', 'Куплет 1:
D F# G D
D A G
D F# G D
D A G A
Припев:
D A Em Hm
G D Em A
D A Em Hm
G D Em A D
Куплет 2:
D F# G D
D A G
D F# G D
D A G A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=153 | photo=notion-youth-songbook | notionPageId=7268a4f6-6fda-4f46-a595-c4a655e5dc61 | notionChordPageId=d822bc2e-9a68-427f-b7a8-6c2d99e9638b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7268a4f66fda4f46a595c4a655e5dc61', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Он родился для меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=153%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Острое жало', 'Молодёжный сборник', NULL, 'Куплет 1:
Острое жало коснулось ладони,
Слился со стоном удар молотка.
Брызнула кровь и мучительной болью
Сердце огнем захлестнула волна.

К древу креста уже руки прибили,
Глухо у ног молоток застучал.
Воины алчно одежды делили,
Кто то из них уже жребий бросал.
Припев:
||: Подняли крест и повис обреченно
Царь Иудейский Иисус Назорей.
Мягкая ткань голубого хитона
Кровью залита в руках палачей. :||
Куплет 2:
Там на Голгофе Он принял мученья,
Кровью невинной за нас заплатил.
Царь Иудейский, Сын Божий, Мессия
Двери спасенья нам, грешным открыл.

Люди, вы слышите, все это было
Там на Голгофе с Иисусом Христом,
Но смерть Иисуса не победила -
Ведь Он воскрес и на небо взошел.
Припев:
||: Подняли крест и повис обреченно
Царь Иудейский Иисус Назорей.
Мягкая ткань голубого хитона
Кровью залита в руках палачей. :||
Куплет 3:
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
И обнимала планету Любовь.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=154 | photo=notion-youth-songbook | notionPageId=50b8fefe-ed3b-4bdc-a7df-2102851374e9 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/50b8fefeed3b4bdca7df2102851374e9 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Острое жало'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=154%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отец мой, я люблю Тебя', 'Молодёжный сборник', NULL, 'Куплет 1:
Отец мой, я люблю Тебя
Сильней, Чем что-нибудь на свете,
Ты нужен мне.
О, Иисус, Спаситель мой,
Тебе обязаны всей жизнью мы,
Обязаны Тебе.
Все ангелы Тебя возносят,
И мы возносим лишь Тебя!
Припев:
Ты мой Господь, Ты жизнь моя,
И я живу лишь для Тебя,
Ты мой Господь, люблю Тебя,
Будешь со мною Ты всегда!
Куплет 2:
И всё, что есть, Тебе отдам,
Вся жизнь в руках Твоих,
Господь мой, живу для Тебя.
Все дни мои Тобой даны,
Используй их, Господь, молю Тебя,
Используй для Себя.
Все ангелы Тебя возносят,
И мы возносим лишь Тебя!', 'Куплет 1:
Dm
A# F
F C
Dm
A# F
F C
Gm A# C
Gm A# C
Припев:
F C
Gm C
F C
Gm A#m Dm
Куплет 2:
Dm
A# F
F C
Dm
A# F
F C
Gm A# C
Gm A# C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=155 | photo=notion-youth-songbook | notionPageId=0c52815f-6bce-4f28-bb2d-ce29334b1efb | notionChordPageId=b2e3f74c-292c-4122-9be3-a675bca216da | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0c52815f6bce4f28bb2dce29334b1efb', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отец мой, я люблю Тебя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=155%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Откликнется душа моя', 'Молодёжный сборник', NULL, 'Куплет 1:
Снова по небу скучаю я,
Но знаю, Ты видишь, что в сердце моём.
Часто в мольбе призываю я
“Останься со мною. Введи в Отчий дом”
Припев:
Откликнется душа моя на зов Небесного Отца
И голос долгожданный, я услышу, наконец.
По-новому увижу я весь мир, что окружал меня
И в сердце зазвучит тогда, мелодия небес…
Куплет 2:
Руки Твои берегут меня -
Меня направляют, упасть не дают
Отче, святая любовь Твоя
Открыла мне двери в обитель Твою.
Куплет 3:
Снова по небу скучаю я,
Но верю Ты примешь меня в небеса.
Буду я там, где любовь Твоя,
С Тобой я останусь в раю навсегда!
После последнего припева:
Снова по небу скучаю я…', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=156 | photo=notion-youth-songbook | notionPageId=fcbea3f5-757c-4eaf-85d5-a8a0e2843e6e | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/fcbea3f5757c4eaf85d5a8a0e2843e6e | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Откликнется душа моя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=156%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отцы', 'Молодёжный сборник', NULL, 'Куплет 1:
Отцы, вы надежды на нас возлагали.
Отцы терпеливо детей наставляли.
Отцы — это мужество веры и сила,
Ваша любовь неизмерима.
Отцы, мы за помощью к вам прибегали.
Отцы, вы всегда нас детей понимали,
От стрел мира злобного нас закрывали,
День и ночь на коленях стояли.
Припев:
Молясь за счастливые крепкие семьи,
Не жалели ни силы, ни время.
Храня огонь христианской веры,
Стали детям примером.
Мы вам благодарны безмерно!
Мы вам благодарны безмерно!
Куплет 2:
Отцы, ваши руки в мозолях от боли,
Ваш труд совершённый с огромной любовью.
Мы чтим и в душе понимаем и ценим
Вашу любовь, долготерпенье.
Отцы, как же хочется долгой вам жизни,
Дойти по следам вашим прямо к Отчизне
И стать миру этому ясной звездою,
Идти только узкой тропою.', 'Куплет 1:
Cm Dsus D
Gm F D#
Cm Dsus D
D Gm G
Cm Dsus D
Gm F D#
Cm Dsus D
D Gm G
Припев:
Cm D7
D7 Gm G
Cm F
F A#
Cm D7 D#
Cm D7 Gm
Куплет 2:
Cm Dsus D
Gm F D#
Cm Dsus D
D Gm G
Cm Dsus D
Gm F D#
Cm Dsus D
D Gm G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=157 | photo=notion-youth-songbook | notionPageId=329487dc-7145-406f-8844-b570d39a2864 | notionChordPageId=9cb502dc-c50c-4f74-95fe-2f02720cd209 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/329487dc7145406f8844b570d39a2864', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отцы'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=157%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отчаянья дожди', 'Молодёжный сборник', NULL, 'Куплет 1:
Вновь дом Твой пуст, торжественный канон
Сменился тихой утренней молитвой.
Но сила вечных слов, что я Тобой спасён,
Жизнь делает немыслимо счастливой.
Припев:
Отчаянья дожди ещё идут окрест
И как свеча моя надежда тает
Но вот завесу тьмы пронзает старый крест
Где боль моя навеки умирает
Куплет 2:
И пусть свинцом по небу разлились
Неведомые миру треволненья
Твоя любовь меня на крыльях веры ввысь
Вновь поднимает вопреки сомненьям
Куплет 3:
Не властна смерть над светлою душой
Хотя сквозь мрак ещё не видно солнца
Мне и среди невзгод с Тобою хорошо
Я буду петь доколе сердце бьётся', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=158 | photo=notion-youth-songbook | notionPageId=9f351ae4-3dae-4f2b-a819-a4871d37dd61 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/9f351ae43dae4f2ba819a4871d37dd61 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отчаянья дожди'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=158%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отче мы просим', 'Молодёжный сборник', NULL, 'Куплет 1:
Отче, мы просим: "Ты приди,
Землю исцели" мы сердцами вместе,
Пусть слава Твоя будет в нас,
И узнает мир, что Иисус – Господь!
Припев:
Мы в один голос прославим все Тебя
Мы в один голос всем расскажем что ты Царь
Мы в один голос, гармонией любви,
И мы молим, Бог, Ты нас объедини.
Куплет 2:
Время настало чтоб сердца
Объединить в хвале. Имя Иисуса
Прославим мы на всей Земле,
И узнает мир, что Иисус – Господь!', 'Куплет 1:
D A F#m Hm
G A G A
F# Hm
G Em A A7
Припев:
D F#m G A7
D F#m G A
F# Hm G
Em A D
Куплет 2:
D A F#m Hm
G A G A
F# Hm
G Em A A7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=159 | photo=notion-youth-songbook | notionPageId=fd30492e-8990-4a28-8317-413924d623db | notionChordPageId=ab6d4a31-6387-47dc-b57c-9a29d4e2c827 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fd30492e89904a288317413924d623db', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отче мы просим'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=159%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Отче Небесный, стою пред Тобою', 'Молодёжный сборник', NULL, 'Куплет 1:
Отче Небесный, стою пред Тобою
Такой, как есть.
Руки к Тебе возношу я покорно,
Прости мой грех.
Сердце измени, я жажду быть таким, как Ты,
Таким, как Ты.
Припев:
Ты есть свет, Ты есть святость,
На веки я буду Твой.
Ты – любовь, Ты даришь милость,
Навеки я буду Твой.', 'Куплет 1:
G Em C D
G
G Em C D
Em
C Em D
C G
Припев:
D C
D G
D C
D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=160 | photo=notion-youth-songbook | notionPageId=c6ac7caa-5794-4add-937e-82c737cd400a | notionChordPageId=52042bff-a3ae-41f4-be24-42537b6a3c43 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c6ac7caa57944add937e82c737cd400a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Отче Небесный, стою пред Тобою'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=160%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Первый вздох', 'Молодёжный сборник', NULL, 'Куплет 1:
Первый вздох — ты родился, Я был там,
Ты впервые плакал — Я внимал слезам,
Хоть ты Меня не видел, но Я рядом был,
Хочу, чтоб ты об этом не забыл.
Припев:
Ты в руках Моих всегда, как дитя,
Вся любовь Моя лишь только для тебя,
Когда ты повзрослеешь, даже и тогда
Ты в руках Моих всегда, как дитя.
Куплет 2:
Первый раз на коленях ты стоял —
Я был рядом и словам твоим внимал.
«Прости, Отец, я каюсь», — в молитве ты просил,
Я снял твой грех, обнял и всё простил.', 'Куплет 1:
D G D
F#m G A
D F# G
D A D
Припев:
D G D
F#m G A
D F# G
D A D
Куплет 2:
D G D
F#m G A
D F# G
D A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=161 | photo=notion-youth-songbook | notionPageId=5cad1add-0faf-4fa1-9c18-e814afe90e1f | notionChordPageId=5d4f8e27-8d2f-488d-acb4-44644fd3fc1e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5cad1add0faf4fa19c18e814afe90e1f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Первый вздох'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=161%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'По ночам', 'Молодёжный сборник', NULL, 'Куплет 1:
По ночам часто город мне снится,
Пораженный его красотою,
Начинаю я Богу молиться,
Чтоб однажды увидеть такой.
Припев:
Там ворота двенадцать жемчужин,
У ворот куда входит народ,
Стынет жемчуг в весенних лужах
И никто его не берет.
Куплет 2:
Топчут ноги земных пилигримов,
Золотых тротуаров литье
И никто не хватает зубило,
Чтоб отбить и иметь свое.
Куплет 3:
Я уверен что боль исчезнет,
Когда встретимся мы с тобой,
Ты введешь меня в этот город
По дороге его золотой.
Куплет 4:
Можно там, как бы это не странно,
Безнаказанно делать добро.
А пока я, устав от обмана
И от боли твержу одно:', 'Куплет 1:
C G C
F G Em Am
F G Em Am
F G C
Припев:
F G Em Am
F G Em Am
F G Em Am
F G C
Куплет 2:
C G C
F G Em Am
F G Em Am
F G C
Куплет 3:
C G C
F G Em Am
F G Em Am
F G C
Куплет 4:
C G C
F G Em Am
F G Em Am
F G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=162 | photo=notion-youth-songbook | notionPageId=e1657004-8cad-4361-bb19-8a8b18baeff6 | notionChordPageId=358a9ba2-8b3a-4328-bd02-92132210a073 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e16570048cad4361bb198a8b18baeff6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'По ночам'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=162%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'По преданью отцов', 'Молодёжный сборник', NULL, 'Куплет 1:
По преданью отцов человек охранял
На скрижалях Твое откровенье.
Год за годом его ветер в пыль превращал,
Чтоб забыло о Боге творенье.
Припев:
На скрижалях сердца напиши
Алой кровью для моей души,
Чтобы помнил о любви Твоей
Вспоминая раны от гвоздей.
Куплет 2:
Но не букву Закона Господь подарил
Благодати никто не разрушит.
Те, кто искренне Богу всем сердцем служил,
Не на камне писали, а в души.
Куплет 3:
Боже мой, сотвори веру твёрдой, как камень
Дабы жизнью своей о Тебе рассказать
Мною правь изнутри и душой и руками,
Чтобы в нужный момент все, что есть, мог отдать
Куплет 4:
Никакая беда почерк Твой не сотрет,
Даже если гоненье вернется
Воду жизни душа и в пустыне найдет,
И любовью Твоей напьется.', 'Куплет 1:
Am F
Dm E Am
Am F
Dm H E
Припев:
Am F
C G C G
Am F
C E Am
Куплет 2:
Am F
Dm E Am
Am F
Dm H E
Куплет 3:
Am F
Dm E Am
Am F
Dm H E
Куплет 4:
Am F
Dm E Am
Am F
Dm H E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=163 | photo=notion-youth-songbook | notionPageId=eed61b49-4dd3-4b6b-b089-0e9f831b50df | notionChordPageId=af3117d3-71a4-4180-bf54-7eb06124f8c8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/eed61b494dd34b6bb0890e9f831b50df', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'По преданью отцов'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=163%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'По страницам Библии старой', 'Молодёжный сборник', NULL, 'Куплет 1:
По страницам Библии старой я шагаю в город святой.
И хотя мои ноги устали я по прежнему весел душой.
Не смущают меня ураганы, даже сильные бури в пути.
Отдохну и снова встану в город святой идти.
Припев:
Идти в слякоть и дождь,
Идти не уставать,
Идти туда где Господь,
Он там меня будет ждать.
Куплет 2:
Искушения испытания не заставят меня позабыть
День когда я давал обещание Иисусу всегда верным быть.
Я под знаменьем Божьим встану Его посох меня укрепит.
Я пойду и не устану Бог мой мне говорит.
Куплет 3:
И когда я Господа встречу я пойму - это было не зря.
Он мои мозоли излечит примет нежно в объятья меня.
Там не буду я больше томиться от невзгод и болезней земных.
Там увижу родные лица дошедших друзей родных.', 'Куплет 1:
G C G D
G C Am D
Em Hm C G
C D G C Am C G
Припев:
G D
Em D C
G Am
C D
Куплет 2:
G C G D
G C Am D
Em Hm C G
C D G C Am C G
Куплет 3:
G C G D
G C Am D
Em Hm C G
C D G C Am C G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=164 | photo=notion-youth-songbook | notionPageId=40d20bab-087a-4054-b1a6-fc5b0cb530ba | notionChordPageId=5fd0db32-2e7d-4cb6-bc9e-77382a098842 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/40d20bab087a4054b1a6fc5b0cb530ba', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'По страницам Библии старой'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=164%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Под защитой твоих крыл', 'Молодёжный сборник', NULL, 'Куплет 1:
Буду жить под защитой Твоих крыл,
Буду я в мире Божией любви,
Ночь настанет, и я не убоюсь,
Когда я под защитой Твоих крыл
Припев:
Под защитой, под защитой,
Под защитой Твоих крыл.
Под защитой, под защитой,
Под защитой Твоих крыл.
Куплет 2:
Я спасен под защитой Твоих крыл,
Мой покой под охраною Твоей
Пусть летят стрелы, я не устрашусь,
Когда я под защитой Твоих крыл.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=165 | photo=notion-youth-songbook | notionPageId=e12331b6-168b-4911-baf1-51c1961bccde | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/e12331b6168b4911baf151c1961bccde | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Под защитой твоих крыл'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=165%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Подобно библейским пророкам', 'Молодёжный сборник', NULL, 'Куплет 1:
Подобно библейским пророкам
Хотим Слово Божье нести
О праведности возвещая смело,
Как в дни Моисея, Ильи
Порою нас ждут испытанья,
Нелегок наш путь в небеса,
Но все же, как голос Иоанна, взываем:
«Готовьте все путь для Христа!»
Припев:
Ведь Он грядет к нам на облаках,
Как солнце восстает любовь в Его лучах,
О друг, воспой! Прощенье Бог дает!
Спасение с горы Сион придет!
Куплет 2:
Подобно библейским пророкам
Мы будем в проломе стоять.
Построим молитвами стену с верой
И будем Творца прославлять.
Взгляните! Поля побелели,
Уж жатва созрела давно.
Трудитесь же так, как велел Он, смело,
Неся людям Слово Его!', 'Куплет 1:
G C
G D G
G C
G D G
H Em
C D
G C
G D G
Припев:
G C
G D
G C
G D G
Куплет 2:
G C
G D G
G C
G D G
H Em
C D
G C
G D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=166 | photo=notion-youth-songbook | notionPageId=c467709d-106c-43a3-aec7-bb71ee2d3692 | notionChordPageId=62af9fe7-c025-4dce-b9a8-e8dba1d7cbcd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c467709d106c43a3aec7bb71ee2d3692', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Подобно библейским пророкам'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=166%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пока огонь любви чудесной', 'Молодёжный сборник', NULL, 'Куплет 1:
Пока огонь любви чудесной
Горит в груди волной живой,
Мы силы юные совместно
Употребим на труд святой.
Припев:
//: Юность прекрасная, молодость ясная!
Сил, здоровья не жалей, ( для людей )
К Богу духом пламеней! ( всё сильней ) ://
Куплет 2:
Пока сильны стремленья к небу
И много сил, здоровья в нас,
Друзья, распределим умело
Для славы Божьей всякий час!
Куплет 3:
Ведь даже старцы вспоминают
С улыбкой светлой на устах
Порывы юности святые,
О всех друзьях и о трудах.', 'Куплет 1:
A#
A# Cm
F
F A#
Припев:
A# Cm F A#
A# D#
F A#
Куплет 2:
A#
A# Cm
F
F A#
Куплет 3:
A#
A# Cm
F
F A#', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=167 | photo=notion-youth-songbook | notionPageId=68e26ee3-e791-4ada-81be-404afb9f3425 | notionChordPageId=0fa86bb3-03b2-4ff7-9934-2d8846208dd9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/68e26ee3e7914ada81be404afb9f3425', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пока огонь любви чудесной'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=167%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Покажите мне любовь без Иисуса,', 'Молодёжный сборник', NULL, 'Куплет 1:
Покажите мне любовь без Иисуса,
Где она бы на земле жила одна,
Ведь любви на свете нет без Иисуса,
Ведь она Его за нас, на крест вела.
Припев:
Бог есть любовь – совокупность совершенства.
Бог есть любовь – полнота и глубина.
Бог есть любовь – и наивысшее блаженство.
Бог есть любовь – Он все во всем!
Куплет 2:
Ведь Отец на небе так людей всех любит,
Что Единственного Сына в мир послал.
Ты приди к Нему сейчас, Он не погубит:
За тебя уже Иисус, Его Сын, страдал.
Куплет 3:
Не найдешь, ты милый друг, любви без Бога,
Нет её нигде на свете без Христа.
Ложных чувств здесь, на земле, стремлений много,
Но а истинна любовь лишь у Христа.', 'Куплет 1:
Em Am
H7 Em H7
Em Am
H7 Em H7
Припев:
Am D G C
Am H7 Em E
Am D G C
Am D Em
Куплет 2:
Em Am
H7 Em H7
Em Am
H7 Em H7
Куплет 3:
Em Am
H7 Em H7
Em Am
H7 Em H7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=168 | photo=notion-youth-songbook | notionPageId=febf0039-214d-46a7-85e5-9a50152f5ef4 | notionChordPageId=951d6231-b295-4966-9d9b-e6b2db5d4ac9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/febf0039214d46a785e59a50152f5ef4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Покажите мне любовь без Иисуса,'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=168%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Полдороги в небо', 'Молодёжный сборник', NULL, 'Куплет 1:
Мы с вами столько вёрст уже прошли,
Пусть мало было в них тепла и неги,
Зато теперь осталось позади
По полдороги в небо, по полдороги в небо,
По полдороги в небо.
Куплет 2:
Тревожно, что замедлили шаги,
Что в ком-то тает робкая надежда,
А ведь у нас осталось впереди
По полдороги в небо, по полдороги в небо,
По полдороги в небо.
Куплет 3:
Кому-то надо руку протянуть,
Кого-то надо бережно заметить,
Как страшно потерять кого-нибудь
На полдороги в небо, на полдороги в небо,
На полдороги в небо.
Куплет 4:
Не дай, Господь, кому из нас вздремнуть,
Не дай запачкать белые одежды.
Осталось, может, несколько минут
От полдороги в небо, от полдороги в небо,
От полдороги в небо.', 'Куплет 1:
Cm
Fm G Cm
D# C
Fm Cm
G Cm C
Куплет 2:
Cm
Fm G Cm
D# C
Fm Cm
G Cm C
Куплет 3:
Cm
Fm G Cm
D# C
Fm Cm
G Cm C
Куплет 4:
Cm
Fm G Cm
D# C
Fm Cm
G Cm C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=169 | photo=notion-youth-songbook | notionPageId=e145283c-e29f-4d0f-a9aa-44c3a3e872bb | notionChordPageId=0debae40-6295-4e1e-98c5-2b4528a65466 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e145283ce29f4d0fa9aa44c3a3e872bb', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Полдороги в небо'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=169%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Помоги мне, Боже', 'Молодёжный сборник', NULL, 'Куплет 1:
Помоги мне в этой жизни благодарной, Боже, быть,
Даже если очень больно будут волны жизни бить,
Если сердце истомится, переполненно скорбей,
Не роптать хочу — молиться и любить Тебя сильней.
Припев:
Через все мои скитанья, через раны и всю боль
Вера шаткаю была, но Ты не прошёл меня,
Своей любящей рукою подымал
И в отчаяньи погибнуть не давал.
Ты за Собой меня звал, меня так долго Ты ждал
И так нежно в моё сердце Ты стучал.
Ты меня не забыл, Ты меня не забыл,
Ты поднял меня и жизнь вновь подарил.
Куплет 2:
Если будет взор слезами затуманен вдруг в пути,
Дай сердечными очами видеть милости Твои,
Уразуметь Твою дай волю и за всё благодарить,
Будет радостно иль больно, помоги мне верной быть.
Куплет 3:
О Твоей любви великой рассказать хочу я всем,
Ты один — моя отрада, и Тобой лишь я живу.
И когда так непонятна Твоя воля мне порой,
Всё же следовать я буду неуклонно за Тобой.
Мост:
О, Христос, лишь в Тебе нашла я счастье,
Быть с Тобой всегда, пусть и горе, и ненастье,
Не страшна беда. Чего душе моей бояться?
Ты никогда, Отец, мне не дашь поколебаться.', 'Куплет 1:
Em Am
H C H
Am D G C
Am G C H
Припев:
Em G
Am H Em C
Am G C
Am H Em E
Am H Em C
Am H Em E
Am H Em C
Am H Em
Куплет 2:
Em Am
H C H
Am D G C
Am G C H
Куплет 3:
Em Am
H C H
Am D G C
Am G C H
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=170 | photo=notion-youth-songbook | notionPageId=2146b5d9-af09-4605-82b1-45af9dfbf5e2 | notionChordPageId=19c921c5-e2f9-4b87-a094-ad5e82439c32 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2146b5d9af09460582b145af9dfbf5e2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Помоги мне, Боже'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=170%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Помолись обо мне', 'Молодёжный сборник', NULL, 'Куплет 1:
Помолись обо мне, мой друг.
Помолись, когда я в дороге,
Чтобы где-то когда-то вдруг
Я совсем не забыл о Боге.
Помолись обо мне вдали,
Помолись, когда мы в разлуке,
Чтобы здесь на краю земли
Как Пилат не умыл я руки.
Куплет 2:
Помолись обо мне у креста,
Чтоб как Петр на скрещении улиц
Не отрекся я от Христа
Под кудахтанье здешних куриц…
Помолись половодьем слов,
Помолись, без единого слова,
Чтоб гвоздями своих грехов
Я не впился в тело Христово.
Куплет 3:
Помолись обо мне в тиши,
Помолись обо мне и в шуме,
Чтоб на радость врагам души
Злым разбойником я не умер.
Устремляясь глазами ввысь
Прохожу я над самым адом…
Молча, шепотом или взглядом,
Где бы ни был я, помолись, помолись…..', 'Куплет 1:
Dm
Gm7
C F7
Gm A7
F D
Gm C
F7 A#
Gm A7
Куплет 2:
Dm
Gm7
C F7
Gm A7
F D
Gm C
F7 A#
Gm A7
Куплет 3:
Dm
Gm7
C F7
Gm A7
F D
Gm C
F7 A#
Gm A7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=171 | photo=notion-youth-songbook | notionPageId=96544a04-5b5d-4860-9f7f-796008defdca | notionChordPageId=720aaecc-d5f4-47e3-bfff-1dad5d0236c2 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/96544a045b5d48609f7f796008defdca', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Помолись обо мне'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=171%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Посмотри на Небо', 'Молодёжный сборник', NULL, 'Куплет 1:
Если ты в пути продрог и не знаешь где ты.
Если силы не сберёг и не видишь света
Если страшен этот час и тревога гложит.
К Богу обратись сейчас - Он тебе поможет.
Припев:
||: Посмотри на Небо, посмотри на Небо.
Никогда ты не был один. :||
Куплет 2:
Труден к Богу первый шаг, но Отец Небесный
На Своих несёт плечах тяжесть смерти крестной.
А тебя в Своей руке Он с любовью держит,
Приготовил Он тебе радость и надежду.
Припев:
||: Посмотри на Небо, посмотри на Небо.
Никогда ты не был один. :||
// Проигрыш //
Мост (ускоренно):
||: Посмотри на Небо, посмотри на Небо.
Никогда ты не был один. :||
// Проигрыш //
Припев (замедленно):
Посмотри на Небо, посмотри на Небо.
Никогда ты не был один.', 'Куплет 1:
Am                                      Dm
G                                    C                            E
Am                                    Dm
F                                             Dm                      G
Припев:
Am                              Dm
                       G             C  E
Куплет 2:
Am                                            Dm
G                                          C                                      E
Am                               Dm
F                                    Dm                          G
Припев:
Am                              Dm
                       G             C  E
Am Dm G C E
Am Dm F E
Am                              Dm
                       G             C  E
Am Dm F E
Am Dm F E
Am                              Dm
                       G             C  E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=172 | photo=notion-youth-songbook | notionPageId=6f7e1f3b-5265-49cb-a521-2b680f7931de | notionChordPageId=d7b5f494-b67f-4c84-ba31-74f181270666 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/6f7e1f3b526549cba5212b680f7931de', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Посмотри на Небо'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=172%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Праздник жатвы', 'Молодёжный сборник', NULL, 'Куплет 1:
Снова год пролетел, День Жатвы настал…
Перед Богом Отцом ты снова предстал.
Что ты скажешь Ему, как хвалу вознесешь?
И какие слова в этот день ты найдёшь?
Припев:
И в праздник жатвы славу Богу воздай
Благодарением жизнь свою наполняй
И в праздник жатвы взгляни на свои пути
Господь, помилуй помилуй нас грешных прости
Куплет 2:
Вспомни милости, что Бог тебе посылал,
На молитвы когда Он, твои, отвечал.
Каждый миг на путях сберегал и хранил
Не однажды тебя Он от зла защитил
Куплет 3:
Когда вдруг, получил больше, чем ты просил,
Когда враг стороною тебя обходил -
“Это - Бог за тебя!” - говорили вокруг…
Он за нас, потому, что Он наш лучший Друг!', 'Куплет 1:
Am Dm
E Am
Am Dm
E Am
Припев:
Dm Am
E Am
Dm Am
E Am
Куплет 2:
Am Dm
E Am
Am Dm
E Am
Куплет 3:
Am Dm
E Am
Am Dm
E Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=173 | photo=notion-youth-songbook | notionPageId=41247341-4f45-4b19-ac75-47474cadfce8 | notionChordPageId=120a32a3-2593-4b08-aed4-dadba12615fa | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/412473414f454b19ac7547474cadfce8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Праздник жатвы'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=173%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Превыше силы', 'Молодёжный сборник', NULL, 'Куплет 1:
Превыше силы, превыше царств,
Превыше славы и всех земных богатств,
Превыше мудрости и всех путей людских
Великий Бог, Владыка всей земли.
Превыше солнца и всех планет,
Превыше всех чудес, какие видел свет,
Превознесён над небом и землёй,
И нет пути прекраснее, чем Твой.
Припев:
Мира грех Ты вознёс на крест,
Был распят, но в третий день воскрес,
Как цветок, растоптанный в пыли,
Отвержен был, но всё простил,
В небесах - Всемогущий Бог,
На земле - отверженный цветок,
Я люблю смотреть в глаза Твои,
Бесценный дар для меня – это Ты!
Куплет 2:
Ты над всеми и во всём
Вечной славой и светом озарён,
Выше всех престолов и царей,
Каждый миг Ты помнишь обо мне.
Ты надежду подарил,
Ты навеки, и я в руках Твоих,
Каждый день восходит, как заря,
Милость безграничная Твоя.', 'Куплет 1:
C D G
C D G
C D Em
Am C D
C D G
C D G
C D Em
Am C H
Припев:
G Am D G
G Am D G
Em D C G
C D
G Am D G
G Am D G
Em D C G
C D G
Куплет 2:
C D G
C D G
C D Em
Am C D
C D G
C D G
C D Em
Am C H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=174 | photo=notion-youth-songbook | notionPageId=816eec2e-d32e-4ab6-9d95-5cc789a99f4b | notionChordPageId=46733da3-a311-4747-bd57-feab7f1353e5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/816eec2ed32e4ab69d955cc789a99f4b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Превыше силы'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=174%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Придите к Иисусу', 'Молодёжный сборник', NULL, 'Куплет 1:
Все вокруг заняты были своим, и только лишь три мудреца
Пришли поклониться ребёнку в яслях, посланники Бога Отца.
Милый малыш сладко дремал на материнских руках,
А в небе тогда сияла звезда, пели Ангелы на небесах.
Припев:
Придите к Иисусу любовь обрести,
Он наш Спаситель, Сын Бога любви.
Придите к Иисусу, Царю Царей,
Он ожидает, чтоб дать вам любовь, придите скорей.
Куплет 2:
Там в небольшом городке Вифлеем малыш Иисус был рождён.
Мама Мария растила Его, с любовью заботясь о Нём.
В яслях в ту ночь Иисус сладко спал под нежным покровом небес,
И в Рождество, в день рожденья Его, услышишь ты Ангелов песнь.
Мост:
Войди в моё сердце, любовь подари,
Иисус мой Спаситель, Сын Бога любви.
Войди в моё сердце, Иисус — Царь с небес,
Ты — наша жизнь и Ты истинный путь, Ты любишь нас всех.', 'Куплет 1:
Em Hm C G C D G H
Em Hm C G C D
Em Hm C G C D G H
Em Hm C G C D
Припев:
G D
C Am D
G C Am
G D G
Куплет 2:
Em Hm C G C D G H
Em Hm C G C D
Em Hm C G C D G H
Em Hm C G C D
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=175 | photo=notion-youth-songbook | notionPageId=fa205362-f23e-4d7e-8447-878f011f35a2 | notionChordPageId=b36a4fc3-f0e0-4c08-8a98-b54ef23d8cda | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fa205362f23e4d7e8447878f011f35a2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Придите к Иисусу'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=175%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Прославим Бога', 'Молодёжный сборник', NULL, 'Куплет 1:
Прославим Бога одной семьёю,
Направим взор свой к небесам.
Кто любит Господа, кто любит Господа
Соединяйтесь, песня одна.
Куплет 2:
Когда-то были совсем чужие,
Теперь для Бога уже свои.
Кто любит Господа, кто любит Господа
В белых одеждах встретитесь вы!
Куплет 3:
Нас утешает святое Слово,
Иисус сказал, к тому придёт,
Кто любит Господа, кто любит Господа
Обитель чудную в сердце найдёт
Куплет 4:
Проходят годы, стареют люди,
Но улыбнитесь, звучат слова:
Кто любит Господа, кто любит Господа
Готовы встретить вас небеса', 'Куплет 1:
Em Am H Em
Am D G E
Am Em
Am H Em E7
Куплет 2:
Em Am H Em
Am D G E
Am Em
Am H Em E7
Куплет 3:
Em Am H Em
Am D G E
Am Em
Am H Em E7
Куплет 4:
Em Am H Em
Am D G E
Am Em
Am H Em E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=176 | photo=notion-youth-songbook | notionPageId=1e114234-a094-4ed1-8550-b0b1278aac17 | notionChordPageId=00c7a531-8e05-4a0d-8874-e359fe287355 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1e114234a0944ed18550b0b1278aac17', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Прославим Бога'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=176%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Прости меня, Боже', 'Молодёжный сборник', NULL, 'Куплет 1:
Прости меня, Боже, прости, я молю,
Прости, что так поздно к Тебе прихожу,
Прости, что я раньше Тебя не познал
И друга иного тогда я избрал.
Прости, что я раньше Тебя не познал
И друга иного тогда я избрал.
Куплет 2:
Прости, что мой разум с Тобой воевал,
Прости, что Тебя я страдать заставлял,
Прости, что я скорби Тебе причинял
И дерзко Любовь на кресте распинал.
Прости, что я скорби Тебе причинял
И дерзко Любовь на кресте распинал.
Куплет 3:
Но Ты пробудил меня к жизни иной
И сердца коснулся Своею рукой,
Глаза мне открыл Ты на пройденный путь,
В неверье, в грехах мне не дал утонуть.
Глаза мне открыл Ты на пройденный путь,
В неверье, в грехах мне не дал утонуть.
Куплет 4:
И вот я в молитве стою пред Тобой,
Веди меня, Боже, Своею рукой!
Я всю свою жизнь посвящаю Тебе,
Ты только не дай мне погибнуть в борьбе.
Я всю свою жизнь посвящаю Тебе,
Ты только не дай мне погибнуть в борьбе.
Куплет 5:
И я обещаю Тебя прославлять
И словом и делом Тебя восхвалять,
Чтоб люди увидели свет Твой во мне
И, светом влекомые, шли все к Тебе.
Чтоб люди увидели свет Твой во мне
И, светом влекомые, шли все к Тебе.', 'Куплет 1:
Em Am H7 Em
Em Am D G
Am D G Em
Am Em E7
Am D G Em
Am H7 Em
Куплет 2:
Em Am H7 Em
Em Am D G
Am D G Em
Am Em E7
Am D G Em
Am H7 Em
Куплет 3:
Em Am H7 Em
Em Am D G
Am D G Em
Am Em E7
Am D G Em
Am H7 Em
Куплет 4:
Em Am H7 Em
Em Am D G
Am D G Em
Am Em E7
Am D G Em
Am H7 Em
Куплет 5:
Em Am H7 Em
Em Am D G
Am D G Em
Am Em E7
Am D G Em
Am H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=177 | photo=notion-youth-songbook | notionPageId=82339dfc-6459-424d-92b3-5e3b1a229569 | notionChordPageId=1c990b02-96b4-4afb-b90b-66461f8e3a8e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/82339dfc6459424d92b35e3b1a229569', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Прости меня, Боже'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=177%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Просыпаюсь на заре', 'Молодёжный сборник', NULL, 'Куплет 1:
Просыпаюсь на заре
И стремлюсь, мой Бог, к Тебе.
Верю, слышишь Ты меня,
Иисус, люблю Тебя.
Припев:
//: Я ищу Твои пути и хочу по ним идти,
Надо мной, Господь, Твоя рука. ://
Куплет 2:
Вижу все Твои дела
И поёт душа моя.
Каждый день к Тебе ведёт,
В сердце праведность живёт.', 'Куплет 1:
D G
A D
D G
A D
Припев:
G A D Hm
Em A D D7
Куплет 2:
D G
A D
D G
A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=178 | photo=notion-youth-songbook | notionPageId=7c9f5f35-ac63-43b3-a5f2-1d2218b65a7d | notionChordPageId=4ecb1b2d-63a7-4362-8f54-c5511181e0bb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/7c9f5f35ac6343b3a5f21d2218b65a7d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Просыпаюсь на заре'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=178%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пусть Он войдет', 'Молодёжный сборник', NULL, 'Куплет 1:
О взгляни! Открыты покровы небес —
Детский плач, над девой звезды яркий блеск!
И ожили пророка слова
О надежде, что в ясли сошла.
О, распахни врата, впусти Царя Христа!
Припев:
||: Пусть Он войдет, Христос войдет!
Приготовьте место для Царя! :||
Куплет 2:
С нами Бог! Мессия для нас рожден.
Наш Творец исполнил пророчества в Нем.
Яркий свет во тьме ночной,
Тем, кто жаждет — Источник живой.
Услышь и обратись: Он истина и жизнь!
Припев:
||: Пусть Он войдет, Христос войдет!
Приготовьте место для Царя! :||
Куплет 3:
Слышишь стук, пронзивший холодную ночь?
Он пришел! Не гони Царя славы прочь!
Ясли, крест и гроб в скале –
Божий путь любви к Земле.
Он воскрес и вновь придет! Царь Царей вовек живет!
Припев:
||: Пусть Он войдет, Христос войдет!
Приготовьте место для Царя! :||
Приготовьте место для Царя!', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=179 | photo=notion-youth-songbook | notionPageId=6b3d73a4-9721-4e20-bd6e-34aaa0c59f5e | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/6b3d73a497214e20bd6e34aaa0c59f5e | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пусть Он войдет'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=179%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пусть светит солнце', 'Молодёжный сборник', NULL, 'Куплет 1:
Пусть светит солнце и дождь идёт,
Душа моя дышит и сердце поёт.
Меня любит Бог, Господь всей земли,
Он ждёт и тебя, но где же ты?
Припев:
Услышьте все: Господь – любовь
С Голгофы льётся святая кровь
Он любит меня и Он любит тебя,
Он наш Отец, а мы – семья.
Мой Бог - праведный, святой!
Мой Бог – не идол, Он живой!
Мой Бог удалил боль и грусть!
Мой Бог – Господь Иисус!!!
Куплет 2:
Со мною Он везде и всегда,
Он не покинет меня никогда.
И если имя Его призовёшь,
То счастье, любовь и мир обретёшь.', 'Куплет 1:
F C Dm
A# C F
C Dm
A# C F
Припев:
F C Dm
A# C F
C Dm
A# C F
F C
C Dm
Dm A#
C F
Куплет 2:
F C Dm
A# C F
C Dm
A# C F', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=180 | photo=notion-youth-songbook | notionPageId=d4aac228-88d0-46a4-ace9-8828b3698426 | notionChordPageId=f36f0541-3003-494e-8c84-1bfe88ae81c7 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d4aac22888d046a4ace98828b3698426', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пусть светит солнце'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=180%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пусть угасло небо', 'Молодёжный сборник', NULL, 'Куплет 1:
Пусть угасло небо, пусть померк рассвет.
Пусть умолкли люди, пусть молчат в ответ
На любовь Твою.
Припев:
Но шелестом дождя, песнею ручья
Для Тебя, Господь,
Из сердца в небеса льется песнь моя.
Песня без конца.
Куплет 2:
Да, кругом раздоры, да, и Ты забыт.
Люди прочь уходят в путь, что тьмой покрыт.
Где и Ты забыт.
Куплет 3:
Ты придёшь, и навсегда исчезнет грех.
Там, где темнота была, сияет свет.
Вечный Божий свет.', 'Куплет 1:
Am F Am F
Am F Am F
F G
Припев:
Am F C
G Am
Am F C
G Am
Куплет 2:
Am F Am F
Am F Am F
F G
Куплет 3:
Am F Am F
Am F Am F
F G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=181 | photo=notion-youth-songbook | notionPageId=5fb33616-75f9-4fd7-8bb2-e9d970b27972 | notionChordPageId=de9aec53-1aa8-4a46-9672-9840f794e074 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5fb3361675f94fd78bb2e9d970b27972', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пусть угасло небо'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=181%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Путь на Голгофу далёк', 'Молодёжный сборник', NULL, 'Куплет 1:
Путь на Голгофу далёк,
Путь на Голгофу так труден
Жаркое солнце печёт,
"Распни"- злобно требуют люди
Припев:
Смотрите, смотрите, небесный народ,
Как люд на распятье Иисуса ведёт,
И кровь Его, святую, проливает,
Хоть Он им всем прощение даёт
Куплет 2:
Весь изувечен толпой,
К месту, где будет распятым,
Всходит Он, словно на трон,
К миру любовью объятый
[Припев]
Куплет 3:
Нам Бог свою жизнь отдал,
Всех Он с любовью прощает
Но и по сей день Его
Люди в сердцах распинают
[Припев - 2 раза]
И кровь Его, святую, проливает,
Хоть Он им всем прощение даёт...', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=182 | photo=notion-youth-songbook | notionPageId=8da57a79-957d-45c9-8c4e-39e4562c8cf6 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/8da57a79957d45c98c4e39e4562c8cf6 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Путь на Голгофу далёк'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=182%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Пшеница и плевелы', 'Молодёжный сборник', NULL, 'Куплет 1:
Пшеница и плевелы, так мало времени
Осталось вместе вам расти.
Бог видит ваши сердца, ваши пути,
Ничего не скрыть, настанет час вас отделить.
Приготовил палач свои гвозди,
Режет нож виноградные грозди,
И ручьём потекла из ладоней кровь.
Там, на Голгофе, пред толпою людей
Божий Сын в небо к Богу взывает:
Припев:
«Да пребудет воля Твоя, Боже, воля Твоя!
В этот день, страшный день услышь Меня!
Я проливаю за них в этих муках
Кровь Мою, кровь Мою!»
Куплет 2:
Пшеница и плевелы, так мало времени…
Вот Божий серп пожнет поля.
От страха вздрогнет земля, эта земля,
Час суда придёт, когда Господь с небес грядёт.
Бог отделит пшеницу от плевел,
И спасен будет тот, кто доверил
Своё сердце Христу на пути земном.
Кто жил беспечно, тот сожжется огнём.
Стань зерном, чтобы с Богом быть вечно.', 'Куплет 1:
Dm A
A# A G A
Dm
C F Gm Asus A
Dm
A
A# A
A# Asus A
A# Gm A
Припев:
Gm F
Gm G A
A# Gm A G A
A# Gm A
Куплет 2:
Dm A
A# A G A
Dm
C F Gm Asus A
Dm
A
A# A
A# Asus A
A# Gm A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=183 | photo=notion-youth-songbook | notionPageId=28b19b44-6364-4b0f-a2b5-c3c6994de10e | notionChordPageId=c71ec666-396c-4d27-8ba1-690b45eac365 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/28b19b4463644b0fa2b5c3c6994de10e', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Пшеница и плевелы'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=183%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Радость находится', 'Молодёжный сборник', NULL, 'Куплет 1:
Радость находится в сердце у того,
Чьим Спасителем стал Иисус.
Истинный мир для души своей нашел
Тот, которого спас Иисус.
Припев:
О, чувство самое драгоценное,
Что может дать Господь.
Это любовь того, которого спас Иисус.', 'Куплет 1:
E C#m
A H
E C#m
A H7
Припев:
E C#m
A E
A H7 E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=184 | photo=notion-youth-songbook | notionPageId=5fe8d04b-5701-466f-ba50-8f613ec53d78 | notionChordPageId=d5c83588-2a1b-49af-9c96-ad73ecbbed60 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5fe8d04b5701466fba508f613ec53d78', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Радость находится'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=184%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Раньше жил я во грехах', 'Молодёжный сборник', NULL, 'Куплет 1:
Раньше жил я во грехах, в горе, болях и скорбях,
Никогда не думал я о вечности.
Но Иисус нашел меня, разорвал все узы зла,
Полон я теперь небесной радости!
Я свободен, я свободен, я свободен от неправды и греха!
Иисус нашел меня, разорвал все узы зла.
Полон я теперь небесной радости!
Куплет 2:
Слово Божье учит нас: Дух Господень не погас,
Силу даст Он возвещать всем о Христе.
Тот Божественный огонь, с неба посланный Отцом,
Наделяет силой слабых на земле.
Он пылает, да пылает, Дух Святой зажег огонь в моей душе.
Тот Божественный огонь, с неба посланный
Отцом, Наделяет силой слабых на земле.
Куплет 3:
Если болен ты, друг мой, обратись к Христу с мольбой,
Удалит Он немощь и печаль твою.
Что угодно пусть болит. Он здоровье возвратит.
Кровь Христова исцеление дарит.
Кровь Христова, Кровь Христова и сегодня исцеляет всех больных.
Что угодно пусть болит. Он здоровье возвратит,
Кровь Христова исцеление дарит.
Куплет 4:
Вот смоковница цветет, скоро наш Господь придет,
Чтоб забрать свою невесту в небеса.
И конец придет скорбям, что за радость будет там!
Друг, готов ли встретить Господа Христа?
Ты готов ли, ты готов ли? Друг, готов ли ты покинуть этот мир?
И конец придет скорбям, что за радость будет там!
Друг, готов ли встретить Господа Христа?', 'Куплет 1:
Dm Gm Dm
Dm A
Dm Gm Dm
Dm A Dm
Dm Gm C F
Dm Gm Dm
Dm A Dm
Куплет 2:
Dm Gm Dm
Dm A
Dm Gm Dm
Dm A Dm
Dm Gm C F
Dm Gm Dm
Dm A Dm
Куплет 3:
Dm Gm Dm
Dm A
Dm Gm Dm
Dm A Dm
Dm Gm C F
Dm Gm Dm
Dm A Dm
Куплет 4:
Dm Gm Dm
Dm A
Dm Gm Dm
Dm A Dm
Dm Gm C F
Dm Gm Dm
Dm A Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=185 | photo=notion-youth-songbook | notionPageId=406c794c-b775-46d4-ba2d-e9c74ee5779c | notionChordPageId=4ba758a7-88d1-4b11-b03b-c787dbb40eb5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/406c794cb77546d4ba2de9c74ee5779c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Раньше жил я во грехах'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=185%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Руки опущены', 'Молодёжный сборник', NULL, 'Куплет 1:
Руки опущены, слезы в очах
Люди, прислушайтесь к свисту бича.
Сбылось пророчество, лик Твой в крови,
Смех и пощечины, крики «Распни!»
Припев:
Это моя вина, это мои дела,
Это мои слова ранят Христа.
Это моя вина, это мои дела,
Это мои слова ранят Христа.
Куплет 2:
Крест поношения, слезы и боль.
Щедрой жестокостью платим порой
Вместо награды – зло, вместо хвалы – хула
Божьему Сыну на плечи легла.
Куплет 3:
Ветер бушует, луч солнца угас,
Веет соблазном дьявола глас:
«Что же на помощь Отца не зовешь?
Или пощады и милости ждешь?»
Припев:
Это моя вина, это мои дела,
Это мои слова ранят Христа.
Это моя вина, это мои дела,
Это мои слова ранят Христа.
Празднуют небеса
Гимны поет земля
Славим и ты, и я
Подвиг Христа!', 'Куплет 1:
Am C
Dm E
E Am G C
C Dm E Am E
Припев:
Am G C
Dm E Am E
Am G C
Dm E Am
Куплет 2:
Am C
Dm E
E Am G C
C Dm E Am E
Куплет 3:
Am C
Dm E
E Am G C
C Dm E Am E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=186 | photo=notion-youth-songbook | notionPageId=bf23d7c5-03ed-48ee-aa30-b3df8bee2699 | notionChordPageId=122e541b-1450-4364-bc7d-7fe0fcc95211 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bf23d7c503ed48eeaa30b3df8bee2699', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Руки опущены'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=186%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'С детских лет стремились', 'Молодёжный сборник', NULL, 'Куплет 1:
С детских лет стремились к небесам твои мечты,
Про любовь Иисуса с колыбели знаешь ты
Но совсем недавно стал ты чаще замечать,
Как тебе не просто против мира устоять
Припев:
Соблазнам так легко поддатся и свернуть с пути
Но без Бога невозможно жизнь найти
Мир влечет людей красотой огней,
Только с каждым днем он ранит все больней.
Куплет 2:
Перед тем как выбрать путь которым ты пойдешь,
Хорошо подумай: что без Бога ты найдешь?
Вспомни сколько раз тебе Он руку подавал,
Как Ему быть верным ты всем сердцем обещал…', 'Куплет 1:
Em7 C
D G H
Em C
D G H
Припев:
Em Am
D G
C Am A
Am H Em
Куплет 2:
Em7 C
D G H
Em C
D G H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=187 | photo=notion-youth-songbook | notionPageId=53b75fe0-383c-487d-b875-675dd13393e7 | notionChordPageId=5dbcc44e-9b40-4535-be22-4e70b1263fc9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/53b75fe0383c487db875675dd13393e7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'С детских лет стремились'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=187%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Светом Своим', 'Молодёжный сборник', NULL, 'Куплет 1:
Светом Своим Ты прогнал сумрак ночи,
И мне глаза Ты открыл.
Всю свою жизнь я хочу быть с Тобою,
Надежду Ты мне подарил.
Припев:
Здесь я, чтобы славить, пред Тобой склониться
И сказать Тебе, что Ты - мой Бог.
Ты один достоин, кто с Тобой сравнится,
Кто так возлюбить меня бы смог?
Куплет 2:
Царь всех царей высоко вознесённый,
Прославленный в небесах!
С неба сошёл Ты, чтоб дать всем спасение,
Унижен Ты был ради нас.
Мост:
Мне не забыть какой ценой
На крест был вознесён грех мой!', 'Куплет 1:
E H F#m
E H A
E H F#m
E H A
Припев:
A E H
C#m A
E H
C#m A
Куплет 2:
E H F#m
E H A
E H F#m
E H A
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=188 | photo=notion-youth-songbook | notionPageId=b11f05a2-4868-4738-bc06-6c43d0d908cc | notionChordPageId=327200ae-5f8a-419b-963d-d73b88f0bbe8 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b11f05a248684738bc066c43d0d908cc', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Светом Своим'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=188%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Свят Господь', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты ярче, чем солнца свет,
Ты - бездна святой любви!
Нет! Знаю, другого нет!
Есть! Знаю, есть только Ты!
Припев:
Свят Господь, свят Господь!
Славит Господа земля!
Свят Господь, свят Господь!
Славит вся Вселенная!
Куплет 2:
Ты славою облечен,
Ты вечно превознесен!
Ты – начало и Ты – конец,
Ты – Бог мой, Ты - мой Отец!
Куплет 3:
Ты – жизнь, ты сама любовь,
Ты - Агнец, проливший Кровь!
Ты - славный Спаситель мой,
Иисус, Ты - мой Господь живой!', 'Куплет 1:
Em D G
Am H Em
Em D G
Am H Em
Припев:
Em C
D G
Em Am
H Em
Куплет 2:
Em D G
Am H Em
Em D G
Am H Em
Куплет 3:
Em D G
Am H Em
Em D G
Am H Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=189 | photo=notion-youth-songbook | notionPageId=e96c8783-fb9a-4c4f-8199-aa0f4b9443b1 | notionChordPageId=72a7817e-39ee-4139-82e2-8a96a230875e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e96c8783fb9a4c4f8199aa0f4b9443b1', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Свят Господь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=189%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Святая ночь', 'Молодёжный сборник', NULL, 'Куплет 1:
Святая ночь! Сверкают ярко звезды.
В тиши ночной нам родился Христос.
Весь мир тонул в грехе и беззаконьи,
Но Божий Сын нам спасенье принёс.
Надежда счастьем сердце наполняет,
В дали горит грядущих дней заря.
О, человек! Внимай певцам из рая!
О, ночь, о, ночь, Христова рождества!
О, ночь, о, ночь, Христова рождества!
Куплет 2:
Небесный свет рассеял мрак печали,
С огнём в душе мы у яслей стоим.
Так мудрецы Царя царей искали,
Несли дары и склонились пред Ним.
Господь господ лежал в хлеву на сене
Сочувствовать Он может нам во всём:
Он знает жизнь, Он испытал мученья.
Пади пред Ним, признай Его Царём!
Пади пред Ним, признай Его Царём!
Куплет 3:
Он нас учил всё покрывать любовью,
Любви закон и Свой мир Он нам дал.
Наш долг — спасать несчастных и бездольных:
За всех людей наш Господь пострадал.
Пусть песни славы льются словно реки,
Пусть каждый к Богу радостно спешит.
Христос — Господь! Хвала Ему навеки!
Ему вся власть и честь принадлежит!
Ему вся власть и честь принадлежит!', 'Куплет 1:
A D A
E A
A D A
C#m G#7 C#m
E A
E A
F#m C#m Hm F#m
A E A D A E A
E A Hm A E A
Куплет 2:
A D A
E A
A D A
C#m G#7 C#m
E A
E A
F#m C#m Hm F#m
A E A D A E A
E A Hm A E A
Куплет 3:
A D A
E A
A D A
C#m G#7 C#m
E A
E A
F#m C#m Hm F#m
A E A D A E A
E A Hm A E A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=190 | photo=notion-youth-songbook | notionPageId=359db02d-da74-4cae-8cb7-ef4f0a0f535b | notionChordPageId=d0ad38f3-3a45-4ec5-af5f-cebba2c958fc | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/359db02dda744cae8cb7ef4f0a0f535b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Святая ночь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=190%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сердце благодарностью горит', 'Молодёжный сборник', NULL, 'Куплет 1:
Я благодарю Тебя, мой Бог,
За год прожитый на земле,
За то, что на развилках всех дорог
Близок Ты всегда ко мне.
Припев:
Сердце благодарностью горит,
Молитва в небеса к Тебе летит.
Твоя любовь вечна и не исчезает,
Она нас жизнью наполняет.
Куплет 2:
Я благодарю, что каждый час
Твоя рука объемлет нас.
Ведь над землёй и небом Ты один
Жизни нашей Властелин.
Куплет 3:
Да не умолкают пусть уста,
О Тебе пусть говорят людям.
Имя Иисуса, Иисуса Христа
Возвещать мы вечно будем.', 'Куплет 1:
Em Am
H Em
Em Am
H Em
Припев:
Am D
Em C
Am Em
F# H Em
Куплет 2:
Em Am
H Em
Em Am
H Em
Куплет 3:
Em Am
H Em
Em Am
H Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=191 | photo=notion-youth-songbook | notionPageId=b8328808-1568-4561-b5d4-97de3fd277f2 | notionChordPageId=851c60cc-aea1-408a-a27d-a5a1ea13ce23 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b832880815684561b5d497de3fd277f2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сердце благодарностью горит'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=191%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сила моя в Тебе', 'Молодёжный сборник', NULL, 'Куплет 1:
Сила моя в Тебе Господь,
Ты исцеляешь мою плоть,
Мой всемогущий Бог.
Где бы я ни был, Ты со мной,
Слышу повсюду голос Твой,
Мой вездесущий Бог.
Припев:
Иисус, Агнец Божий,
Достоин имени Своего.
Куплет 2:
Взял мой позор, мой грех, мой крест,
Благословлю имя Твое,
Ты для меня все.
Я упал вниз - Ты поднял вверх,
Жаждал я - Ты мне дал воды,
Ты для меня все.', 'Куплет 1:
E H C#m
G#m A
H E H
E H C#m
G#m A
H E H
Припев:
E H C#m G#m
A H E H
Куплет 2:
E H C#m
G#m A
H E H
E H C#m
G#m A
H E H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=192 | photo=notion-youth-songbook | notionPageId=fcc8685f-ee59-4f6e-a2c9-d081be361c0a | notionChordPageId=85aa0fbd-c505-44da-aff3-cb28f409e1d9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/fcc8685fee594f6ea2c9d081be361c0a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сила моя в Тебе'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=192%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Скоро рассвет', 'Молодёжный сборник', NULL, 'Куплет 1:
Скоро рассвет нового дня: приходит весна,
Увидим Его таким, как Он есть. Да Он встретит меня.
Придёт во славе, мы ждем Его.
Мы ждем, Господь, прихода твоего!
Припев:
Гряди, мы твой народ и позади оставили всё!
И впереди на облаках Ты встретишь нас.
С тобой взойдем на небо, и в покой откроешь двери
Как домой вернёмся в отчий дом родной
Куплет 2:
Будем хвалить Господа мы в наших сердцах
Будем петь новую песню там с Ним в небесах
Приди в славе мы ждём Тебя
Мы ждём, Господь, прихода Твоего!', 'Куплет 1:
G Em C D
G Em C D
G D G D
C G C D
Припев:
G Em
C Am D
G Em
C D G
Куплет 2:
G Em C D
G Em C D
G D G D
C G C D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=193 | photo=notion-youth-songbook | notionPageId=3a95baf7-c650-48de-b51d-e5c07b1af76c | notionChordPageId=466f6606-0153-4818-99d6-da76ac607477 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3a95baf7c65048deb51de5c07b1af76c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Скоро рассвет'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=193%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Скрой меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Скрой меня, Своим крылом,
Сохрани, под сильною рукой!
Припев:
Пусть бушует шторм и гром гремит,
Над бурей буду я с Тобой парить,
Мой Отец Ты Царь над всей Землей,
Я не боюсь, мой Бог со мной.
Куплет 2:
Найду покой, В Тебе Христос,
Верю я, в могущество Твоё!', 'Куплет 1:
C G Am F D G
C G Am F D G
Припев:
F G C
F G Am
F G C
F G C
Куплет 2:
C G Am F D G
C G Am F D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=194 | photo=notion-youth-songbook | notionPageId=9d60ddae-b369-4d9b-93f0-099359f8948c | notionChordPageId=df96f0cd-08d5-439e-bebf-8ca342bd7e4f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9d60ddaeb3694d9b93f0099359f8948c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Скрой меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=194%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слабый скажет: «Я силён!»', 'Молодёжный сборник', NULL, 'Куплет 1:
Слабый скажет: «Я силён!»
Бедный скажет: «Я богат!»
Скажет: «Вижу» - тот, кто слеп,
Всё это сделал Бог во мне.
Припев:
Осанна! Осанна!
Будем петь Иисус тебе,
Осанна! Осанна!
Ты был распят, но вновь воскрес.
Куплет 2:
Пойду к реке живой воды,
Где ты омыл грехи мои,
Буду петь, что во Христе
К новой жизни я воскрес.
Куплет 3:
Поднимусь я из глубин,
Найду я жизнь в руках Твоих,
Буду петь, что для Небес
К новой жизни я воскрес.', 'Куплет 1:
C G C
Am Em
C G C
F G C
Припев:
G Am
F C
G Am
F G C
Куплет 2:
C G C
Am Em
C G C
F G C
Куплет 3:
C G C
Am Em
C G C
F G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=195 | photo=notion-youth-songbook | notionPageId=0f98bded-646c-47a6-9c6d-afe6558bb7d8 | notionChordPageId=5c518a78-1ad9-4a0e-9563-fc49fb6f0e9f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0f98bded646c47a69c6dafe6558bb7d8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слабый скажет: «Я силён!»'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=195%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слава Всемогущему Богу!', 'Молодёжный сборник', NULL, 'Куплет 1:
Отец Небесный мы с любовью,
За все Тебя благодарим
Мы Сына Твоего омыты кровью
Пред Тобой в благоговении стоим.
Припев:
Слава Всемогущему Богу!
Он был, Он есть и вновь грядет!
Слава Всемогущему Богу, Во веки веков!
Куплет 2:
Отец Небесный любим мы Тебя
Прославить жаждем среди ночи и дня
Твое царство пусть же будет внутри сердца нас.
Свою силу прояви Ты Боже наш.
Куплет 3:
Святое имя возвышаем мы.
Слагаем нужды все пред Ним Одним
Ароматы славы Божьей ощущаем мы.
Преклонитесь и будьте спасены!', 'Куплет 1:
A Hm
E A
A Hm
D E A
Припев:
E A E D
E A
E A E D E A
Куплет 2:
A Hm
E A
A Hm
D E A
Куплет 3:
A Hm
E A
A Hm
D E A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=196 | photo=notion-youth-songbook | notionPageId=06795c30-3621-46ac-a6d6-9b68ff593896 | notionChordPageId=12ad2fe3-4acb-45ae-bc69-5256de65af9f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/06795c30362146aca6d69b68ff593896', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слава Всемогущему Богу!'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=196%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слава Христу', 'Молодёжный сборник', NULL, 'Куплет 1:
Какой сегодня день чудесный:
С друзьями встретились мы вновь.
Давайте в этот час все вместе
Прославим Божию Любовь.
Припев:
Слава Христу за дивную встречу,
Увидеть снова лица друг друга
Бог нам даровал.
Куплет 2:
Какой сегодня день прекрасный:
Как раньше, снова вместе мы.
И пусть сегодня солнце ясно
Сияет после краткой тьмы!
Куплет 3:
Какой сегодня день счастливый:
О нём мечтали мы давно,
И даже, если он дождливый,
Прославим Бога все равно.', 'Куплет 1:
A Hm
E A
A D
E A
Припев:
A D E A
A D
E A
Куплет 2:
A Hm
E A
A D
E A
Куплет 3:
A Hm
E A
A D
E A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=197 | photo=notion-youth-songbook | notionPageId=4088e091-7f29-428b-be53-3114c5dfd48a | notionChordPageId=22aa8792-536b-4320-9280-3c7714fa2dcb | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4088e0917f29428bbe533114c5dfd48a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слава Христу'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=197%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Славлю Тебя, Господи', 'Молодёжный сборник', NULL, 'Куплет 1:
Славлю Тебя, Господи, всем сердцем своим
В свете праведных, в собрании святых,
Велики дела Господни, вожделенны для всех
Любящих Тебя, Господи!
Припев:
Буду я петь и восхвалять,
Сладко мне имя Твоё,
И чудеса Твои возвещать,
Бог упованье моё!
Куплет 2:
Дело рук Его – истина и суд,
Заповеди все в сердце моём живут,
Пищу он даёт боящимся Его,
Вечно помнит Свой завет – Он с тобой!', 'Куплет 1:
A F#m C#m E
A F#m C#m E
D A C#7 F#m E
D A E7 A
Припев:
A7 D A
C#7 F#m
D A
E7 A
Куплет 2:
A F#m C#m E
A F#m C#m E
D A C#7 F#m E
D A E7 A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=198 | photo=notion-youth-songbook | notionPageId=68e13abb-e49d-4cdb-aaed-a64d9b191ba5 | notionChordPageId=3899d54d-8185-4a72-8da9-250da532a031 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/68e13abbe49d4cdbaaeda64d9b191ba5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Славлю Тебя, Господи'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=198%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Славь, душа, Господа', 'Молодёжный сборник', NULL, 'Куплет 1:
Солнце встаёт, новый день приходит,
Время опять хвалу воздать
За всё, что Ты мне дал, и за каждый новый вдох мой
Я буду петь и на закате дня.
Припев:
Славь, душа, Господа, Славь, душа,
Имя Святое Его.
Пой Ему, как никогда, пой, душа,
Благослови Господа.
Куплет 2:
Велик в любви, и даёшь мне милость,
Ты справедлив и так благ ко мне,
За все дары Тебя хочу прославить
Их сотни тысяч вижу в жизни я.
Куплет 3:
В тот день, когда иссякнет сила
Настанет час встретить мне Христа
Душа моя Его будет славить
Десятки тысяч лет и навсегда!', 'Куплет 1:
A E H C#m
A E H C#m
A E H C#m
A E H E
Припев:
A E H C#m
A E H
A C#m A H C#m
A H
Куплет 2:
A E H C#m
A E H C#m
A E H C#m
A E H E
Куплет 3:
A E H C#m
A E H C#m
A E H C#m
A E H E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=199 | photo=notion-youth-songbook | notionPageId=0d7b62fb-e45a-44fb-a587-1b4c1387da15 | notionChordPageId=96d880b1-39fc-4bf7-9780-17897d2b2e9b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0d7b62fbe45a44fba5871b4c1387da15', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Славь, душа, Господа'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=199%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Слова те нельзя стереть', 'Молодёжный сборник', NULL, 'Куплет 1:
Напиши Свое Слово на сердце моем,
Чтобы я мог исполнить Слово Твое.
Ведь чернила с бумагой однажды сгорят,
Плотяные скрижали Слова сохранят.
Припев:
Слова те нельзя стереть,
Над ними не властна смерть,
Их невозможно сжечь,
Лучшее место, где их сберечь –
В сердце своем храни,
Пусть там оживут они,
И то, что сказал Господь
Проявится через плоть.
Куплет 2:
Твоя заповедь стала мне песней в пути,
Что чрез боль и усталость поможет пройти.
Соблюдать Твое Слово – удел для меня,
Пусть же снова и снова будет Воля Твоя!', 'Куплет 1:
Em C D Hm
C Am H
Em C D Hm
C Am H
Припев:
Em D C
Em D C
G D Em
C Am H
Em D C
Em D C
G D Em
Am H
Куплет 2:
Em C D Hm
C Am H
Em C D Hm
C Am H', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=200 | photo=notion-youth-songbook | notionPageId=244f3179-eacd-4527-9a9a-7a6bb8383763 | notionChordPageId=a07d635e-4c21-4ed5-8c2b-b66080e08217 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/244f3179eacd45279a9a7a6bb8383763', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Слова те нельзя стереть'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=200%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Создатель всей Вселенной', 'Молодёжный сборник', NULL, 'Куплет 1:
Создатель всей Вселенной - Всемогущий Бог,
И жизнь мою другой лишь только Ты соделать смог.
Я петь хочу о том, что подарил мне Ты,
О той любви, что бесконечна, как и Ты.
Припев:
Тебе, Господь, хвалу я вознесу,
Перед Тобой я голову склоню.
Тебе, Господь, любовь и жизнь моя,
Прими молитву эту от меня.
Куплет 2:
Создатель всей Вселенной, Всемогущий Бог,
Среди ночи Ты мне увидеть Свет помог.
С тех пор, как я узнал Твою любовь ко мне,
Хочу служить всем сердцем я Тебе.', 'Куплет 1:
Am Em Am Em
F E
Am Em Am Em
F E
Припев:
Am F G C
F E Am
Am F G C
F E Am
Куплет 2:
Am Em Am Em
F E
Am Em Am Em
F E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=201 | photo=notion-youth-songbook | notionPageId=05b97727-f0ae-4cc8-9670-e4546b9eb1b0 | notionChordPageId=d5190bd8-d9f4-4280-8517-376efa62db8e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/05b97727f0ae4cc89670e4546b9eb1b0', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Создатель всей Вселенной'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=201%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Солнца луч', 'Молодёжный сборник', NULL, 'Куплет 1:
Солнца луч одарит теплом землю.
Небеса возвестят Творцу славу.
День и ночь о Нём говорят,
И Ему гимны звучат
До пределов земли, в наших сердцах.
До пределов земли, в наших сердцах.
Куплет 2:
Откровение Бога нам даёт мудрость,
И закон Его укрепляет нам душу.
Повеления Божьи верны,
Наставления Божьи точны,
И они веселят наши сердца.
И они веселят наши сердца.
Мост:
Страх Господень чист, пребывает вовек,
Суд Господень свят, охраняет нас.
Пусть угодны будут Тебе
Помышления наших сердец.
Ты - твердыня для нас, наш Господь и Отец.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=202 | photo=notion-youth-songbook | notionPageId=9f0a8c98-450a-48a7-b0c0-23e676849a25 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/9f0a8c98450a48a7b0c023e676849a25 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Солнца луч'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=202%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'С‍‍олнца свет, за‍‍кат и рассвет', 'Молодёжный сборник', NULL, 'Куплет 1:
Оглянись! Посмотри вок‍‍руг себя
Как прекрасен этот мир, как краси‍‍ва вся земля
Облака словно белый с‍‍нег белы
На бескрайней си‍‍неве необъя‍‍тны и нежны
Припев:
С‍‍олнца свет, за‍‍кат и рассвет
Соловь‍‍иные трели и подсне‍‍жник в апреле
Л‍‍етние ночи, нежный запах цветов
Во всем творе‍‍нии з‍‍аметна Божья любо‍‍вь.
Куплет 2:
Человек – Божьей красоты венец
В совершенствии любви отражаеться Отец
Нам образ дан и подобие Творца
И познанию Его не найти во век конца.
Куплет 3:
Если ты в сердце затаил вопрос
Где начало всех начал и откуда сколько звезд
Знай мой друг есть один простой ответ:
Бог создал весь этот мир и Ему хвала вовек!', 'Куплет 1:
F Dm
A# C
F Dm
A# C
Припев:
F Dm
A# C
F Dm
A# C F
Куплет 2:
F Dm
A# C
F Dm
A# C
Куплет 3:
F Dm
A# C
F Dm
A# C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=203 | photo=notion-youth-songbook | notionPageId=c9264797-8200-4788-bd10-81a1a7f4c5f2 | notionChordPageId=9c23d8a3-00cf-406f-97f4-a547ae5629d0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/c926479782004788bd1081a1a7f4c5f2', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'С‍‍олнца свет, за‍‍кат и рассвет'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=203%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Солнце простилось с землею', 'Молодёжный сборник', NULL, 'Куплет 1:
Солнце простилось с землею,
Солнце сказало: “До встречи!”.
С первой на небе звездою
Тихо пришел к нам вечер.
Припев:
Там, далеко в вышине,
Звезды поют и сейчас
Друг мой тебе и мне
О Боге нельзя молчать.
Куплет 2:
Сумрачней стало и глуше,
Птицы заснули в гнездах.
Не уходи, послушай,
Как напевают звезды.
Куплет 3:
Если тревожит душу
Мысль: “Для чего я создан?” -
Не уходи послушай:
Славят Создателя звезды.
Куплет 4:
Голос свой влей в их пенье,
Всем о любви скажи,
Чтоб к высоте стремленье
В людях могло бы жить.', 'Куплет 1:
D G
A D
D G
A D
Припев:
H Em
A D F#
Hm G
A D
Куплет 2:
D G
A D
D G
A D
Куплет 3:
D G
A D
D G
A D
Куплет 4:
D G
A D
D G
A D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=204 | photo=notion-youth-songbook | notionPageId=0a4ce734-0504-4532-a862-84c8ba65e984 | notionChordPageId=a4352688-3d81-4a1a-a38e-674ec3ffa2ae | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0a4ce73405044532a86284c8ba65e984', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Солнце простилось с землею'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=204%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Спасенье моё, надежда моя', 'Молодёжный сборник', NULL, 'Куплет 1:
Спасенье моё, надежда моя,
Лишь в Тебе источник моей жизни.
Отрада любви, утешенье моё,
Лишь в Тебе источник моей жизни.
Припев:
Подниму я очи свои
И прославлю Того, Кто любит меня.
Подниму я очи свои
И скажу Тебе, Бог мой, как люблю я Тебя.', 'Куплет 1:
E C#m
A H7
E C#m
A H7
Припев:
E C#m F#m H7
E C#m F#m H7
E C#m F#m H7
C#m A7 A E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=205 | photo=notion-youth-songbook | notionPageId=68e06d4f-bf93-4d58-b43a-ffd0bc8f0c27 | notionChordPageId=bf8e0b3c-cc25-4552-9446-9e0cd0782951 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/68e06d4fbf934d58b43affd0bc8f0c27', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Спасенье моё, надежда моя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=205%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Спелых колосьев', 'Молодёжный сборник', NULL, 'Куплет 1:
Спелых колосьев, к жатве готовых, поле стоит.
Серп ожидает, жнеца поджидает, душе говорит:
“Годы уходят, даты проходят, спешат всё вперёд.
Что собирает, что приготовил Божий народ?”
Припев:
Как жизнь прожил ты, как её провёл?
Богу служил ли, что приобрёл
С чем к Спасителю выйдем, что принесём
С дымом чадящим иль с сердечным огнём.
Куплет 2:
Поле уж бело, взяться за дело Бог всем велит.
Лень удаляя, мир пробуждая, труд пусть кипит.
Кончится лето, но льётся свет нам – пойдём на поля.
Пусть воспевает, к Богу шагает наша Земля.
Куплет 3:
Вот уже скоро работники споро сойдут на поля.
Что не дозреет, уже не созреет, то для огня.
Отмерено время, живи не в смятенье, готовь добрый плод.
Только подобных, Богу угодных, в небе оплот.', 'Куплет 1:
G Hm Am
D G D
G Hm Am
C D
Припев:
G H
E A
Am D G Em
C G
Куплет 2:
G Hm Am
D G D
G Hm Am
C D
Куплет 3:
G Hm Am
D G D
G Hm Am
C D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=206 | photo=notion-youth-songbook | notionPageId=775b5c6d-a236-4c67-9991-16675261e00b | notionChordPageId=fdcc5f3a-747b-4a8b-bb5e-50c754ebc381 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/775b5c6da2364c67999116675261e00b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Спелых колосьев'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=206%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Старый крест', 'Молодёжный сборник', NULL, 'Куплет 1:
На далеком холме, средь деревьев и скал
Сквозь седые века старый крест простоял.
Миллионы людей у подножья креста
Свое счастье нашли, там однажды был я.
Припев:
Старый крест, старый крест, неброский, но лишь в нём
Сила есть, сила есть, сегодня может он
Исцелять разбитые, больные сердца,
Каждому пришедшему открыть небеса.
Куплет 2:
Между небом святым и греховной землей
Пропасть злая лежит, разделяя собой.
Хочешь верь, хочешь нет, слушай слово Творца.
Крест - единственный мост от земли в небеса.
Куплет 3:
Иисус дорогой, на вершине креста
Сквозь седые века я увидел Тебя:
На пронзенных руках не застывшая кровь,
А в прекрасных глазах Божья к людям любовь.', 'Куплет 1:
Am Dm E7 Am
Dm G C
Am Dm E7 Am
Dm F E7
Припев:
Dm E7 Am
Dm G C A7
Dm Am F
Dm F E7 Am
Куплет 2:
Am Dm E7 Am
Dm G C
Am Dm E7 Am
Dm F E7
Куплет 3:
Am Dm E7 Am
Dm G C
Am Dm E7 Am
Dm F E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=207 | photo=notion-youth-songbook | notionPageId=16a95c9a-32e2-4e93-8296-f71dea423e57 | notionChordPageId=883dd778-fcf2-4bb7-9b8b-cb5a4c5cfb8a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/16a95c9a32e24e938296f71dea423e57', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Старый крест'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=207%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Струн души', 'Молодёжный сборник', NULL, 'Куплет 1:
Струн души рука Христа касается,
И она восторженно поет,
Песнь еще одна на свет рождается,
Песнь о Том, Кто счастье нам дает.
Куплет 2:
О Тебе поют сады весенние
Трелью звонких птичьих голосов.
Я хочу воспеть Твое спасение,
Жаль, что нет таких на свете слов.
Куплет 3:
Твой привет мне льется ароматами
Всех полей цветущих и садов.
Навсегда порвав с мирскими взглядами,
Принял я навек Твою любовь.
Куплет 4:
Я любовь великую, безбрежную
Нахожу во всем, что видит взор,
И люблю любовью самой нежною
Я Того, Кто снял греха позор.
Куплет 5:
Струн души рука Христа касается,
И она восторженно поет.
Пусть вовеки песня не кончается,
Песнь о Том, Кто счастье нам дает!', 'Куплет 1:
Am
Dm G C Am
Dm G C Am
Dm E Am
Куплет 2:
Am
Dm G C Am
Dm G C Am
Dm E Am
Куплет 3:
Am
Dm G C Am
Dm G C Am
Dm E Am
Куплет 4:
Am
Dm G C Am
Dm G C Am
Dm E Am
Куплет 5:
Am
Dm G C Am
Dm G C Am
Dm E Am', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=208 | photo=notion-youth-songbook | notionPageId=76e761e9-4946-4bc6-b4eb-db32efa8e2a5 | notionChordPageId=602e6adc-e6fe-4357-bed2-efd0c82efaea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/76e761e949464bc6b4ebdb32efa8e2a5', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Струн души'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=208%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Суть рождения Иисуса', 'Молодёжный сборник', NULL, 'Куплет 1:
Суть рождения Иисуса это дивный Божий план
Он послал Его на землю, чтоб явить любовь всем нам,
Чтобы грешников погибших от греха спасти навек,
Чтобы дать им всем надежду ведь без Бога счастья нет!
Припев:
Рождество, Рождество!
Свет и радость нам принёс, в этот мир рождён Христос!
Рождество, Рождество
Будем праздновать всегда день Рождения Христа!
В Рождество!
Куплет 2:
В этот праздник очень часто забывают о Христе,
Но Его святое имя пусть же слышится везде,
Так давайте обратим наши взоры на Христа
Благодарностью наполним наши души и сердца!', 'Куплет 1:
C G
Dm C
F G
E G
Припев:
Am G C
F G
Am G C
F G
C
Куплет 2:
C G
Dm C
F G
E G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=209 | photo=notion-youth-songbook | notionPageId=8836d91b-a95a-40cf-b411-8e0154848751 | notionChordPageId=6c6b1f2e-60c5-4a9b-92de-76d6fe07e53c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8836d91ba95a40cfb4118e0154848751', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Суть рождения Иисуса'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=209%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сущий', 'Молодёжный сборник', NULL, 'Куплет 1:
В начали был и есть, и нет тебе конца,
Ты высота глубина.
Ты словом делал всё, Ты словом мир создал,
Своё величье доказал
Припев:
Пред Тобой трепещет всё весь мир в Твоих руках
Ты всемогущий Бог Создатель Ты и Царь
Великий, всемогущий, у ног Твоих весь мир
На троне восседаешь могуществом Своим
Великий, вездесущий, над всеми Ты царишь
И всем Ты управляешь, жизнь всему даришь
Куплет 2:
Когда приходишь ты, в своей святой любви,
Приходит свет из темноты
Ты был и есть прежде всех веков
Твоё имя Саваоф
Мост:
В Твоём имени свобода
В Твоём имени огонь
В Твоём имени прощение
В Твоём имени любовь', 'Куплет 1:
Fm Cm
C# Fm
Fm Cm
C# Fm
Припев:
A#m Fm
A#m C
Fm Cm
C# C
Fm D#
C# C
Куплет 2:
Fm Cm
C# Fm
Fm Cm
C# Fm
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=210 | photo=notion-youth-songbook | notionPageId=e1ee1e85-f183-44a7-a4fa-6408b4698367 | notionChordPageId=9ad98f15-e7f9-43bf-b494-b1e09bbf7cfa | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e1ee1e85f18344a7a4fa6408b4698367', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сущий'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=210%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Сын Божий нам рождён', 'Молодёжный сборник', NULL, 'Куплет 1:
Сын Божий нам рождён оставив власть и трон
Без славы в мир пришёл Всесильный Царь
Вся силы полнота вся славы красота
Явились в эту ночь в Младенце нам
Приди и поклонись
Припев:
Христос Господь нас грешных спасёт
Божий Сын рождён как мы
Христос Господь наш Царь принял плоть
Нам рождён Господь Иисус
Куплет 2:
Мессия был так мал когда в хлеву лежал
Рождён чтоб искупить позорный грех
В хлеву Он мирно спит но Он соединит
Святого Бога и спасенных всех
Приди и поклонись', 'Куплет 1:
C F
C G
C F
C G
F G
Припев:
Am F G C
Am F G
Am F G Am
F G C
Куплет 2:
C F
C G
C F
C G
F G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=211 | photo=notion-youth-songbook | notionPageId=0ceab6ef-c520-4149-9f9e-d0f391e0430b | notionChordPageId=ed768b83-fbe8-43e9-940c-088902e8fa8b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0ceab6efc52041499f9ed0f391e0430b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Сын Божий нам рождён'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=211%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Так уж бывает летней порой', 'Молодёжный сборник', NULL, 'Куплет 1:
Так уж бывает летней порой,
Когда луч солнца радует нас -
В час испытанья - чёрной будто рукой
Небо закроет от нас.
Припев:
И если не станет овец в загоне,
И виноград не даст плода,
Все равно я буду славить
Господа Христа!
Куплет 2:
Если закружит меня волною
В водовороте суетного дня,
Верой поднявшись над суетою
Вновь запоет душа моя:
Куплет 3:
Если однажды теряешь что-то,
Вспомни слова Иисуса Христа -
«Где ваша ценность – там сердце будет!»,
А, значит, потеря – не велика!
Куплет 4:
Если однажды жизненный выбор:
Ради Иисуса и славы Отца
Нужно лишиться овец в загоне,
Хочу, чтобы спела душа моя:', 'Куплет 1:
Dm Gm
A7 Dm
Dm Gm
C F
Припев:
Gm C
F Dm
Gm Dm
A7 Dm
Куплет 2:
Dm Gm
A7 Dm
Dm Gm
C F
Куплет 3:
Dm Gm
A7 Dm
Dm Gm
C F
Куплет 4:
Dm Gm
A7 Dm
Dm Gm
C F', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=212 | photo=notion-youth-songbook | notionPageId=092d79d3-ded0-44f1-a951-9880bacf0c1b | notionChordPageId=6d831c9a-70d7-459d-8293-eb03dd45a49b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/092d79d3ded044f1a9519880bacf0c1b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Так уж бывает летней порой'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=212%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Таков как есмь', 'Молодёжный сборник', NULL, 'Куплет 1:
Таков как есмь, во имя Крови,
За нас пролитой на кресте,
Во имя Божьих призываний,
Христос, я прихожу к Тебе!
Христос, я прихожу к Тебе!
Куплет 2:
Таков как есмь слепой и бедный,
Добра не находя в себе,
За верой, зреньем и прощеньем,
Христос, я прихожу к Тебе!
Христос, я прихожу к Тебе!
Куплет 3:
Таков как есмь, меня Ты примешь,
Дашь жизнь, спасенье, мир Твой мне;
К Тебе я прихожу, Спаситель,
Дай мне Тебя познать вполне!
Дай мне Тебя познать вполне!
Куплет 4:
Таков как есмь, Твоей любовью
Низвергнул Ты преграды все,
Я Твой отныне и вовеки,
Христос, я прихожу к Тебе!
Христос, я прихожу к Тебе!', 'Куплет 1:
D G Em
G A D
G Em
G A Hm G
A G D
Куплет 2:
D G Em
G A D
G Em
G A Hm G
A G D
Куплет 3:
D G Em
G A D
G Em
G A Hm G
A G D
Куплет 4:
D G Em
G A D
G Em
G A Hm G
A G D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=213 | photo=notion-youth-songbook | notionPageId=94d8b659-16e3-4e60-8443-3f9754e17a48 | notionChordPageId=225dbf1f-633a-47fc-a54f-9779950eed73 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/94d8b65916e34e6084433f9754e17a48', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Таков как есмь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=213%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Там, в вышине бесконечной', 'Молодёжный сборник', NULL, 'Куплет 1:
Там, в вышине бесконечной,
Между планет, город стоит, город вечный.
Как я хочу там отдохнуть и дышать, дышать, дышать
И с восторгом наслаждаться прославлять Христа, прославлять.
Куплет 2:
Здесь постоянно усталый,
Трудно дышать в мире греховном мне стало.
Только в одном, мне со Христом все вперед, вперед, вперед,
Он в небесную Отчизну непременно доведет.
Куплет 3:
Все предо мною прекрасно,
Кажется мне, чувство мое не угасло.
Город родной неповторим он живет, растет, цветет.
Город чудный, город славный красотой к себе влечет.', 'Куплет 1:
Hm Em
F# Hm
Hm Em G
Hm Em F# Hm
Куплет 2:
Hm Em
F# Hm
Hm Em G
Hm Em F# Hm
Куплет 3:
Hm Em
F# Hm
Hm Em G
Hm Em F# Hm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=214 | photo=notion-youth-songbook | notionPageId=efa099e1-42a4-4989-9152-e3be8f4af908 | notionChordPageId=10bcc95e-d349-40ef-ab93-29594957ad64 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/efa099e142a449899152e3be8f4af908', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Там, в вышине бесконечной'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=214%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Там, где Один', 'Молодёжный сборник', NULL, 'Куплет 1:
Там, где Один пострадал за всех,
Там, где разбойник прощен за грех, -
Там Своей кровью Он смыл мой грех,
О, хвала Ему!
Припев:
О, хвала Ему! О, хвала Ему!
Там Своей кровью Он смыл мой грех,
О, хвала Ему!
Куплет 2:
Дивно Христос дар любви простер,
Дивно с несчастного снял позор,
Дивно живет Он во мне с тех пор,
О, хвала Ему!
Куплет 3:
Чудный свет Божий рассеял тьму,
Чудно, что смог я придти к Нему,
Чудно Христос дает жизнь всему, -
О, хвала Ему!
Куплет 4:
К жизни потоку направь свой путь,
Духом спеши ко Христу прильнуть,
Грех свой омой и счастливым будь!
О, хвала Ему!', 'Куплет 1:
E A E
E A H7
E A E
E H7 E
Припев:
A E C#m A H7
E A E
E H7 E
Куплет 2:
E A E
E A H7
E A E
E H7 E
Куплет 3:
E A E
E A H7
E A E
E H7 E
Куплет 4:
E A E
E A H7
E A E
E H7 E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=215 | photo=notion-youth-songbook | notionPageId=9e9767a6-217a-4b8c-9570-2e7cfa0af56a | notionChordPageId=94d7ba42-0679-4611-92cd-13e12b37993e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/9e9767a6217a4b8c95702e7cfa0af56a', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Там, где Один'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=215%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Там, далеко, за облаками', 'Молодёжный сборник', NULL, 'Куплет 1:
Там, далеко, за облаками,
Встретит меня Иисус,
Нежно обнимет своими руками,
C Ним я навеки сольюсь,
Припев:
А пока живу я мире странником
И с тоской смотрю я в небеса.
С небом связаны мои желания,
С небом связана моя судьба.
Куплет 2:
Мне распахнут райские двери
Радостно скажут: “Входи!”
Всё это будет, твёрдо я верю,
Но это лишь впереди.
Куплет 3:
Там навсегда скорби забуду,
В небе Господь наш царит.
Там с Иисусом вечно я буду
В сладком общении жить,', 'Куплет 1:
G Em
C D
G Em
C D
Припев:
G D Am Em
G D Am H
G D Am Em
G D Am H7 Em
Куплет 2:
G Em
C D
G Em
C D
Куплет 3:
G Em
C D
G Em
C D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=216 | photo=notion-youth-songbook | notionPageId=669d8c71-70f4-402b-abce-2d4e43049663 | notionChordPageId=a01613c0-eee6-44b8-988d-d92b98c6a229 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/669d8c7170f4402babce2d4e43049663', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Там, далеко, за облаками'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=216%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Творящий чудеса', 'Молодёжный сборник', NULL, 'Куплет 1:
Каждый миг и каждый час
Ты царствуешь на небесах,
Великий Бог, Великий Царь.
И на земле в руках твоих
Ты держишь нас, ты нас хранишь
И чудеса свои творишь.
Припев:
Творящий чудеса,
Творящий чудеса,
Ты Бог, творящий чудеса.
Куплет 2:
О, Дух святой, прошу Тебя
Приди ко мне, о, верю я –
Изменишь Ты всю жизнь мою.
Иисуса кровь сильней греха,
Отца любовь ведет меня
В Твои святые небеса.', 'Куплет 1:
E H
C#m A
E H C#m E
E H
C#m A
E H C#m E
Припев:
A H
E C#m
A H E
Куплет 2:
E H
C#m A
E H C#m E
E H
C#m A
E H C#m E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=217 | photo=notion-youth-songbook | notionPageId=bffc3ed8-ea00-46ff-8ca5-190494925991 | notionChordPageId=f3b20c1a-ddf2-4356-8c54-b4815f01a767 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bffc3ed8ea0046ff8ca5190494925991', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Творящий чудеса'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=217%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Твоя любовь', 'Молодёжный сборник', NULL, 'Куплет 1:
Твоя любовь границ не знает
И ярче солнца свет Твой мне.
В Твоем общеньи отдыхаю,
Тебя люблю, Господь, пою Тебе!
Припев:
Господь мой, я Тебя прославляю
Господь мой, Ты Спаситель души моей
Господь мой, я Тебя воспеваю
Господь мой, Ты достоин хвалы
Только Ты, только Ты!
Куплет 2:
Вся жизнь моя в Тебе сокрыта,
Я льну к Тебе, мой добрый Бог.
Твоим теплом душа согрета,
Мне хорошо с Тобой, навек я Твой!', 'Куплет 1:
A E F#m
D A Hm E
A E F#m
D A Hm E
Припев:
A D
Hm F#m E
A D
Hm F#m E
E D A
Куплет 2:
A E F#m
D A Hm E
A E F#m
D A Hm E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=218 | photo=notion-youth-songbook | notionPageId=8ad13cfb-9d39-459e-9a01-8c4702992c48 | notionChordPageId=20d4bf9a-41a8-4e64-982f-57a2023221ff | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/8ad13cfb9d39459e9a018c4702992c48', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Твоя любовь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=218%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Тихо погас в ночи закат', 'Молодёжный сборник', NULL, 'Куплет 1:
Тихо погас в ночи закат,
Сад Гефсиманский сном объят
Всеми оставлен и забыт
Сын Божий там душой скорбит…
Нет рядом с Ним учеников,
И пот багряный, словно кровь,
С лица Его на камни тёк.
Поверить трудно, что Он - Бог.
Поверить, что Он - Бог.
Припев:
Кто ты? Чтобы так страдать.
Кто ты? Как же нам понять.
Ты - Бог, молишься скорбишь,
Твой час настал, за всех умирать.
Мост:
Лишь только камни видя кровь,
Смогли понять, что есть любовь,
Но только сердце у людей
Куда холоднее камней,
холоднее камней.', 'Куплет 1:
G Am Em
G Am Em
G Am H7
Em C
G Am Em
G Am Em
G Am H7
Em C
Am H7
Припев:
Am Em C Em
Am Em C D
Am Em C Em
Am G D Em
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=219 | photo=notion-youth-songbook | notionPageId=ae645ce9-004a-482c-b9e9-a32c2ae727e0 | notionChordPageId=00d6b202-3668-4e85-8ff4-5cd6bc86b025 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/ae645ce9004a482cb9e9a32c2ae727e0', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Тихо погас в ночи закат'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=219%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Тихо у гроба, очень рано', 'Молодёжный сборник', NULL, 'Куплет 1:
Тихо у гроба очень рано,
Жены спешат, предваряя рассвет…
Вдруг Ангел с неба, камень отвален,
Душу согрел воскресения свет.
Припев:
Он воскрес! Победно воссиял,
Искупителем для многих стал;
Он воскрес! Спасенье всем принес,
Воскресший чудно Иисус Христос!
Куплет 2:
Кто превозможет, разве возможно
Господа славы в плену удержать?
Кто с Ним воскрес, тот верою может,
Кровью Христовой врага побеждать.
Куплет 3:
Праздник спасенных, звуки восторга,
Церкви Христовой Пасхальный привет!
Радость Святая всех да наполнит
Места тревогам в душе больше нет.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=220 | photo=notion-youth-songbook | notionPageId=69843e29-936e-4e0e-9781-2f4c9dfde2ad | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/69843e29936e4e0e97812f4c9dfde2ad | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Тихо у гроба, очень рано'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=220%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Только Ты Один', 'Молодёжный сборник', NULL, 'Куплет 1:
Только Ты Один
Так коснулся сердца моего,
Твоя милость, как живая река,
К вечности течёт.
Припев:
Слава, слава Тебе,
За Голгофу и за кровь.
Слава, слава Тебе,
За жизнь Твою, Иисус Христос.
Куплет 2:
Только Ты Один
На Голгофе жизнь отдал за меня.
И стекает драгоценная кровь
Агнца Божия.
Куплет 3:
Только Ты Один
Мне отдал сокровища Свои,
Небеса открыты передо мной,
Я иду домой!', 'Куплет 1:
F C Dm
A# C
F C Dm
A# C F
Припев:
F C Dm
A# C
F C Dm
A# C F
Куплет 2:
F C Dm
A# C
F C Dm
A# C F
Куплет 3:
F C Dm
A# C
F C Dm
A# C F', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=221 | photo=notion-youth-songbook | notionPageId=5275a87a-39a4-441d-b421-3bcd295baf4b | notionChordPageId=4104048d-2fbc-495b-af15-e54effc0ab83 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5275a87a39a4441db4213bcd295baf4b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Только Ты Один'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=221%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты воскрес и дал нам жизнь', 'Молодёжный сборник', NULL, 'Куплет 1:
Торжествуют небеса, торжествует вся земля
Свершилось и любовь Отца искупила нас
Рано утром в третий день Иисус Христос воскрес,
Узы смерти Он на веки победил.
Припев:
Ты воскрес и дал нам жизнь
Искупил Своею кровью,
Все грехи наши простив
Ты воскрес и дал нам жизнь.
Мост:
||: Величественный Царь, Спаситель верный
Благодарю Тебя за эту жертву. :||
Тот кто в мир пришёл с небес,
Царь царей Господь всесильный
Иисус Христос воскрес! Иисус Христос воскрес!', 'Куплет 1:
D G A
D G A
Hm A D G
Hm G A
Припев:
D A
Em Hm
D A
G A
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=222 | photo=notion-youth-songbook | notionPageId=86bc0568-47cc-407b-a978-20929b5cc17d | notionChordPageId=c897b374-3efe-4cb4-9457-3119560cea6c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/86bc056847cc407ba97820929b5cc17d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты воскрес и дал нам жизнь'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=222%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты знаешь, Боже', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты знаешь, Боже, моё желанье,
Мои молитвы слышишь Ты.
Тебе известно мое страданье,
Мои стремленья и мечты.
Куплет 2:
Ты знаешь, Боже, что не ищу я
Богатств и почестей земных.
Моим всем сердцем Тебя люблю я,
Хочу с Тобой быть каждый миг.
Куплет 3:
Скорблю я часто, душа томится,
Не вижу радости бытья.
Я одинокий, как в клетке птица,
И умолкает песнь моя.
Куплет 4:
Никто не знает, не спросит даже
Куда и что меня влечёт,
И кто утешит, кто путь укажет,
Когда на сердце тяжкий гнёт?
Куплет 5:
Мне мир чужим стал, и я — для мира.
О, Боже, дай мне Твой покой!
Устал бороться, слабеют силы,
А путь далекий предо мной.', 'Куплет 1:
Dm
Dm Gm C F
Gm Dm
Dm A Dm
Куплет 2:
Dm
Dm Gm C F
Gm Dm
Dm A Dm
Куплет 3:
Dm
Dm Gm C F
Gm Dm
Dm A Dm
Куплет 4:
Dm
Dm Gm C F
Gm Dm
Dm A Dm
Куплет 5:
Dm
Dm Gm C F
Gm Dm
Dm A Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=223 | photo=notion-youth-songbook | notionPageId=019eaf94-0b3f-4fb5-aea5-7a313bd15430 | notionChordPageId=2163f79c-9666-42f9-b7a6-739a8db250d5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/019eaf940b3f4fb5aea57a313bd15430', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты знаешь, Боже'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=223%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты искупил мир от греха', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты искупил мир от греха,
Ты дал ему любовь и свет.
Зажег потухшие сердца
И дал надежду.
Мы пред Тобою предстоим,
И каждый дорог для Тебя.
За все Отец благодарим
И превозносим.
Припев:
Слава Тебе и величье,
Слава в веках и народах.
Сила Твоя безгранична,
Милость Твоя во все роды.
Куплет 2:
Ты открываешь новый мир,
Любви, Надежд и чистоты.
С тобой не трудно мне идти,
Ведь ты со мною.
Твоя любовь меня хранит,
Дает надежду и покой,
И потому сердца людей,
Полны хвалою.', 'Куплет 1:
G D Em
Em C
C Am
Am D
G D Em
Em C
C Am
Am D
Припев:
G D
Em D
C G
Am D
Куплет 2:
G D Em
Em C
C Am
Am D
G D Em
Em C
C Am
Am D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=224 | photo=notion-youth-songbook | notionPageId=2d868f4a-8345-407e-bb81-f7b33375971d | notionChordPageId=c851ae1d-2eb3-4638-a083-cf3c7f66fc77 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/2d868f4a8345407ebb81f7b33375971d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты искупил мир от греха'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=224%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты куда идешь, скажи мне', 'Молодёжный сборник', NULL, 'Куплет 1:
"Ты куда идешь, скажи мне,
Странник с посохом в руке?" -
"Дивной милостью Господней
К лучшей я иду стране.
Через горы и долины, через степи и поля,
Чрез леса и чрез равнины я иду домой, друзья".
Куплет 2:
"Странник, в чем твоя надежда
В той стране твоей родной?" -
"Белоснежная одежда
И венец весь золотой.
Там источники живые и небесные цветы,
Я иду за Иисусом через жгучие пески".
Куплет 3:
"Страх и ужас не знакомы
Разве на пути тебе?" -
"Да, но Божьи легионы
Охранят меня везде!
Иисус Христос со мною, Он направит Сам меня
Неуклонною тропою прямо, прямо в небеса".
Куплет 4:
"Так возьми ж меня с собою,
Где чудесная страна". -
"Да, мой друг, пойдем со мною,
Вот тебе моя рука!
Недалеко уж родная и желанная страна.
Вера чистая, живая нас введет с тобой туда".', 'Куплет 1:
C
F G
F G
C
F G C Am
F G C G C
Куплет 2:
C
F G
F G
C
F G C Am
F G C G C
Куплет 3:
C
F G
F G
C
F G C Am
F G C G C
Куплет 4:
C
F G
F G
C
F G C Am
F G C G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=225 | photo=notion-youth-songbook | notionPageId=97253e46-0aba-4ab2-aefd-396654dad216 | notionChordPageId=4aef0575-93d9-4f54-9963-e4821c88fdf9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/97253e460aba4ab2aefd396654dad216', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты куда идешь, скажи мне'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=225%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты любишь меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты никогда не предашь меня,
В тревожные дни не оставишь меня.
Не вырвет никто из Твоей руки,
Всё потому, что Ты любишь меня.
Припев:
В бурю и ураган, в стужу, дожди и зной
Рядом Иисус со мной, потому что Ты любишь меня.
Куплет 2:
В страже ночной пребываешь со мной,
Силы даёшь на пути домой,
Плачешь со мной, если беда
Всё потому, что Ты любишь меня.
Куплет 3:
Если в душе забываю Тебя,
Молишься Ты день и ночь за меня.
Ведь Ты никогда не предашь меня.
Всё потому, что Ты любишь меня.
Куплет 4:
Всё потому, что Ты любишь меня
Сердце моё славит Тебя.
В руки Твои себя отдаю,
Всё потому, что Тебя я люблю.', 'Куплет 1:
Hm Em
F#7 Hm
Hm Em
Hm F#7 Hm
Припев:
H7 Em A7 D
Hm Em Hm F#7 Hm
Куплет 2:
Hm Em
F#7 Hm
Hm Em
Hm F#7 Hm
Куплет 3:
Hm Em
F#7 Hm
Hm Em
Hm F#7 Hm
Куплет 4:
Hm Em
F#7 Hm
Hm Em
Hm F#7 Hm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=226 | photo=notion-youth-songbook | notionPageId=f9143efd-b3e1-41d8-9c99-0fc766b9b23c | notionChordPageId=76450584-b4ce-4c02-a212-bd42460b6cd3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f9143efdb3e141d89c990fc766b9b23c', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты любишь меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=226%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты меня наполни', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты меня наполни святостью Твоей.
Пусть меня исполнит Дух Твой как елей.
Я всего лишь человек – словно пыль перед Тобой,
Но в Твоих руках я нахожу покой.
Ты всегда был рядом, когда я страдал,
Посылал надежду, веру укреплял.
И нет слов, чтоб описать полноту любви Твоей
Как прекрасен Ты, Господь души моей.
Припев:
Ты скажи мне, Боже, кто я есть
По сравнению с Тобой?
Ты слепящий яркий солнца свет
Можешь скрыть Своей рукой.
И сиянье неба и дождя
И росток в сухой земле
Мне ответят снова, что нигде
Нет подобного Тебе!
Куплет 2:
Я нашёл свободу, став твоим рабом.
Я обрёл спасенье, став Твоим дитём.
Мои сердце и любовь я кладу к ногам Твоим,
Только Ты достоин Богом быть моим.
Твое имя велико по всей земле.
Твоя слава не смолкает в вышине,
Пусть ещё одна душа вдруг увидит и поймёт,
Что её Создатель в небесах живёт.', 'Куплет 1:
E H A H
E H A H
C#m A E
A H E
E H A H
E H A H
C#m A E
A H E
Припев:
E A
H E
E A
H E
C#m A
H E
C#m A
H E
Куплет 2:
E H A H
E H A H
C#m A E
A H E
E H A H
E H A H
C#m A E
A H E
Припев:
E A
H E
E A
H E
C#m A
H E
C#m A
H E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=227 | photo=notion-youth-songbook | notionPageId=b1c38c38-cad2-4e03-9a59-f3ef24fe5854 | notionChordPageId=2b6324e5-7922-4bbd-9e03-f62102630c70 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/b1c38c38cad24e039a59f3ef24fe5854', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты меня наполни'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=227%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты мой Бог', 'Молодёжный сборник', NULL, 'Куплет 1:
Тебя люблю, мой Бог, я всей душою,
И с каждым новым днём хочу любить сильней,
Люблю Тебя за то, что Ты со мною
И говоришь со мной с любовью неземной.
Припев:
Ты мой Бог, крепость моя,
В руках Твоих сила моя.
Куплет 2:
Меня Ты никогда не оставляешь
И голос слышу Твой звучит в душе моей:
"Благословлю тебя, коль ты благословляешь,
И силы не жалей, других люби сильней"
Куплет 3:
И снова слышу голос Твой чудесный:
"Во всём будь совершенным, человек,
Как совершенный наш Отец Небесный.
Надейся, верь, люби и будешь жить вовек"', 'Куплет 1:
Dm Gm A Dm
Dm Gm C F
D7 Gm A A#
A# Gm A Dm A
Припев:
Dm Gm A Dm
A# Gm A Dm
Куплет 2:
Dm Gm A Dm
Dm Gm C F
D7 Gm A A#
A# Gm A Dm A
Куплет 3:
Dm Gm A Dm
Dm Gm C F
D7 Gm A A#
A# Gm A Dm A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=228 | photo=notion-youth-songbook | notionPageId=29bc4497-0452-4b02-9bf9-e787b4160243 | notionChordPageId=434932f5-5d60-4285-97a0-8221c9eb3575 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/29bc449704524b029bf9e787b4160243', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты мой Бог'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=228%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты моя скала', 'Молодёжный сборник', NULL, 'Куплет 1:
Нет силы, Господи, не могу я так дальше жить,
Когда враг на пути моем все время стоит.
Я взываю к Тебе: помоги мне в земной борьбе
Устоять на пути Твоём и служить Тебе.
Припев:
Я верю, Ты моя скала,
Ты сохранишь меня в пути,
И когда будет тяжело, поможешь Ты.
С Тобой не страшно мне в пути,
С Тобой пойду на край земли,
С Тобою обрету покой в земном пути
Куплет 2:
Я счастлив, что со мной и в жизни Ты Господи,
Мне так легко с Тобой и хорошо.
Я так хочу, всей жизнью Тебе служить,
И врага победить с Тобой, Спаситель мой.', 'Куплет 1:
G C D Hm
Em C D G
G C D Hm
Em C D G
Припев:
C D
Hm Em
C D G
C D
Hm Em
C D G
Куплет 2:
G C D Hm
Em C D G
G C D Hm
Em C D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=229 | photo=notion-youth-songbook | notionPageId=d1da57c6-31c4-4f96-9965-6eb3712dddd7 | notionChordPageId=aa963a46-a46c-4d84-8ee2-7754a2e33890 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/d1da57c631c44f9699656eb3712dddd7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты моя скала'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=229%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты над городом этим', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты над городом этим, и над этим народом,
И над этой страною, Господь.
Ты во тьме освешаешь, озаряешь надеждой,
Утешаешь собою, Господь.
Нет такого, как наш Бог!
Нет такого, как наш Бог!
Припев:
Грядёт пора больших чудес,
Господь прольёт благодать с небес в этот город.
Грядёт пора больших чудес,
Господь прольёт благодать с небес здесь.', 'Куплет 1:
C G
Am F
C G
Am F
C G F
Am G F G
Припев:
F
G C F G
F
G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=230 | photo=notion-youth-songbook | notionPageId=1d693207-a395-4212-8ca5-e8a0e69b1d85 | notionChordPageId=f58af63e-aa0a-4fdc-9337-755a30b83dbd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1d693207a39542128ca5e8a0e69b1d85', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты над городом этим'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=230%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты не одинок', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты идешь, в душе печаль,
Ты идешь, не замечая никого вокруг.
Утро снова сменит ночь,
Быстро дни уходят прочь и ты один,
Но ты поверь, что…
Припев:
||: Ты не одинок, с тобою рядом Бог,
Знает Он печаль твою, Его глаза полны любви :||
Ты не одинок!
Куплет 2:
Посмотри в Его глаза,
Вспомни, как Христос сказал: «С тобою Я всегда».
Не оставлю никогда,
Пронесу сквозь бури, грозы, холода,
Ты лишь поверь, что…', 'Куплет 1:
F
Dm A# C
F
Dm A#
C
Припев:
F Dm
A# C
F
Куплет 2:
F
Dm A# C
F
Dm A#
C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=231 | photo=notion-youth-songbook | notionPageId=1002d3ae-dd74-4365-8b81-5f24ff6080ab | notionChordPageId=e3c4559f-c0a4-4262-9625-964d257dd522 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1002d3aedd7443658b815f24ff6080ab', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты не одинок'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=231%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты не печалься', 'Молодёжный сборник', NULL, 'Куплет 1:
Я постигаю сквозь слезы и боль
Радость встречи и горечь разлуки.
Пью эту чашу, где сладость и соль,
Перемешались надежда и муки.
Припев:
Ты не печалься, не беспокойся,
Если Бог с нами - чего бояться?
Ты не печалься, не беспокойся,
Если Бог с нами.
Куплет 2:
Свободу ищу из железных оков,
Тех, что зовутся житейское счастье.
Вся моя жизнь - это несколько слов
В тихой молитве перед причастьем.
Куплет 3:
И не жалея о прошлом ничуть,
Вижу как катится мир к катастрофе.
Верую в крестный мной избранный путь,
В тайну распятой любви на Голгофе.', 'Куплет 1:
Em C D G
C Am H7 Em
Em C D G
C Am H7 Em
Припев:
Em Am D G
C Am H7 Em
Em Am D G
Em Am H7 Em
Куплет 2:
Em C D G
C Am H7 Em
Em C D G
C Am H7 Em
Куплет 3:
Em C D G
C Am H7 Em
Em C D G
C Am H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=232 | photo=notion-youth-songbook | notionPageId=1ae74b5e-451d-41db-80bb-6d34bae241e6 | notionChordPageId=1e6c4867-9636-43a9-b558-a7782400450e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1ae74b5e451d41db80bb6d34bae241e6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты не печалься'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=232%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты объемлешь меня', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты объемлешь меня позади, впереди,
Полагаешь на мне руку.
Куда б не пошел, лик Твой будет со мной,
Не укроюсь я от Духа.
Припев:
Взойду ли я на небо - Ты там, Господь,
Сойду ли в преисподню - Ты там, Господь.
Поднимусь ли я на крыльях зари -
Даже там ведом Тобою, любящей Твоей рукою, Господь.
Куплет 2:
Славлю, Боже, Тебя и твои все дела,
Ибо дивно я устроен.
Отдыхаю ли я или путь свой держу,
Ты всегда везде со мною.', 'Куплет 1:
C Am
Dm G
C Am
Dm G
Припев:
Am Em F C
Am Em F C
Am Em F
Dm G Dm G
Куплет 2:
C Am
Dm G
C Am
Dm G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=233 | photo=notion-youth-songbook | notionPageId=944bb88a-3df9-4fd3-ae99-f1d6afc4a092 | notionChordPageId=ee67f966-fdde-48cb-a2ed-ed15dfba3abd | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/944bb88a3df94fd3ae99f1d6afc4a092', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты объемлешь меня'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=233%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты оплот моего спасенья', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты оплот моего спасенья,
Сила жизни моей.
Свободу даешь Ты и вдохновенье.
Взываю к Тебе Я, Господь.
Припев:
Верю я в Тебя, верю я,
И люблю, Господь, Тебя!
Помощь Ты моя, спасение
К Тебе, Господь, я иду.
Куплет 2:
Ты утешаешь и вдохновляешь
Душу мою всегда.
Каждый мой шаг в совершенстве знаешь:
Откуда иду и куда.
Куплет 3:
Рядом с Тобою, с Твоею любовью
Песню хвалы я пою.
Сердцем желаю я быть с Тобою
В дивном вечном раю.', 'Куплет 1:
Em F#m Hm
G A Hm
Em F#m Hm
Hm A Hm
Припев:
G A F#m Hm
G A Hm
G A F# Hm
Em G F#
Куплет 2:
Em F#m Hm
G A Hm
Em F#m Hm
Hm A Hm
Куплет 3:
Em F#m Hm
G A Hm
Em F#m Hm
Hm A Hm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=234 | photo=notion-youth-songbook | notionPageId=a45c3033-e8c8-4cc9-98d5-7313c1cc408b | notionChordPageId=adffa1bc-6992-48af-ba4d-85df9ac39128 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/a45c3033e8c84cc998d57313c1cc408b', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты оплот моего спасенья'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=234%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Ты с нами Бог', 'Молодёжный сборник', NULL, 'Куплет 1:
Из глубин души моей льётся песня о Тебе,
Ты - Господь, кто всех милей в судьбе моей
Век проходит, время мчится, в сердце Божья благодать
Ну а песню, словно птицу, невозможно удержать.
Припев:
Ты с нами Бог, Ты с нами Бог.
Славим имя Христа - нашей веры исток.
Ты с нами Бог, Ты с нами Бог.
В пылком сердце наша вера прорастет как колосок
Ты с нами Бог.
Куплет 2:
Воздух песнею наполнен отовсюду голоса
Пусть её нам подпоют леса, поля.
Это песня о спасении, о любви на всей земле,
О великом искуплении, о тебе и обо мне,
Куплет 3:
В нашем сердце Бог и в песне, и в росинке, и в слезе,
В счастье, в горе, с нами вместе, в солнце и грозе.
Пойте реки, пойте горы и равнины и моря.
Имя Господа и веру снова прославляю я.', 'Куплет 1:
Am G
Dm Am E
Am G
Dm F E
Припев:
Am F
G E
Am F
G E
Am
Куплет 2:
Am G
Dm Am E
Am G
Dm F E
Куплет 3:
Am G
Dm Am E
Am G
Dm F E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=235 | photo=notion-youth-songbook | notionPageId=0983af7f-3542-4656-810a-c525e2795c9d | notionChordPageId=3dcc744f-9e52-4b03-8e51-f9967a458dff | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0983af7f35424656810ac525e2795c9d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Ты с нами Бог'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=235%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Умчались безвозвратно', 'Молодёжный сборник', NULL, 'Куплет 1:
Умчались безвозвратно дни вчерашние,
Одни следы оставив за собой,
А в них вопрос, звучащий без пристрастия:
«С чем мы вступаем в новый день с тобой?»
Припев:
Пока не прекратились дни погожие,
Спешите, ведь откладывать нельзя.
Спешите сделать что-нибудь хорошее
Во имя Господа, мои друзья.
Куплет 2:
Спешите ободрить душой уставшего,
Для счастья ближних жертвуйте собой,
И пламенные искры сердца вашего
Зажгут в других большой любви огонь!
Куплет 3:
Быть может, тяжкой ношей обессиленный,
Ваш брат одолевает жизни тьму.
Вы сделайте, что можете посильное,
Чтоб стало легче хоть чуть-чуть ему.
Куплет 4:
Сердечное участье бескорыстное
Полно душевной нежной теплоты.
И ваша доброта, и ваша искренность
Помогут ближним счастье обрести.', 'Куплет 1:
A E
Hm E A
A Hm
D E7
Припев:
A C#7 F#m
D Hm E7
A C#7 F#m
D A E7 A
Куплет 2:
A E
Hm E A
A Hm
D E7
Куплет 3:
A E
Hm E A
A Hm
D E7
Куплет 4:
A E
Hm E A
A Hm
D E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=236 | photo=notion-youth-songbook | notionPageId=de450ee5-ff11-4ae1-bb5d-efe54d24f146 | notionChordPageId=0b24df87-9d56-44c0-bde1-6e2a21c72bf5 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/de450ee5ff114ae1bb5defe54d24f146', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Умчались безвозвратно'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=236%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Упала слеза', 'Молодёжный сборник', NULL, 'Куплет 1:
Упала слеза на горячий песок,
И кровь на ланитах застыла.
Полдневное солнце, как красный цветок,
Казалось в зените застыло.
Припев:
Так только мог Всемогущий Отец
Отдать на заклание Сына.
Такая любовь для отцовских сердец
Воистину не постижима!
Куплет 2:
Гремели доспехи, звенели мечи
Блестели на солнце палящем.
И громко смеялись, бранясь, палачи
Над Агнцем, на древе висящем.
Куплет 3:
Когда Он любил, не любили Его;
Когда Он прощал, проклинали.
Возмездьем за зло не воздал никому
И тем, кто Его распинали.
Мост:
За всё человечество кровь пролилась
Ценой бесконечно бесценной.
Голгофа над грешной землёй поднялась
И сделалась центром вселенной.', 'Куплет 1:
Am E7 G D
F C E
Am E7 G D
F C E
Припев:
Am F C G
Am F G
Am F C G
F G Am
Куплет 2:
Am E7 G D
F C E
Am E7 G D
F C E
Куплет 3:
Am E7 G D
F C E
Am E7 G D
F C E
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=237 | photo=notion-youth-songbook | notionPageId=4b68d35b-cfe0-4fe2-9bda-d23c3c9b28bf | notionChordPageId=41cecc96-465d-4783-9812-545b17a079f6 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4b68d35bcfe04fe29bdad23c3c9b28bf', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Упала слеза'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=237%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Хвали Творца', 'Молодёжный сборник', NULL, 'Куплет 1:
Хвали Творца лишь день начнётся,
Хвали когда земля проснётся,
С восходом солнечным хвали,
Хвалу приемлет Бог любви
Припев:
Хвала Творцу земли, хвала Творцу небес,
Хвала Тебе за всё, великий Бог-Отец,
Прими хвалу сердец за Сына и за крест,
За щедрый Дух Святой, за милость и покой.
Куплет 2:
Хвали Творца за все создание,
За пенье птиц и щебетанье,
И с общим хором слей свой дух,
Бог близок, Божий всюду слух
Куплет 3:
Хвали Творца, как солнце светит,
Хвали и ночью, Он заметит.
И в день, и в ночь твой чистый дар,
Молитвы шёпот, сердца жар.', 'Куплет 1:
F C
D Gm C
Dm A A#
F C F
Припев:
F Dm
Gm C
F D
Gm A#m F
Куплет 2:
F C
D Gm C
Dm A A#
F C F
Куплет 3:
F C
D Gm C
Dm A A#
F C F', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=238 | photo=notion-youth-songbook | notionPageId=5c861015-5dd1-4060-b4ee-71fe10b7d1d9 | notionChordPageId=3b22852b-913b-4a56-b79d-c4b14195404c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/5c8610155dd14060b4ee71fe10b7d1d9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Хвали Творца'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=238%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Храни своё сердце чистым', 'Молодёжный сборник', NULL, 'Куплет 1:
Много в мире искушений,
Много разного того,
Что предшествует паденью,
Что от Бога далеко.
Припев:
Храни своё сердце чистым,
Мысли и совесть от зла береги.
Храни своё сердце чистым
Во все земные дни.
Куплет 2:
Мир без Бога пропадает,
Называет зло добром,
И в оковах погибает,
Что зовёт Господь грехом.
Куплет 3:
Будем мы всегда во свете
Слова Божьего ходить,
Как Его святые дети,
Под Его охраной жить.', NULL, NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=239 | photo=notion-youth-songbook | notionPageId=773042ed-874e-4ba6-a201-454235315956 | status=notion-lyrics | confidence=notion-page-lyrics | Notion: https://blagochestie.notion.site/773042ed874e4ba6a201454235315956 | Fill chords from an approved source before approval.', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Храни своё сердце чистым'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=239%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Христос мой, как о Тебе молчать', 'Молодёжный сборник', NULL, 'Куплет 1:
Христос мой, как о Тебе молчать,
Как Тебя не благодарить.
Ведь Ты дал право Тебя познать
И Твой свет всем людям дарить.
Припев:
Не покидай меня, я быть хочу с Тобой
Каждый день, и час, и миг земной.
Руку подай любя, в вечность веди меня,
В мир счастья, солнечного дня.
Куплет 2:
Творец мой, Ты для людей лишь миф,
Для меня - Спаситель Христос,
Создатель неба, планет и звезд,
Утешитель горя и слез.
Куплет 3:
Всевышний, Ты нас благослови
Для труда во имя Христа.
Пошли нам больше дара любви,
Чтоб не смолкли наши уста.', 'Куплет 1:
C G
Dm G C G
C G
Dm G C
Припев:
Am Em
F G C
Am Em
F G C
Куплет 2:
C G
Dm G C G
C G
Dm G C
Куплет 3:
C G
Dm G C G
C G
Dm G C', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=240 | photo=notion-youth-songbook | notionPageId=0833d9f8-5398-4c05-9ea1-e36c0295c6db | notionChordPageId=82990700-4b26-4c79-b868-bd4b81463d79 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/0833d9f853984c059ea1e36c0295c6db', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Христос мой, как о Тебе молчать'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=240%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Христос, для многих', 'Молодёжный сборник', NULL, 'Куплет 1:
Христос, для многих Ты людей - легенда,
А для моей Ты жизни - идеал,
Мне дорога священная минута,
С которой для меня Ты другом стал.
Ты - жизнь моя и больше жизни нету,
Я без Тебя давно б уже не жил,
Тебе доверив жизнь, пришёл я к свету,
В Тебе нашёл существованья смысл.
Куплет 2:
Держаться за Тебя хочу я крепко,
Ведь Ты для грешников стал постижим,
А дьявол часто ранит в сердце метко,
И Ты, Иисус, мне так необходим.
Прости, Иисус, меня, что сил так мало,
В борьбе с грехом теряю я Тебя,
Я вновь найду тебя во чтоб ни стало -
Ты только лишь не покидай меня.
Куплет 3:
Порой мне грустно, скучно, одиноко,
Когда Тебя не вижу впереди,
Прошу, Иисус, не уходи далёко,
Ты для меня, что сердца стук в груди.
Ты – жизнь, я жить одним Тобой желаю,
Всем сердцем научи Тебя любить,
Служить Тебе до смерти обещаю
И посреди неверья верным быть.', 'Куплет 1:
G Am
D G
G Am
D G
G Am
D G
G Am
D G
Куплет 2:
G Am
D G
G Am
D G
G Am
D G
G Am
D G
Куплет 3:
G Am
D G
G Am
D G
G Am
D G
G Am
D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=241 | photo=notion-youth-songbook | notionPageId=56a11c3b-b549-44ca-a830-9a437c070e38 | notionChordPageId=ad709fcb-3a85-4679-8997-7e6f7bdf7a67 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/56a11c3bb54944caa8309a437c070e38', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Христос, для многих'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=241%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Христос, кто бы знал', 'Молодёжный сборник', NULL, 'Куплет 1:
Христос, кто бы знал Твое имя здесь,
На этой планете печальной,
Пришел, оказался Ты жертвою,
Чтоб знал Тебя ближний и дальний.
Припев:
Христос - это имя мне дорого,
Христос - это имя мне мило,
Христос, Ты не хочешь ни одного
Оставить в оковах греха.
Куплет 2:
Распят… на Голгофу ты взгляд свой брось,
Постой, посмотри молчаливо,
Там Кровь за тебя и меня лилась,
Чтоб мы были счастливы.
Куплет 3:
Христос, освяти как всегда Ты нас,
В любви, чтоб не были пустыми,
И тех, кто услышит весть в первый раз,
Прими в объятья святые.', 'Куплет 1:
Am Dm
E Am
F Dm
E E7
Припев:
Am Dm
G C E
Am Dm
E Am
Куплет 2:
Am Dm
E Am
F Dm
E E7
Куплет 3:
Am Dm
E Am
F Dm
E E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=242 | photo=notion-youth-songbook | notionPageId=1a0ea6ba-ef18-4ab2-b7b3-b2c4612df49f | notionChordPageId=9caf2352-2b76-4e88-a32d-9d9727f5de92 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/1a0ea6baef184ab2b7b3b2c4612df49f', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Христос, кто бы знал'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=242%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Чакаем Цябе, наш Ісус,', 'Молодёжный сборник', NULL, 'Куплет 1:
Чакаем Цябе, наш Ісус,
І молім: прыйдзі Ты да нас.
Мы любім сваю Беларусь,
І хочам, каб Ты яе спас.
Припев:
Прыйдзі ў яе Ты двары,
У вёскі прыйдзі, у гарады,
Жыві ў яе сэрцы, Ісус,
Чакае Цябе Беларусь!
Куплет 2:
Засмучана моцна яна,
Нялёгкі дастаўся ёй лёс.
І колькі ўжо слёз праліла,
Суцеш яе, любы Хрыстос!
Куплет 3:
У грахах яе гіне народ,
Няпраўда, як цемень, лягла.
Знімі ж, Ісус, гэты гнёт,
І вызваль ад лютага зла.
Куплет 4:
Як добра з Табою, Ісус,
Як хораша там, дзе Ты ёсьць,
Няхай Табе ўся Беларусь
Аддасьць сваё сэрца і лёс!', 'Куплет 1:
Dm Gm
A Dm
F C
A# A
Припев:
Gm Dm
F C
Gm Dm
A Dm
Куплет 2:
Dm Gm
A Dm
F C
A# A
Куплет 3:
Dm Gm
A Dm
F C
A# A
Куплет 4:
Dm Gm
A Dm
F C
A# A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=243 | photo=notion-youth-songbook | notionPageId=432af77c-3248-4865-8e62-7cf90a920340 | notionChordPageId=90bd82aa-5bca-4133-8dcb-5280d6604fea | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/432af77c324848658e627cf90a920340', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Чакаем Цябе, наш Ісус,'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=243%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Что вера без дел?', 'Молодёжный сборник', NULL, 'Куплет 1:
Что вера без дел? Это звук лишь пустой,
Цветок рукодельный, цветок не живой.
То дерево с пышной листвой без плода,
Мираж изобилья где скудость, нужда.
Напрасны ученья, напрасны слова,
Ведь вера без дел перед Богом мертва.
Лишь вера несущая плод для Христа,
Велика, могуча, пред Богом свята.
Припев:
Господь с высоты наше сердце проверь,
Поведай, какая в нас вера теперь.
О вере с плодами, о вере живой
Тебя умоляем, Создатель благой.
Куплет 2:
И если нет веры, то жизни в нас нет
И к Богу напрасно взываем в мольбе
Лишь с верою дело угодно Отцу
Труд сына Господь направляет к венцу.
Бог хочет увидеть иные дела
Чтоб жизнь твоя Богу угодна была
Чтоб дело твое было веры полно
Начато в молитве и Духе Святом.', 'Куплет 1:
Dm A
F Dm
A# F
Gm A
Dm A
F Dm
A# F
Gm A
Припев:
F C
A# F
F C
A# C
Куплет 2:
Dm A
F Dm
A# F
Gm A
Dm A
F Dm
A# F
Gm A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=244 | photo=notion-youth-songbook | notionPageId=15d38c9c-3ac4-4417-a84b-ac11e85b88ee | notionChordPageId=e1ada5b7-3f54-4baf-bdd8-1fba055cff6f | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/15d38c9c3ac44417a84bac11e85b88ee', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Что вера без дел?'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=244%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Что этот свет', 'Молодёжный сборник', NULL, 'Куплет 1:
Что этот свет – он созданье Всевышнего,
Воля и разум Творца.
Это ль не есть выражение Божьей любви?
Горы, равнины и дали лесистые,
Скалы, овраги и травы душистые,
Утра румянец и ночи мерцание –
Бога создание, Бога дыхание!
Припев:
Звезд дивные алмазы на черный бархат неба
Ты поместил Своей рукой, поместил Своей рукой.
Нет, я еще ни разу столь к Тебе близок не был,
Ты подарил душе покой, подарил душе покой.
Куплет 2:
Что этот мрак, силы вражьей сгущение,
Вечно скрывает свой лик?
Слава, Отец, что не ею дано нам спастись!
Солнце взойдет, тучи черные скроются,
Земли водой дождевою омоются,
Птицы небесные песню Тебе поют,
Имя Твое облекая в гармонию!
Куплет 3:
Что эта жизнь – Божий дар и служение,
Радость и мука души.
Где ты найдешь совокупность столь разных в одном?
Пусть из страданий и счастие строится,
Лишь после смерти награда откроется.
Чаша скорбей производит терпение,
Вся наша жизнь на земле – лишь мгновение!', 'Куплет 1:
Hm
G
D A F#
Hm
G
Em
A F#
Припев:
Hm G D F#
Hm G D F# Hm
Hm G D F#
Hm G D F# Hm
Куплет 2:
Hm
G
D A F#
Hm
G
Em
A F#
Куплет 3:
Hm
G
D A F#
Hm
G
Em
A F#', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=245 | photo=notion-youth-songbook | notionPageId=93a487f7-9f86-4705-99aa-7ff57bfc1943 | notionChordPageId=d8210e9b-9c22-4770-b515-034c6655697c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/93a487f79f86470599aa7ff57bfc1943', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Что этот свет'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=245%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Чуден Он', 'Молодёжный сборник', NULL, 'Куплет 1:
Чуден Он, наш Господь,
Наш Господь, чуден Он.
Царь царей, Божий Сын
Чуден Он, чуден Он.
Куплет 2:
Славен Он наш Господь,
Наш Господь славен Он.
Утешитель, лучший Друг
Славен Он, славен Он.
Куплет 3:
Умер Он наш Господь,
Наш Господь, чуден Он.
На кресте взял мой грех
Умер Он, умер Он.
Куплет 4:
Он воскрес, наш Господь,
Наш Господь, Он воскрес.
Чтоб меня оправдать
Он воскрес, Он воскрес.', 'Куплет 1:
G C
G C
G D Em
G D G
Куплет 2:
G C
G C
G D Em
G D G
Куплет 3:
G C
G C
G D Em
G D G
Куплет 4:
G C
G C
G D Em
G D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=246 | photo=notion-youth-songbook | notionPageId=72115a4b-ac44-423d-8b78-eab83ac6b643 | notionChordPageId=f612ca0f-c2bf-4506-b59d-a9a02f4789cc | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/72115a4bac44423d8b78eab83ac6b643', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Чуден Он'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=246%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Чудную книгу полюбил я', 'Молодёжный сборник', NULL, 'Куплет 1:
Чудную книгу полюбил я
Среди многих книг,
В ней нахожу я утешенье
В самый тяжкий миг.
Слово Твое сокрыл я в сердце
Слово Твое - светильник в темном месте
Слово Твое - вода живая
И там , где Слово, все оживает.
Припев:
Слово Твое — оно как молот,
Слово Твое — огонь и щелок,
Слово Твое — как в сотах мед
Все обновляет и силу дает.
Куплет 2:
Не сравнится  жемчуг моря
С красотой Христа,
Нет прекрасней слов Христовых,
В них вся полнота.
Слово Твое сапфиров краше,
Слово Твое — спасенье наше,
Слово Твое имен всех выше
И только словом Твоим все дышит.
Куплет 3:
Не страшны мне бури жизни
В этом мире зла,
Я к святой иду отчизне,
Бог хранит меня.
Слово Твое как меч из стали,
Слово Твое победу дарит,
Слово Твое — вода живая,
И там , где Слово, все оживает.', 'Куплет 1:
Dm Gm
A Dm
Dm Gm
C F
Gm C
F Dm
Gm A
Dm D
Припев:
Gm C
F Dm
Gm A
A Dm
Куплет 2:
Dm Gm
A Dm
Dm Gm
C F
Gm C
F Dm
Gm A
Dm D
Куплет 3:
Dm Gm
A Dm
Dm Gm
C F
Gm C
F Dm
Gm A
Dm D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=247 | photo=notion-youth-songbook | notionPageId=bdd385cd-16d1-4af7-9f62-4359bf749dbe | notionChordPageId=6e540925-6a08-4fd9-a7a2-2c7a6d474c5b | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/bdd385cd16d14af79f624359bf749dbe', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Чудную книгу полюбил я'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=247%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Шалом, мои друзья', 'Молодёжный сборник', NULL, 'Куплет 1:
Шалом, мои друзья, Храни, Господь, ваш дом!
Пусть в сердце к вам войдет Шалом, шалом!
:,:И хоть не прост порой Тот мир, где мы живем,
Пусть окружает нас Шалом, шалом.:,:
Куплет 2:
Открыта сердца дверь, живет Дух Божий в нем,
И наполняет нас Шалом, шалом.
:,:Улыбками сиять Давайте день за днем,
Приносит радость нам Шалом, шалом.:,:
Куплет 3:
С смирением в сердцах мы к Богу воззовем:
«Пошли, Господь, всем нам Шалом, шалом!»
:,:Нас не смутят пути, которыми пойдем,
Наградой будет нам Шалом, шалом.:,:
Куплет 4:
Войдем мы в град святой, там вечность обретем,
И вместе с ней Господь нам дарует шалом.
:,:Нас не смутят пути, которыми пойдем,
Наградой будет нам Шалом, шалом.:,:', 'Куплет 1:
Em F# H7 Em
Em F# H7 Em D
G D Am Em
Em F# H7 Em D
Куплет 2:
Em F# H7 Em
Em F# H7 Em D
G D Am Em
Em F# H7 Em D
Куплет 3:
Em F# H7 Em
Em F# H7 Em D
G D Am Em
Em F# H7 Em D
Куплет 4:
Em F# H7 Em
Em F# H7 Em D
G D Am Em
Em F# H7 Em D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=248 | photo=notion-youth-songbook | notionPageId=77950ad4-3d34-4124-b334-0ddbda5ef95d | notionChordPageId=3182688e-d066-46d7-9c30-9bcbc963d4d3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/77950ad43d344124b3340ddbda5ef95d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Шалом, мои друзья'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=248%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Это Бог наш', 'Молодёжный сборник', NULL, 'Куплет 1:
Ты вседержитель Бог и Царь
В мире подобных нет Тебе
Ты справедливый, верный, праведный вовек
Создано все Господь Тобой
И в небесах и на земле
Всем управляешь мудро – жизнь в Твоей руке
Кто так свят и справедлив?
Неизменен и велик?
Припев:
Это Бог наш - Царь Всемогущий
Бог наш – Творец Вездесущий
Бог наш - Мудрый и Сильный Господь
Над нами
Это Бог наш - Спасенье для грешных
Бог наш - Любовь и Надежда
Бог наш - Великий и Чудный Господь
Над нами
Куплет 2:
Нас от начала возлюбил
И примирил с Собою Ты
Благодаря Христу, Его святой крови
Ты ввел нас в царствие Своё
Истинный путь нам указал
От власти тьмы избавив Ты свободу дал
Кто есть истина и жизнь?
Кто нас спас, грехи простив?
Мост:
Кто так свят и справедлив?
Неизменен и велик?
Кто есть истина и жизнь?
Кто нас спас, грехи простив?', 'Куплет 1:
G D Em
C G
D Em C
G D Em
C G
D Em C
G C
G C
Припев:
G
D
Em C
C
G
D
Em C
C
Куплет 2:
G D Em
C G
D Em C
G D Em
C G
D Em C
G C
G C
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=249 | photo=notion-youth-songbook | notionPageId=3c7d1d51-eac3-42cc-a699-286cd851a7d7 | notionChordPageId=40829b5c-b3ea-456c-a7fa-d67550e5bb7a | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3c7d1d51eac342cca699286cd851a7d7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Это Бог наш'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=249%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Юность белоснежную', 'Молодёжный сборник', NULL, 'Куплет 1:
Юность белоснежную береги от зла.
Как фиалку нежную пред собой неся.
Миру тьмы лукавому власть не отдавай.
И греху всевластному ты скажи: «прощай».
Куплет 2:
Сердце тебе чистое подарил Христос,
Солнышко лучистое, шум морей и гроз.
И в одежды святости Он тебя одел,
Не испачкай пятнами недостойных дел.
Куплет 3:
Пусть работой чистою годы протекут,
И венцы небесные увенчают труд.
И в святых обителях, получивши жизнь,
На алтарь Спасителя молодость сложи.', 'Куплет 1:
G Am
D G
H Em C
D G
Куплет 2:
G Am
D G
H Em C
D G
Куплет 3:
G Am
D G
H Em C
D G', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=250 | photo=notion-youth-songbook | notionPageId=640cf3be-256d-4b0b-a805-8bfd719abf5d | notionChordPageId=44ba5401-b745-44d4-af83-e8ff353804df | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/640cf3be256d4b0ba8058bfd719abf5d', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Юность белоснежную'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=250%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Юность пройдет', 'Молодёжный сборник', NULL, 'Куплет 1:
Сегодня, друзья, мы вместе
И нам юность дана,
Но она пройдёт незаметно
Когда и куда.
Припев:
Юность пройдёт,
Оставив лишь память,
Память о лучшем
В нашей жизни, друзья.
Куплет 2:
Чтоб было, что вспомнить
Нам о юности, друзья,
Будем жить мы для Иисуса,
Прославлять Его всегда.
Куплет 3:
Посвятим же, друзья сегодня
Наши юные года
Прославлять Отца Всеблагого
За дивные дела.', 'Куплет 1:
Am Dm
G C
F Dm
E
Припев:
Am Dm
G C
F Dm
E Am
Куплет 2:
Am Dm
G C
F Dm
E
Куплет 3:
Am Dm
G C
F Dm
E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=251 | photo=notion-youth-songbook | notionPageId=eb5c1d5f-aac1-43a4-b0f8-9a2367acc5e8 | notionChordPageId=dd4a151a-15b0-4f6a-90c0-b569523d0bf0 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/eb5c1d5faac143a4b0f89a2367acc5e8', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Юность пройдет'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=251%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Юность светлая', 'Молодёжный сборник', NULL, 'Куплет 1:
Юность светлая, весна ранняя -
Мы её Христу принесём,
Молодые мы в золотые дни
Лишь для Господа живём!
Куплет 2:
Тьма неверия окружает нас,
Туча чёрная впереди,
Мы Христа огни в эти злые дни
Расставляем на пути.
Куплет 3:
Хоть и труден путь и тернистый он,
Со Христом его мы пройдём.
Молодые мы в золотые дни
Лишь для Господа живём!
Куплет 4:
О не бойся, друг, не смущайся, брат,
Проходя свой жизненный путь!
Впереди тебя твой Христос прошел
И тебя идти зовет.
Куплет 5:
Так спеши же, друг, посвятить Христу
Утро юности, жизни дни,
И Он даст тебе золотой венец,
Будешь царствовать ты с Ним.', 'Куплет 1:
Hm
Em A D
Em G
F# Hm
Куплет 2:
Hm
Em A D
Em G
F# Hm
Куплет 3:
Hm
Em A D
Em G
F# Hm
Куплет 4:
Hm
Em A D
Em G
F# Hm
Куплет 5:
Hm
Em A D
Em G
F# Hm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=252 | photo=notion-youth-songbook | notionPageId=e96e6d81-5d9b-47ad-aae6-2ae46f0cdb84 | notionChordPageId=711123a2-73e0-433a-9d5a-dce0cedc20dc | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e96e6d815d9b47adaae62ae46f0cdb84', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Юность светлая'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=252%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я без Тебя', 'Молодёжный сборник', NULL, 'Куплет 1:
Я без Тебя, как солнце без света.
Я без Тебя, как парусник в море без ветра,
Я, как дитя, без материнской ласки.
Без Тебя, Господь, тускнеют в жизни краски.
Куплет 2:
Ты для меня, как свежий дождь в знойное лето.
Ты для меня укрытие от сильного ветра.
Ты для меня, как маяк для заблудшего корабля
Ты, Господь, моя обетованная Земля.
Куплет 3:
В бурю и шторм твердо я уповаю:
Кроме Тебя защиты другой я не знаю.
Ты - мой покой. Ты - скала. Ты - мое утешение.
Ты в любой беде, Господь, мое спасение.
Куплет 4:
Я без Тебя, как солнце без света.
Я без Тебя, как парусник в море без ветра,
Я, как дитя, без материнской ласки.
Без Тебя, Господь, тускнеют жизни краски.', 'Куплет 1:
D H
Em A
D Hm
Em A
Куплет 2:
D H
Em A
D Hm
Em A
Куплет 3:
D H
Em A
D Hm
Em A
Куплет 4:
D H
Em A
D Hm
Em A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=253 | photo=notion-youth-songbook | notionPageId=77ce7c1b-1395-407f-9987-172f155fde48 | notionChordPageId=d26861eb-ecb8-4f86-9956-27e7290a96b3 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/77ce7c1b1395407f9987172f155fde48', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я без Тебя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=253%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я Бог неба', 'Молодёжный сборник', NULL, 'Куплет 1:
Я Бог неба и морей
Я услышал плач людей.
Всех, кого терзает грех,
Спасу Я тех.
Я, кто звезды сотворил,
Бездну светом озарил.
Кто Мой свет им принесет?
Кто к ним пойдет?
Припев:
Вот я, Боже,здесь я, Боже.
Я услышал голос Твой в тиши.
Меня вышли, о Всевышний,
Твой призыв на сердце напиши.
Куплет 2:
Я Бог снега и дождей,
Но других себе вождей
Избирает мой народ.
Кто к ним пойдет?
Не по их делам воздам,
Сердце новое им дам.
Кто захочет им сказать?
Кого послать?
Куплет 3:
Я, Бог молний и ветров,
Принять страждущих готов,
Кем гнушается весь мир,
Зову на пир.
Лучший хлеб Я преломлю,
Жажду сердца утолю.
Кто захочет им сказать?
Кого послать?', 'Куплет 1:
G C G
C G D
Em C Am
C D
G C G
C G D
Em C Am
C D
Припев:
D G C G C
C G C Am D
D G C G C
C Em C D G
Куплет 2:
G C G
C G D
Em C Am
C D
G C G
C G D
Em C Am
C D
Куплет 3:
G C G
C G D
Em C Am
C D
G C G
C G D
Em C Am
C D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=254 | photo=notion-youth-songbook | notionPageId=41d8cc95-bea3-4efc-b589-422829c69bea | notionChordPageId=65d08502-46b6-4d4c-b6b1-70498102cdf9 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/41d8cc95bea34efcb589422829c69bea', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я Бог неба'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=254%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я в бессмертье иду', 'Молодёжный сборник', NULL, 'Куплет 1:
Я в бессмертье иду, наступая на зло,
Из скорбей и страданий дорога.
На душе у меня и тепло и светло,
Потому что я верую в Бога.
Куплет 2:
Знаю я, что мне можно и что мне нельзя.
Знаю, что хорошо и что плохо.
Знаю, что на земле существую не зря,
Потому что я верую в Бога.
Куплет 3:
Против истины войско ведет сатана.
Духи зла ополчились как звери.
Ждет меня впереди неземная страна,
Потому что я в Господа верю.
Куплет 4:
Даже если встречаю следы катастроф.
Исчезает из сердца тревога,
Как подумаю я, что есть любящий Бог,
То я счастлив, что верую в Бога.
Куплет 5:
Нет от радости слов, очень мне повезло,
Мною найдена в небо дорога.
На душе у меня и тепло и светло,
Потому что я верую в Бога.', 'Куплет 1:
Dm A Dm
F C F
A# F D Gm
Dm A Dm
Куплет 2:
Dm A Dm
F C F
A# F D Gm
Dm A Dm
Куплет 3:
Dm A Dm
F C F
A# F D Gm
Dm A Dm
Куплет 4:
Dm A Dm
F C F
A# F D Gm
Dm A Dm
Куплет 5:
Dm A Dm
F C F
A# F D Gm
Dm A Dm', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=255 | photo=notion-youth-songbook | notionPageId=4ba44c97-dcbf-4c96-8ea3-44676eaa4546 | notionChordPageId=8b4a6156-39b4-4f88-85bf-007b03302996 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/4ba44c97dcbf4c968ea344676eaa4546', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я в бессмертье иду'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=255%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я жду Тебя', 'Молодёжный сборник', NULL, 'Куплет 1:
Как земля без дождя в знойное лето
Как весна без цветов иль рассвет без россы
Без Тебя, мой Господь, нет жизни и света
Я нуждаюсь в Тебе, о Иисус приходи.
Припев:
Я жду Тебя, рассвет предваряя
Я жду Тебя, склоняясь в тиши
Я жду Тебя, все сердцем взывая
Я жду Тебя, о Иисус, приходи.
Куплет 2:
На кресте Он страдал, кровь за нас проливая,
Чтоб простить и омыть все людские грехи.
О, придите к Христу, Бог вас призывает
У подножья креста есть прощенье для всех.', 'Куплет 1:
E C#m
F#m A H
E C#m
F#m H E
Припев:
E C#m
F#m A H
E C#m
F#m H E
Куплет 2:
E C#m
F#m A H
E C#m
F#m H E', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=256 | photo=notion-youth-songbook | notionPageId=043375d9-d2ea-42fd-9961-f22dfcd15ad6 | notionChordPageId=052f9f03-287d-446b-bd10-8bf1d4227230 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/043375d9d2ea42fd9961f22dfcd15ad6', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я жду Тебя'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=256%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я иду земными битвами', 'Молодёжный сборник', NULL, 'Куплет 1:
Я иду земными битвами,
Как в степи идет пастух,
И сердечными молитвами
Укрепляется мой дух.
И сердечными молитвами
И сердечными молитвами
И сердечными молитвами
Укрепляется мой дух
Куплет 2:
Я иду в страну далекую,
В дом Небесного Отца,
Где течет рекой широкою
Славословье без конца.
Где течет рекой широкою
Где течет рекой широкою
Где течет рекой широкою
Славословье без конца.
Куплет 3:
И когда войду в селение,
Я увижу в тот же миг,
Среди ангельского пения
Милосердный Божий лик.
Среди ангельского пения
Среди ангельского пения
Среди ангельского пения
Милосердный Божий лик.', 'Куплет 1:
Em Am
H7 Em
Em Am
H7 Em
E7 Am
D G
C Am
H7 Em
Куплет 2:
Em Am
H7 Em
Em Am
H7 Em
E7 Am
D G
C Am
H7 Em
Куплет 3:
Em Am
H7 Em
Em Am
H7 Em
E7 Am
D G
C Am
H7 Em', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=257 | photo=notion-youth-songbook | notionPageId=e00e3d8d-6a1d-47c6-822a-3263a7ea70cb | notionChordPageId=75f922f7-3578-4cce-a90f-fc8a055a576c | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/e00e3d8d6a1d47c6822a3263a7ea70cb', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я иду земными битвами'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=257%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я один из тех', 'Молодёжный сборник', NULL, 'Куплет 1:
Я один из тех, кого Ты заметил,
Я один из тех, кого Ты не прошел,
Я один из тех, кто зимой и летом
Твоим солнечным светом греет душу свою.
Припев:
Иисус – я один из многих,
Чьи пути, дороги к Тебе ведут.
Иисус, Ты готовишь город,
Нас там будет много, я – один из них!
Куплет 2:
Я один из тех, чьи грехи забыты,
Я один из тех, кого Ты простил.
Я один из тех, кто был на Голгофе,
Видел гроб Твой пустым, Иисус – Ты воскрес!
Куплет 3:
Я один из тех, кто поет Тебе песни,
Я один из тех, кто любит Тебя.
Я один из тех, кто с Тобой будет вместе
В Царстве Небесном вовеки-веков', 'Куплет 1:
Am Dm E Am
Dm E Am
G C
Dm E E7
Припев:
Am F
Dm E E7
Am F
Dm E Am
Куплет 2:
Am Dm E Am
Dm E Am
G C
Dm E E7
Куплет 3:
Am Dm E Am
Dm E Am
G C
Dm E E7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=258 | photo=notion-youth-songbook | notionPageId=713a084d-45db-499b-968c-bf3fea6bf258 | notionChordPageId=88c28778-fe83-41e0-848f-af8770859a8e | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/713a084d45db499b968cbf3fea6bf258', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я один из тех'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=258%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я опускаюсь на колени', 'Молодёжный сборник', NULL, 'Куплет 1:
Я опускаюсь на колени,
Перед Тобою мой Господь.
И вот опять я в изумлении
Как Ты устроил этот мир.
Припев:
В своей молитве я прошу,
С надеждою и верой:
Любви смирения пред Тобой,
Веди нас за Собою,
Когда мы падаем,
Ты нас не оставляешь -
Своей крепкою рукою,
Нас снова поднимаешь.
Куплет 2:
Бродил я долго в заблуждении,
И вот однажды попросил:
О, Боже, дай нам вразумление,
И Ты мне истину открыл.
Куплет 3:
Мое Ты сердце освятил,
Прекрасною любовью,
За грешный мир Ты заплатил,
Своей невинной кровью.', 'Куплет 1:
C Em
C D
C Em
C D
Припев:
G Em
C D
G Em
C D
G Em
C D
G Em
C D
Куплет 2:
C Em
C D
C Em
C D
Куплет 3:
C Em
C D
C Em
C D', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=259 | photo=notion-youth-songbook | notionPageId=3a4c8fdb-e08b-4e51-8a34-123370179ddd | notionChordPageId=fc461e54-4a11-416a-b372-835f851bd020 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3a4c8fdbe08b4e518a34123370179ddd', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я опускаюсь на колени'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=259%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я прихожу к Тебе пустой', 'Молодёжный сборник', NULL, 'Куплет 1:
Я прихожу к Тебе пустой,
Я прихожу к Тебе больной.
Я знаю, Ты Своей рукой
Поднимешь вновь и дашь покой.
Припев:
В Тебе надежда моя необъятно-вечная!
В Тебе мой свет, Ты — звезда моя путеводная!
Ты — моя крепость и песня моя победная!
В Твоих надёжных руках на века душа моя.
Куплет 2:
Я так устал бродить слепой,
Прошу, глаза мне вновь открой,
Я будто вновь едва живой…
Отец, я так хочу домой.
Куплет 3:
Ты исцеляешь жизнь мою,
Ты укрепляешь слабую душу.
В Твоей любви всегда стою, верен Ты!
Ты не допустишь в жизнь мою пустоты.
Мост:
Ты днём и ночью видишь всё, Ты знаешь сердце моё,
Но, не смотря на всё, дитем меня назвал.
Ты раз и навсегда принял, очистил, оправдал,
Поверил в меня больше, чем я сам.', 'Куплет 1:
Dm A# F
Dm A# F
Dm A# F
Dm A# F
Припев:
Dm A# F
Dm A# F
Dm A# F
Dm A# F
Куплет 2:
Dm A# F
Dm A# F
Dm A# F
Dm A# F
Куплет 3:
Dm A# F
Dm A# F
Dm A# F
Dm A# F
Мост:', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=260 | photo=notion-youth-songbook | notionPageId=3752b018-f657-45d2-9ee4-6639e1e82625 | notionChordPageId=d3bafbf5-f4c1-4b77-838d-2aa13b48cd28 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/3752b018f65745d29ee46639e1e82625', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я прихожу к Тебе пустой'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=260%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я радуюсь всесильно', 'Молодёжный сборник', NULL, 'Куплет 1:
Я радуюсь, что ты живёшь на свете:
Поёшь, мечтаешь также, как и я,
Что нас не сломит самый сильный ветер,
И мы с тобой хорошие друзья.
Куплет 2:
Я радуюсь тому, что Бог предвечный,
Нам кровью Сына счастье подарил,
Сам в руки дал негаснущую верность
И свет её в глазах у нас горит.
Куплет 3:
Я радуюсь и радуюсь всесильно,
И благодарен Богу моему,
И знаю я, что вера будет вечной,
И я тебя на небе обниму.', 'Куплет 1:
D A7 D
G A7 D
G A7 D Hm
G A7 D D7
Куплет 2:
D A7 D
G A7 D
G A7 D Hm
G A7 D D7
Куплет 3:
D A7 D
G A7 D
G A7 D Hm
G A7 D D7', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=261 | photo=notion-youth-songbook | notionPageId=cc753c23-79ce-4509-9d32-d93d442724d7 | notionChordPageId=df35be22-da46-47ba-afa0-9669d16ad936 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/cc753c2379ce45099d32d93d442724d7', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я радуюсь всесильно'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=261%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я радуюсь, что Бог...', 'Молодёжный сборник', NULL, 'Куплет 1:
Я радуюсь, что Бог мимо не прошёл
И спас меня.
И Он теперь ведёт в Свой небесный дом
Меня, храня.
Припев:
Я иду за Богом по Его дорогам,
Преодолевая жизни суету.
Помоги мне, Боже, нет Тебя дороже,
Я хочу постигнуть жизни полноту.
Куплет 2:
Я встречу на пути ураган и шторм,
Но не сломлюсь.
Ведь за руку Отца каждый день крепко
Я держусь.', 'Куплет 1:
A F#m D
E A
A F#m D
E A
Припев:
F#m C#m F#m C#m
D A E
F#m C#m F#m C#m
D E A
Куплет 2:
A F#m D
E A
A F#m D
E A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=262 | photo=notion-youth-songbook | notionPageId=99cdcddf-751e-4dfb-b345-3effe94ac2b9 | notionChordPageId=5c444f08-554f-4658-a6f8-ef8340891e42 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/99cdcddf751e4dfbb3453effe94ac2b9', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я радуюсь, что Бог...'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=262%'
  LIMIT 1
);

INSERT INTO song_submissions (title, category, default_key, lyrics, chords, bpm, beats_per_line, intro_beats, submitter_name, submitter_email, note, status)
SELECT 'Я смотрю на крест', 'Молодёжный сборник', NULL, 'Куплет 1:
Я смотрю на крест, на нём страдал Господь.
Он умер и воскрес, в Его глазах любовь.
Я подойду к Нему в Его глаза взгляну, и поклонюсь всем сердцем.
Отдав Себя на смерть, Он подарил мне жизнь!
И любовь!
Припев:
Дорогой ценой я искуплен от греха.
Дорогой ценой небо открыто.
Дорогой ценой спасена душа моя.
В моём сердце есть надежда и сила!
Куплет 2:
Сокрушаюсь я , в сердце тяжкий груз.
Но я приношу, всё Тебе Иисус.
У креста стою и осознаю: не достоин я.
Но благодать Твоя, вновь воскрешает меня,
Верю я!', 'Куплет 1:
Hm A G Hm A G
Hm A G Hm A G
Em G Hm
Em G Hm
A
Припев:
D A
Hm G
D A
Hm A G
Куплет 2:
Hm A G Hm A G
Hm A G Hm A G
Em G Hm
Em G Hm
A', NULL, NULL, NULL, 'Seed import', NULL, '[staging:notion-youth-songbook-2026-08-14] oldNumber=263 | photo=notion-youth-songbook | notionPageId=f54327d3-9978-4c3f-86a7-b95dfde28dc4 | notionChordPageId=0a13753a-6a1e-4a2d-81b3-ada61d2ef309 | status=notion-lyrics-chords | confidence=notion-page-with-nested-chords | Notion: https://blagochestie.notion.site/f54327d399784c3f86a7b95dfde28dc4', 'pending'
WHERE NOT EXISTS (
  SELECT 1 FROM song_submissions
  WHERE title = 'Я смотрю на крест'
    AND note LIKE '[staging:notion-youth-songbook-2026-08-14] oldNumber=263%'
  LIMIT 1
);

COMMIT;
