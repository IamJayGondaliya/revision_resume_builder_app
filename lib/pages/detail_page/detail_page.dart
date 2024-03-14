import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:revision_resume_builder_app/globals/globals.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Future<void> getImage({required ImageSource source}) async {
    ImagePicker picker = ImagePicker();

    XFile? file = await picker.pickImage(
      source: source,
    );

    if (file != null) {
      Globals.globals.user!.image = File(file.path);
      setState(() {});
    }
  }

  /*

      FormValidation:
        1. Create form:
            Form
              - Column
                - TextFormField...
        2. Create a FormKey
            GlobalKey<FormState> formKey = GlobalKey<FormState>();
        3. Attach key to Form.
             Form(
                key: formKey,
             ),
        4. Attach validators in TextFormFields
              TextFormField(
                  validator: () => ifError ? "error" : null;
              ),
        5. Invoke the validators,
              Button(
                onPressed: () {
                  formKey.currentState!.validate();
                },
              ),
        6. Save the data if form is validated.
              if(validated) {
                formKey.currentState!.save();
              }
           - will invoke the onSaved in each TextFormField in the Form
              TextFormField(
                onSaved: (value) {
                   my_value = value;
                }
              ),

  */

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Add Image"),
              Align(
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Select source"),
                        actions: [
                          ElevatedButton.icon(
                            onPressed: () {
                              getImage(source: ImageSource.camera).then(
                                (value) {
                                  Navigator.pop(context);
                                },
                              );
                            },
                            icon: const Icon(CupertinoIcons.camera),
                            label: const Text("Camera"),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              getImage(source: ImageSource.gallery).then(
                                (value) {
                                  Navigator.pop(context);
                                },
                              );
                            },
                            icon: const Icon(Icons.image_outlined),
                            label: const Text("Gallery"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 60,
                    foregroundImage: Globals.globals.user.image != null
                        ? FileImage(Globals.globals.user.image!)
                        : null,
                    child: const Text(
                      "Click to add image",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Please enter name" : null,
                      onSaved: (val) {
                        Globals.globals.user.name = val;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Please enter number" : null,
                      onSaved: (val) {
                        Globals.globals.user.contact = val;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.phone),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (val) =>
                          val!.isEmpty ? "Please enter email" : null,
                      onSaved: (val) {
                        Globals.globals.user.email = val;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            User u = User();

                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();

                              u.name = Globals.globals.user.name;
                              u.contact = Globals.globals.user.contact;
                              u.email = Globals.globals.user.email;
                              u.image = Globals.globals.user.image;

                              Globals.globals.allUsers.add(u);

                              Globals.globals.user.reset();

                              Navigator.pop(context);
                            }
                          },
                          child: const Text("SAVE"),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text("CANCEL"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
