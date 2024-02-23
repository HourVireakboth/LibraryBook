import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarybook/models/authormodel.dart';
import 'package:librarybook/models/request/authorequest.dart';
import 'package:librarybook/models/serachmodel.dart';
import 'package:librarybook/provider/author.dart';
import 'package:librarybook/viewmodels/author_viewmodel.dart';
import 'package:librarybook/views/pages/author/author.dart';
import 'package:provider/provider.dart';

import '../../../data/response/status.dart';
import '../../../res/app_url.dart';
import '../../../res/constants/app_color.dart';
import '../../../res/validation.dart';
import '../../../viewmodels/image_viewmodel.dart';
import '../main_page.dart';

class AddandEditAuthor extends StatefulWidget {
  AddandEditAuthor(
      {super.key,
      this.isUpdate,
      this.isCreate,
      this.author,
      this.authorid,
      this.index});
  AuthorsData? author;
  var isUpdate;
  var isCreate;
  var authorid;
  var index;
  @override
  State<AddandEditAuthor> createState() => _AddandEditAuthorState();
}

class _AddandEditAuthorState extends State<AddandEditAuthor> {
  PickedFile? pickedfile;
  var uploading = false;
  var isImagePicked = false;
  var imageViewModel = ImageViewModel();
  var authorViewModel = AuthorViewModel();
  var imageid;
  var imagefile;
  var globalkey = GlobalKey<FormState>();
  var globalkey_two = GlobalKey<FormState>();
  var authorname = TextEditingController();
  var authorshort = TextEditingController();

