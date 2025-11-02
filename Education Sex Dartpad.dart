// main.dart
import 'package:flutter/material.dart';

void main() => runApp(SexEdApp());

class SexEdApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EROSEDU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.orange.shade100,
      ),
      home: EnhancedHomePage(),
    );
  }
}

// ================== HOME PAGE INTERAKTIF ==================
class EnhancedHomePage extends StatefulWidget {
  @override
  State<EnhancedHomePage> createState() => _EnhancedHomePageState();
}

class _EnhancedHomePageState extends State<EnhancedHomePage>
    with SingleTickerProviderStateMixin {
  int xp = 0;
  bool safeMode = true;
  late AnimationController _controller;

  final List<_MainFeature> _features = [];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _controller.value = 1.0;

    _features.addAll([
      _MainFeature(
        icon: Icons.menu_book,
        title: "Materi Pembelajaran",
        color: Colors.green,
        subs: [
          SubMenu(
            "Definisi Secara Umum",
            "Edukasi Seksual sendiri merupakan pengetahuan dasar tentang organ reproduksi, bagian vital, masa pubertas serta perubahan ciri fisik seorang anak yang sedang transisi menuju masa remaja. Pubertas sendiri merupakan perubahan ciri fisik, hormon, serta sensitifitas seseorang, tak jarang anak yang mengalami pubertas cenderung berkeinginan untuk mandiri.",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/3534/3534033.png",
          ),
          // Tambahan sesuai permintaan: tombol "Pengertian"
          SubMenu(
            "Masa Pubertas",
            "Perubahan fisik dan emosional.",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/3534/3534033.png",
          ),
          SubMenu(
            "Kesehatan Reproduksi",
            "Pelajari lebih lanjut tentang kesehatan reproduksi melalui topik berikut.",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/3062/3062634.png",
          ),
        ],
      ),
      _MainFeature(
        icon: Icons.quiz,
        title: "Quiz",
        color: Colors.red,
        subs: [
          SubMenu("Kuis Dasar", "Pertanyaan ringan tentang pengetahuan umum."),
        ],
      ),
      _MainFeature(
        icon: Icons.lightbulb,
        title: "Tips Komunikasi",
        color: Colors.lime,
        subs: [
          SubMenu(
            "Terbuka dan Tanpa Menghakimi",
            "Cobalah berbicara dengan jujur tanpa menghakimi orang lain. "
            "Bersikap terbuka membantu orang lain merasa aman untuk berbagi.",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/3002/3002662.png",
          ),
          SubMenu(
            "Mendengarkan Secara Aktif",
            "Tunjukkan perhatian penuh saat orang lain berbicara. "
            "Dengarkan dengan empati dan hindari memotong pembicaraan.",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/9927/9927092.png",
          ),
          SubMenu(
            "Menggunakan Bahasa yang Sesuai",
            "Gunakan bahasa yang sopan dan sesuai dengan usia lawan bicara. "
            "Hal ini membantu percakapan terasa lebih nyaman dan saling menghargai.",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/46/46833.png",
          ),
          SubMenu(
            "Bersikap Wajar dan Tidak Malu",
            "Bicarakan topik penting dengan tenang dan wajar. "
            "Malu itu wajar, tapi jangan sampai menghambat proses belajar.",
            imageUrl: "https://cdn-icons-png.flaticon.com/512/14857/14857287.png",
          ),
        ],
      ),
      _MainFeature(
        icon: Icons.smartphone,
        title: "Ensiklopedia",
        color: Colors.blue,
        subs: [
          SubMenu(
            "Pakar",
            "Pakar Psikologi Terkait Edukasi Seksual.",
            imageUrl:
                "https://drive.google.com/uc?export=view&id=1majY5DJr9xk50DbYUx1Dqc6we8JPpGh8",
          ),
        ],
      ),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addXP() {
    setState(() => xp += 10);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('🎉 Kamu mendapat 10 XP! Total XP: $xp'),
      backgroundColor: Colors.green.shade400,
      duration: const Duration(seconds: 1),
    ));
  }

  void _toggleSafeMode() {
    setState(() => safeMode = !safeMode);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(safeMode ? 'Mode Aman diaktifkan ✅' : 'Mode Aman dimatikan ⚠️'),
      backgroundColor: safeMode ? Colors.green : Colors.orange,
      duration: const Duration(seconds: 1),
    ));
  }

 void _showSubmenu(_MainFeature f) {
  showModalBottomSheet(
    context: context,
    backgroundColor: f.color.shade50,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (_) {
      final content = SingleChildScrollView( // <-- Tambahkan scroll di sini
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              f.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: f.color.shade800,
              ),
            ),
            const SizedBox(height: 10),
            ...f.subs.map((s) {
              return Card(
                color: f.color.shade100,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: Icon(Icons.arrow_forward, color: f.color.shade700),
                  title: Text(
                    s.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade900,
                    ),
                  ),
                  subtitle: Text(s.desc),
                  onTap: () {
                    Navigator.pop(context);
                    _addXP();

                    if (s.title == "Pengertian") {
                      _showMiniDialog(
                        "Pengertian",
                        "Pendidikan seksual adalah upaya untuk memberikan pengetahuan, sikap, dan keterampilan agar individu dapat membuat keputusan yang sehat mengenai perkembangan tubuh, hubungan, dan kesehatan reproduksi.",
                        imageUrl: "https://cdn-icons-png.flaticon.com/512/2203/2203183.png",
                      );
                      return;
                    }

                    if (s.title == "Kuis Dasar" || s.title == "Kuis Lanjutan") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => QuizPage(onGainXP: _addXP)),
                      );
                    } else if (s.title == "Masa Pubertas") {
                      _showGenderChoice();
                    } else if (s.title == "Kesehatan Reproduksi") {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: f.color.shade50,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                        ),
                        builder: (_) {
                          final topics = [
                            SubMenu("Pengertian dan Ruang Lingkup",
                                "Kesehatan reproduksi adalah keadaan sejahtera fisik, mental, dan sosial yang utuh, bukan sekadar bebas dari penyakit atau cacat, dalam segala aspek yang berkaitan dengan sistem, fungsi, dan proses reproduksi."),
                            SubMenu("Menjaga Kesehatan Reproduksi",
                                "Menjaga kesehatan reproduksi meliputi menjaga kebersihan organ intim, menjalani pola hidup sehat (makan bergizi, olahraga, istirahat cukup, hindari rokok dan alkohol), menghindari perilaku seksual berisiko, serta melakukan pemeriksaan kesehatan rutin."),
                            SubMenu("Kesehatan Reproduksi Remaja",
                                "Kesehatan reproduksi remaja adalah kondisi kesehatan fisik, mental, dan sosial terkait organ reproduksi pada usia 10–19 tahun, yang mencakup pemahaman tentang pubertas, kebersihan organ reproduksi, serta pencegahan kehamilan dini dan penyakit menular seksual (PMS)."),
                            SubMenu("Masalah Kesehatan Reproduksi",
                                "Masalah kesehatan reproduksi mencakup berbagai kondisi seperti infeksi menular seksual (IMS), kanker (serviks, prostat, testis), gangguan hormon (PCOS), masalah kesuburan, dan kekerasan seksual."),
                          ];

                          return SingleChildScrollView( // <-- Scroll di sini juga
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Kesehatan Reproduksi",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: f.color.shade800,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...topics.map(
                                  (t) => Card(
                                    color: f.color.shade100,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12)),
                                    child: ListTile(
                                      leading: Icon(Icons.arrow_forward, color: f.color.shade700),
                                      title: Text(
                                        t.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey.shade900,
                                        ),
                                      ),
                                      subtitle: Text(t.desc),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _addXP();
                                        _showMiniDialog(t.title, t.desc);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      _showMiniDialog(s.title, s.desc, imageUrl: s.imageUrl);
                    }
                  },
                ),
              );
            }),
          ],
        ),
      );

      return content;
    },
  );
}

  void _showGenderChoice() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pilih Jenis Kelamin", textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              icon: const Text("♂", style: TextStyle(fontSize: 26, color: Colors.blue)),
              label: const Text("Laki-laki"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade100,
                foregroundColor: Colors.blue.shade900,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                Navigator.pop(context);
                _showMiniDialog(
                  "Masa Pubertas Laki-laki",
                  "Pubertas pada laki-laki biasanya dimulai antara usia 9–14 tahun, pubertas pada laki-laki paling umum adalah keluarnya cairan mani atau disebut juga dengan mimpi basah, suara yang mulai berat, dan tumbuh rambut di wajah serta tubuh. Suara laki-laki mulai terasa berat disebabkan oleh pertumbuhan jakun dan pita suara yang memanjang, pertumbuhan pada testis serta tumbuhnya rambut pada area ketiak dan kemaluan.",
                  imageUrl: "https://cdn-icons-png.flaticon.com/512/4140/4140048.png",
                );
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Text("♀", style: TextStyle(fontSize: 26, color: Colors.pink)),
              label: const Text("Perempuan"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink.shade100,
                foregroundColor: Colors.pink.shade900,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                Navigator.pop(context);
                _showMiniDialog(
                  "Masa Pubertas Perempuan",
                  "Pubertas pada perempuan biasanya dimulai antara usia 8–13 tahun, ditandai dengan pertumbuhan payudara dan dimulainya menstruasi pertama (haid). Selain itu, ciri pubertas pada perempuan juga ditandai dengan pinggul yang melebar serta tumbuhnya rambut di ketiak dan kemaluan.",
                  imageUrl: "https://cdn-icons-png.flaticon.com/512/4140/4140047.png",
                );
              },
            ),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal"))],
      ),
    );
  }

  void _showMiniDialog(String title, String desc, {String? imageUrl}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.book_rounded, color: Colors.amber),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imageUrl != null && imageUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Image.network(
                    imageUrl,
                    height: 150,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  ),
                ),
              Text(desc,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade800)),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EROSEDU'),
        centerTitle: true,
        backgroundColor: Colors.yellow.shade700,
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: TopicSearch(_features));
              }),
          IconButton(
              icon: Icon(safeMode ? Icons.shield_moon : Icons.shield_outlined),
              tooltip: 'Mode Aman',
              onPressed: _toggleSafeMode),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  const Text('Halo 👋',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    'Selamat datang di aplikasi edukasi interaktif.\nPilih fitur di bawah ini untuk belajar dengan cara menyenangkan!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 10),
                  Text('⭐ XP kamu: $xp',
                      style: TextStyle(
                          color: Colors.orange.shade800, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ..._features.map((f) => AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return Transform.scale(
                    scale: _controller.value,
                    child: Card(
                      elevation: 6,
                      color: f.color.shade100,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ListTile(
                        leading: Icon(f.icon, color: f.color.shade800, size: 36),
                        title: Text(f.title,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        trailing: Icon(Icons.arrow_forward_ios, color: f.color.shade700),
                        onTap: () {
                          _controller.reverse().then((_) {
                            _controller.forward();
                            _showSubmenu(f);
                          });
                        },
                      ),
                    ),
                  );
                },
              )),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.info_outline),
              label: const Text("Tentang Aplikasi"),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.grey.shade800),
              onPressed: () {
                _showMiniDialog(
                    "Tentang",
                    "Aplikasi ini dibuat untuk edukasi seksual yang aman dan sesuai usia. "
                    "Gunakan Mode Aman untuk konten yang disaring.");
              },
            ),
          ),
        ],
      ),
    );
  }
}
// ================== MODEL DATA ==================
class _MainFeature {
  final IconData icon;
  final String title;
  final MaterialColor color;
  final List<SubMenu> subs;
  _MainFeature(
      {required this.icon, required this.title, required this.color, required this.subs});
}

