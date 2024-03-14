import 'package:flutter/material.dart';
import 'package:revision_resume_builder_app/globals/globals.dart';
import 'package:revision_resume_builder_app/routes/my_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              MyRoutes.pdfPage,
            ),
            icon: const Icon(Icons.picture_as_pdf_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: Globals.globals.allUsers
                .map(
                  (e) => Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundImage:
                            e.image != null ? FileImage(e.image!) : null,
                      ),
                      title: Text(e.name ?? "Demo"),
                      subtitle:
                          Text("Contact: ${e.contact}\nEmail: ${e.email}"),
                      trailing: IconButton(
                        onPressed: () {
                          Globals.globals.allUsers.remove(e);
                          setState(() {});
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.pushNamed(
          context,
          MyRoutes.detailPage,
        ).then((value) => setState(() {})),
        icon: const Icon(Icons.add),
        label: const Text("Add"),
      ),
    );
  }
}