  @override
  void initState() {
    imageViewModel = ImageViewModel();
    authorViewModel = AuthorViewModel();

    if (widget.isUpdate!) {
      authorname.text = widget.author!.attributes!.name!;
      authorshort.text = widget.author!.attributes!.shortBiography!;
      imageid = widget.author?.attributes?.photo?.data?.id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.bgcolor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (widget.isUpdate == false && widget.isCreate == false) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                  (route) => false);
            } else if (widget.isCreate == true) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage(),
                  ),
                  (route) => false);
              // Navigator.pop(context);
            }
          },
        ),
        elevation: 0,
        backgroundColor: Appcolor.nbcolor.withOpacity(0.5),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Create Author'),
        titleTextStyle: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.w700, color: Colors.black),
      ),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              color: Appcolor.nbcolor.withOpacity(0.5),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          child: Center(
            child: Column(
              children: [
                ChangeNotifierProvider<ImageViewModel>(
                  create: (context) => imageViewModel,
                  child: Consumer<ImageViewModel>(
                    builder: (context, viewModel, _) {
                      switch (viewModel.imageResponse.status) {
                        case Status.LOADING:
                          return InkWell(
                            onTap: () {
                              getImageFromSource();
                            },
                            child: !isImagePicked
                                ? Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Appcolor.fixcolor
                                                .withOpacity(0.5),
                                            offset: const Offset(2, 2),
                                            blurRadius: 3,
                                            spreadRadius: 2)
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                      color: Appcolor.bgcolor.withOpacity(0.8),
                                    ),
                                    child: widget.isUpdate!
                                        ? Image.network(
                                            widget
                                                        .author
                                                        ?.attributes
                                                        ?.photo
                                                        ?.data
                                                        ?.attributes
                                                        ?.url ==
                                                    null
                                                ? 'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG'
                                                : AppUrl.domain +
                                                    widget
                                                        .author!
                                                        .attributes!
                                                        .photo!
                                                        .data!
                                                        .attributes!
                                                        .url,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.add,
                                            size: 70,
                                            color: Appcolor.nbcolor
                                                .withOpacity(0.5),
                                          ),
                                  )
                                : Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Appcolor.bgcolor.withOpacity(0.8),
                                    ),
                                    child: imagefile != null
                                        ? Image.file(
                                            imagefile,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(
                                            Icons.add,
                                            size: 70,
                                            color: Appcolor.nbcolor
                                                .withOpacity(0.5),
                                          ),
                                  ),
                          );
                        case Status.COMPLETED:
                          imageid = viewModel.imageResponse.data!.id;
                          print(imageid);
                          print('image : $isImagePicked');
                          print(
                              'status post image: ${viewModel.imageResponse.status}');
                          if (uploading) {
                            if (viewModel.imageResponse.status ==
                                Status.COMPLETED) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Upload Image Successfully')));
                              });
                            }
                          }
                          return InkWell(
                            onTap: () {
                              getImageFromSource();
                            },
                            child: isImagePicked == true
                                ? Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Appcolor.bgcolor.withOpacity(0.8),
                                    ),
                                    child: Image.network(
                                      AppUrl.domain +
                                          viewModel.imageResponse.data!.url,
                                      fit: BoxFit.cover,
                                    ))
                                : Container(
                                    height: 200,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Appcolor.bgcolor.withOpacity(0.8),
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      size: 70,
                                      color: Appcolor.nbcolor.withOpacity(0.5),
                                    ),
                                  ),
                          );
                        case Status.ERROR:
                          return Text(viewModel.imageResponse.message!);
                        default:
                          return const Text('Default');
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Upload & Brower Photo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Form(
                  key: globalkey,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: authorname,
                      autocorrect: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor:AppColor.wcolor,
                        labelText: 'Author Name',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        helperText: '',
                        suffixIcon: IconButton(
                          onPressed: () => authorname.clear(),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        hintText: 'Author Name',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (authorname) {
                        if (InputValidator.isAuthorBiography(
                            authorname.toString())) {
                          return null;
                        } else {
                          return 'Your author name is empty';
                        }
                      },
                      onChanged: (value) {
                        if (globalkey.currentState!.validate()) {
                          globalkey.currentState!.save();
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (globalkey.currentState!.validate()) {
                          globalkey.currentState!.save();
                        }
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: globalkey_two,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: authorshort,
                      autocorrect: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor:AppColor.wcolor,
                        labelText: 'Author Biography',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        helperText: '',
                        suffixIcon: IconButton(
                          onPressed: () => authorshort.clear(),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        hintText: 'Author Biography',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: const BorderSide(width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      validator: (biography) {
                        if (InputValidator.isAuthorBiography(
                            biography.toString())) {
                          return null;
                        } else {
                          return 'Your author biography is empty';
                        }
                      },
                      onChanged: (value) {
                        if (globalkey_two.currentState!.validate()) {
                          globalkey_two.currentState!.save();
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (globalkey_two.currentState!.validate()) {
                          globalkey_two.currentState!.save();
                        }
                      }),
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: double.maxFinite,
                  child: ChangeNotifierProvider(
                    create: (context) => authorViewModel,
                    child: Consumer<AuthorViewModel>(
                      builder: (context, viewModel, _) {
                        print(
                            'status Summit Author : ${viewModel.apiResponse.status}');
                        if (viewModel.apiResponse.status == Status.COMPLETED) {
                          //viewModel.authorapiResponse.status = Status.LOADING;
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: widget.isUpdate == true
                                    ? const Text('Update author Successfully')
                                    : const Text(
                                        'Upload author Successfully')));
                          });
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (authorname.text.length == 0 ||
                                authorshort.text.length == 0) {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    alignment: Alignment.center,
                                    content: const Text(
                                      'One of two missing information in the field!',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: TextButton(
                                              style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  foregroundColor:
                                                      Appcolor.bgcolor,
                                                  backgroundColor:
                                                      Appcolor.nbcolor),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text(
                                                'Okay',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              setState(() {
                                postAuthor(widget.isUpdate, widget.index);
                                if (widget.isUpdate == false) {
                                  clearData();
                                } else if (widget.isUpdate == true) {

                                  Navigator.pop(context, true);
                                  // Navigator.pushAndRemoveUntil(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => AuthorScreen(
                                  //               isUpdate: true,
                                  //             )),
                                  //     (route) => false);
                                }
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Appcolor.nbcolor.withOpacity(0.5),
                              padding: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25))),
                          child: widget.isUpdate == true
                              ? const Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                )
                              : const Text(
                                  'Submit',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ))
      ]),
    );
  }

  dynamic getImageFromSource() async {
    pickedfile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 1800, maxWidth: 1900);

    if (pickedfile != null) {
      setState(() {
        isImagePicked = true;
        imagefile = File(pickedfile!.path);
        uploading = true;
      });
      imageViewModel.uploadImage(pickedfile!.path);
    }
  }

  void clearData() {
    isImagePicked = false;
    authorname.clear();
    authorshort.clear();
  }

  void postAuthor(isUpdate, index) {
    var author = DataRequestAuthor(
        name: authorname.text,
        shortBiography: authorshort.text,
        photo: imageid.toString());
    if (isUpdate) {
      print('imageid = $imageid');
      print('edit author');
      print('author id : ${widget.authorid}');
      authorViewModel.putAuthor(author, widget.authorid);
      Provider.of<Author>(context,listen:false)
          .updateAuthor( uploading == true ? imageViewModel.imageResponse.data?.url : widget
                                                        .author!
                                                        .attributes!
                                                        .photo!
                                                        .data!
                                                        .attributes!
                                                        .url , authorname.text, authorshort.text, index);
    } else {
      print('post author');
      authorViewModel.postAuthor(author);
    }
  }
}