class SubMenu {
  final String title;
  final String desc;
  final String? imageUrl;
  SubMenu(this.title, this.desc, {this.imageUrl});
}

// ================== FITUR PENCARIAN ==================
class TopicSearch extends SearchDelegate<String> {
  final List<_MainFeature> features;
  TopicSearch(this.features);

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));

  @override
  Widget buildResults(BuildContext context) {
    final results = features
        .expand((f) => f.subs)
        .where((s) => s.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
      children: results
          .map((s) => ListTile(
                title: Text(s.title),
                subtitle: Text(s.desc),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(s.title),
                    content: Text(s.desc),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(context), child: const Text("Tutup"))
                    ],
                  ),
                ),
              ))
          .toList(),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = features
        .expand((f) => f.subs)
        .where((s) => s.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView(
      children: suggestions
          .map((s) => ListTile(
                title: Text(s.title),
                onTap: () {
                  query = s.title;
                  showResults(context);
                },
              ))
          .toList(),
    );
  }
}

// ================== HALAMAN KUIS DASAR ==================
class QuizPage extends StatefulWidget {
  final VoidCallback onGainXP;
  const QuizPage({required this.onGainXP});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> _questions = [
    {
      "q": "Apa itu pubertas?",
      "options": [
        "Masa anak-anak bermain dan belajar",
        "Masa transisi menuju dewasa dengan perubahan fisik dan hormon",
        "Masa ketika tubuh berhenti tumbuh"
      ],
      "correct": 1
    },
    {
      "q": "Pubertas pada perempuan biasanya dimulai pada usia...",
      "options": ["5–8 tahun", "8–13 tahun", "15–18 tahun"],
      "correct": 1
    },
    {
      "q": "Pubertas pada laki-laki biasanya dimulai pada usia...",
      "options": ["6–9 tahun", "9–14 tahun", "15–17 tahun"],
      "correct": 1
    },
    {
      "q": "Tanda utama pubertas pada perempuan adalah...",
      "options": ["Tumbuh jakun", "Menstruasi pertama dan perkembangan payudara", "Suara menjadi berat"],
      "correct": 1
    },
    {
      "q": "Tanda utama pubertas pada laki-laki adalah...",
      "options": ["Menstruasi", "Pertumbuhan penis dan testis serta mimpi basah", "Pinggul melebar"],
      "correct": 1
    },
    {
      "q": "Mengapa suara laki-laki menjadi lebih berat saat pubertas?",
      "options": ["Karena banyak berteriak", "Karena pertumbuhan jakun dan pita suara memanjang", "Karena sering latihan bernyanyi"],
      "correct": 1
    },
    {
      "q": "Penyebab munculnya jerawat saat pubertas adalah...",
      "options": ["Kekurangan tidur", "Peningkatan hormon yang merangsang kelenjar minyak", "Terlalu sering mencuci wajah"],
      "correct": 1
    },
    {
      "q": "Perubahan yang terjadi pada tubuh perempuan selain menstruasi adalah...",
      "options": ["Pinggul melebar dan tumbuh rambut di ketiak", "Tumbuh jakun", "Suara menjadi berat"],
      "correct": 0
    },
    {
      "q": "Perubahan yang dialami laki-laki selain mimpi basah adalah...",
      "options": ["Tumbuh jakun dan suara berubah", "Pinggul melebar", "Menstruasi"],
      "correct": 0
    },
    {
      "q": "Perubahan emosional saat pubertas adalah...",
      "options": ["Menjadi lebih sensitif dan ingin mandiri", "Menjadi pendiam terus", "Tidak mengalami perubahan"],
      "correct": 0
    },
  ];
  int _index = 0;
  int _localScore = 0;
  int? _selected; // selected option index
  String? _feedback; // feedback string
  bool _answered = false;

