
import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F7FB),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
          brightness: Brightness.light,
        ),
        fontFamily: 'Roboto',
      ),
      home: const TodoPage(),
    );
  }
}

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _taskController = TextEditingController();

  final List<String> _tasks = ['Makan', 'Minum', 'Tidur'];

  final Set<int> _completedTasks = {};

  void _addTask() {
    final String task = _taskController.text.trim();

    if (task.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nama tugas tidak boleh kosong'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _tasks.add(task);
      _taskController.clear();
    });

    FocusScope.of(context).unfocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tugas berhasil ditambahkan'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleTask(int index, bool? value) {
    setState(() {
      if (value == true) {
        _completedTasks.add(index);
      } else {
        _completedTasks.remove(index);
      }
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);

      final Set<int> updatedCompleted = {};

      for (final int completedIndex in _completedTasks) {
        if (completedIndex < index) {
          updatedCompleted.add(completedIndex);
        } else if (completedIndex > index) {
          updatedCompleted.add(completedIndex - 1);
        }
      }

      _completedTasks
        ..clear()
        ..addAll(updatedCompleted);
    });
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int completedCount = _completedTasks.length;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF6969F5),
                    Color(0xFF5146D8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Icon(
                          Icons.checklist_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Todo-List',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              'Atur aktivitasmu hari ini',
                              style: TextStyle(
                                color: Color(0xFFE4E3FF),
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.wb_sunny_rounded,
                        color: Color(0xFFFFDF8A),
                        size: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Total Tugas',
                                style: TextStyle(
                                  color: Color(0xFFE4E3FF),
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${_tasks.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '$completedCount tugas selesai',
                                style: const TextStyle(
                                  color: Color(0xFFE4E3FF),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 66,
                          width: 66,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.17),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.task_alt_rounded,
                            size: 38,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 24, 22, 24),
                children: [
                  const Text(
                    'Tambah Tugas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF252743),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Apa yang ingin kamu lakukan?',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF85879B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF292C63)
                              .withValues(alpha: 0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.edit_note_rounded,
                          color: Color(0xFF6969F5),
                          size: 27,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _taskController,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => _addTask(),
                            decoration: const InputDecoration(
                              hintText: 'Masukkan nama tugas...',
                              hintStyle: TextStyle(
                                color: Color(0xFFAAABBA),
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Material(
                          color: const Color(0xFF5B5FEF),
                          borderRadius: BorderRadius.circular(14),
                          child: InkWell(
                            onTap: _addTask,
                            borderRadius: BorderRadius.circular(14),
                            child: const Padding(
                              padding: EdgeInsets.all(13),
                              child: Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Daftar Tugas',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF252743),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8E9FF),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_tasks.length} tugas',
                          style: const TextStyle(
                            color: Color(0xFF5558D9),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (_tasks.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 38,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Column(
                        children: [
                          Icon(
                            Icons.task_alt_rounded,
                            size: 54,
                            color: Color(0xFFB7B8CE),
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Belum ada tugas',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF454760),
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Tambahkan tugas pertamamu di atas.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF85879B),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    ...List.generate(_tasks.length, (index) {
                      final bool isCompleted =
                          _completedTasks.contains(index);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: const Color(0xFFEEEEF5),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF292C63)
                                  .withValues(alpha: 0.025),
                              blurRadius: 10,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 5,
                          ),
                          leading: Container(
                            width: 38,
                            height: 38,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? const Color(0xFFE2F7EC)
                                  : const Color(0xFFEDEEFF),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                color: isCompleted
                                    ? const Color(0xFF279A65)
                                    : const Color(0xFF5B5FEF),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          title: Text(
                            _tasks[index],
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: isCompleted
                                  ? const Color(0xFF999AAA)
                                  : const Color(0xFF30324B),
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              isCompleted ? 'Selesai' : 'Belum selesai',
                              style: TextStyle(
                                fontSize: 11,
                                color: isCompleted
                                    ? const Color(0xFF279A65)
                                    : const Color(0xFF9293A5),
                              ),
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Checkbox(
                                value: isCompleted,
                                activeColor: const Color(0xFF5B5FEF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                onChanged: (value) =>
                                    _toggleTask(index, value),
                              ),
                              IconButton(
                                tooltip: 'Hapus tugas',
                                onPressed: () => _deleteTask(index),
                                icon: const Icon(
                                  Icons.delete_outline_rounded,
                                  color: Color(0xFFE17B85),
                                  size: 22,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      'Satu langkah kecil setiap hari.',
                      style: TextStyle(
                        color: Color(0xFF9B9CAE),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