  void _selectOption(int idx) {
    if (_answered) return; // prevent re-answering same question
    final correctIdx = _questions[_index]['correct'] as int;
    setState(() {
      _selected = idx;
      _answered = true;
      if (idx == correctIdx) {
        _localScore += 1;
        _feedback = "Benar! +10 XP";
        // call parent's XP grant
        widget.onGainXP();
      } else {
        final correctText = (_questions[_index]['options'] as List<String>)[correctIdx];
        _feedback = "Salah! Jawaban benar adalah: $correctText";
      }
    });
  }

  void _next() {
    if (_index < _questions.length - 1) {
      setState(() {
        _index += 1;
        _selected = null;
        _feedback = null;
        _answered = false;
      });
    } else {
      // quiz selesai
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Hasil Kuis"),
          content: Text("Kamu menjawab benar $_localScore dari ${_questions.length} soal."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // close dialog
                Navigator.pop(context); // kembali ke Home
              },
              child: const Text("Selesai"),
            ),
            TextButton(
              onPressed: () {
                // restart quiz
                Navigator.pop(context);
                setState(() {
                  _index = 0;
                  _localScore = 0;
                  _selected = null;
                  _feedback = null;
                  _answered = false;
                });
              },
              child: const Text("Ulangi"),
            ),
          ],
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final q = _questions[_index];
    final options = q['options'] as List<String>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kuis Dasar"),
        backgroundColor: Colors.yellow.shade700,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Text("Soal ${_index + 1} / ${_questions.length}",
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Text(q['q'] as String,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ...List.generate(options.length, (i) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: ElevatedButton(
                          onPressed: () => _selectOption(i),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            // don't change colors (use defaults)
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${String.fromCharCode(65 + i)}. ${options[i]}",
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 10),
                    if (_feedback != null)
                      Text(
                        _feedback!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _feedback!.startsWith("Benar") ? Colors.green.shade700 : Colors.red.shade700,
                            fontWeight: FontWeight.w600),
                      ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Skor saat ini: $_localScore",
                            style: const TextStyle(fontWeight: FontWeight.w600)),
                        ElevatedButton(
                          onPressed: _answered ? _next : null,
                          child: Text(_index < _questions.length - 1 ? "Next" : "Selesai"),
                          style: ElevatedButton.styleFrom(minimumSize: const Size(100, 40)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Petunjuk: Pilih satu jawaban. Jika benar, kamu mendapat 10 XP.",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}