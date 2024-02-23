import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:librarybook/data/response/status.dart';
import 'package:librarybook/models/bookmodel.dart';
import 'package:librarybook/models/request/bookrequest.dart';
import 'package:librarybook/provider/book.dart';
import 'package:librarybook/res/app_url.dart';
import 'package:librarybook/res/constants/app_color.dart';
import 'package:librarybook/viewmodels/author_viewmodel.dart';
import 'package:librarybook/viewmodels/book_viewmodel.dart';
import 'package:librarybook/viewmodels/image_viewmodel.dart';
import 'package:librarybook/views/pages/library/library_screen.dart';
import 'package:librarybook/views/pages/main_page.dart';
import 'package:provider/provider.dart';
import 'package:librarybook/res/validation.dart';

class AddandEditBook extends StatefulWidget {
  AddandEditBook(
      {super.key, this.isUpdate, this.book, this.bookid, this.isCreate , this.index});
  bool? isUpdate;
  bool? isCreate;
  BookData? book;
  var index;
  var bookid;
  @override
  State<AddandEditBook> createState() => _AddandEditBookState();
}

class _AddandEditBookState extends State<AddandEditBook> {
  PickedFile? pickedfile;
  var uploading = false;
  var isImagePicked = false;
  var imageViewModel;
  var bookviewModel;
  var imageid;
  var imagefile;
  var summit = false;
  var authorViewModel = AuthorViewModel();
  var globalkey = GlobalKey<FormState>();
  var globalkey_two = GlobalKey<FormState>();
  var globalkey_three = GlobalKey<FormState>();
  var globalkey_four = GlobalKey<FormState>();
  var globalkey_five = GlobalKey<FormState>();
  var titlebook = TextEditingController();
  var desbook = TextEditingController();
  var bookcode = TextEditingController();
  var bookprice = TextEditingController();
  var listitem = [];
  var index = 0;
  var data = <dynamic>[];
  var currentvalue;
  var authorid;
  var listrate = ['0', '1', '2', '3', '4', '5'];
  var currentrate;

  @override
  void initState() {
    authorViewModel.getAllAuthor();
    imageViewModel = ImageViewModel();
    bookviewModel = BookViewModel();
    if (widget.isUpdate!) {
      titlebook.text = widget.book!.attributes!.title.toString();
      desbook.text = widget.book!.attributes!.description.toString();
      bookcode.text = widget.book!.attributes!.code.toString();
      bookprice.text = widget.book!.attributes!.price.toString();
      currentrate = widget.book!.attributes!.starReview.toString();
      currentvalue =
          widget.book?.attributes?.ibAuthor?.data?.attributes?.name.toString();
      authorid = widget.book?.attributes?.ibAuthor?.data?.id.toString();
      imageid = widget.book?.attributes?.thumbnail?.data?.id.toString();
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
              Navigator.pop(context);
            }
          },
        ),
        elevation: 0,
        backgroundColor: Appcolor.nbcolor.withOpacity(0.5),
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Create Book'),
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
                                        ? widget.book?.attributes?.thumbnail
                                                    ?.data?.attributes?.url ==
                                                null
                                            ? Image.network(
                                                'https://cms.istad.co/uploads/thumbnail_Nullimage_11064259fd.PNG',
                                                fit: BoxFit.cover,
                                              )
                                            : Image.network(
                                                AppUrl.domain +
                                                    widget
                                                        .book!
                                                        .attributes!
                                                        .thumbnail!
                                                        .data!
                                                        .attributes!
                                                        .url!,
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
                      controller: titlebook,
                      autocorrect: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor:AppColor.wcolor,
                        labelText: 'Book Title',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        helperText: '',
                        suffixIcon: IconButton(
                          onPressed: () => titlebook.clear(),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        hintText: 'Book Title',
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
                      validator: (title) {
                        if (InputValidator.isTitleValid(title.toString())) {
                          return null;
                        } else {
                          return 'Your book title is empty';
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
                      controller: desbook,
                      autocorrect: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor:AppColor.wcolor,
                        labelText: 'Book Description',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        helperText: '',
                        suffixIcon: IconButton(
                          onPressed: () => titlebook.clear(),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        hintText: 'Book Description',
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
                      validator: (bookds) {
                        if (InputValidator.isTitleValid(bookds.toString())) {
                          return null;
                        } else {
                          return 'Your book description is empty';
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
                  height: 10,
                ),
                Form(
                  key: globalkey_three,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: bookcode,
                      autocorrect: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor:AppColor.wcolor,
                        labelText: 'Book Code',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        helperText: '',
                        suffixIcon: IconButton(
                          onPressed: () => titlebook.clear(),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        hintText: 'Book Code',
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
                      validator: (bookcode) {
                        if (InputValidator.isTitleValid(bookcode.toString())) {
                          return null;
                        } else {
                          return 'Your book code is empty';
                        }
                      },
                      onChanged: (value) {
                        if (globalkey_three.currentState!.validate()) {
                          globalkey_three.currentState!.save();
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (globalkey_three.currentState!.validate()) {
                          globalkey_three.currentState!.save();
                        }
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: globalkey_four,
                  child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: bookprice,
                      autocorrect: true,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        filled: true,
                        //fillColor:AppColor.wcolor,
                        labelText: 'Book Price',
                        labelStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        helperText: '',
                        suffixIcon: IconButton(
                          onPressed: () => titlebook.clear(),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        hintText: 'Book Price',
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
                      validator: (bookprice) {
                        if (InputValidator.isTitleValid(bookprice.toString())) {
                          return null;
                        } else {
                          return 'Your book price is empty';
                        }
                      },
                      onChanged: (value) {
                        if (globalkey_four.currentState!.validate()) {
                          globalkey_four.currentState!.save();
                        }
                      },
                      onFieldSubmitted: (value) {
                        if (globalkey_four.currentState!.validate()) {
                          globalkey_four.currentState!.save();
                        }
                      }),
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: ChangeNotifierProvider(
                      create: (context) => authorViewModel,
                      child: Consumer<AuthorViewModel>(
                        builder: (context, author, _) {
                          var status = author.apiResponse.status;
                          var length = author.apiResponse.data?.data.length;
                          //print('Length Author :$length');
                          //print('stauts :$status');
                          switch (status) {
                            case Status.LOADING:
                              return const ChooseAuthorWidget();
                            case Status.COMPLETED:
                              listitem.clear();
                              data.clear();
                              for (int index = 0; index < length!; index++) {
                                var authorid =
                                    author.apiResponse.data?.data[index].id;
                                var authorname = author.apiResponse.data
                                    ?.data[index].attributes?.name;
                                data.add(authorid);
                                listitem.add(authorname);
                                //currentvalue ??= listitem.elementAt(0);
                                // if (currentvalue == authorname) {

                                // } else if (currentrate != authorname) {
                                //   currentvalue = null;
                                // }
                              }

                              return DropdownButton(
                                dropdownColor: Appcolor.fixcolor.withOpacity(1),
                                menuMaxHeight: 500,
                                isDense: true,
                                value: currentvalue,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    uploading = false;
                                    currentvalue = value;
                                    print("currentvalue = $currentvalue");
                                    authorid = value;
                                    index = listitem.indexOf(value);
                                    authorid = data.elementAt(index).toString();
                                    print('Author ID : $authorid');
                                  });
                                },
                                items: listitem.map((name) {
                                  return DropdownMenuItem(
                                    value: name,
                                    alignment: Alignment.center,
                                    child: Text(name.toString()),
                                  );
                                }).toList(),
                                hint: const Text(
                                  'Choose Author',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                elevation: 0,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                isExpanded: true,
                                iconSize: 25,
                                icon: const Icon(Icons.arrow_drop_down_circle),
                              );
                            case Status.ERROR:
                              return const ChooseAuthorWidget();
                            default:
                              return const ChooseAuthorWidget();
                          }
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isDense: true,
                      value: currentrate,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                      onChanged: (value) {
                        setState(() {
                          uploading = false;
                          currentrate = value;
                        });
                      },
                      items: listrate.map((rate) {
                        return DropdownMenuItem(
                          value: rate,
                          alignment: Alignment.center,
                          child: Text(rate.toString()),
                        );
                      }).toList(),
                      hint: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rating',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      elevation: 0,
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_drop_down_circle),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  width: double.maxFinite,
                  child: ChangeNotifierProvider<BookViewModel>(
                    create: (context) => bookviewModel,
                    child: Consumer<BookViewModel>(
                      builder: (context, viewModel, _) {
                        //var status = viewModel.apiResponse.status;
                        print(
                            'status Summit Book : ${viewModel.apiResponse.status}');
                        if (viewModel.apiResponse.status == Status.COMPLETED) {
                          viewModel.apiResponse.status = Status.LOADING;
                          WidgetsBinding.instance
                              .addPostFrameCallback((timeStamp) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: widget.isUpdate == true
                                    ? const Text('Update book Successfully')
                                    : const Text('Upload book Successfully')));
                          });
                        }

                        return ElevatedButton(
                          onPressed: () {
                            if (titlebook.text.length == 0 ||
                                bookcode.text.length == 0 ||
                                desbook.text.length == 0 ||
                                bookprice.text.length == 0 ||
                                currentrate == null ||
                                currentvalue == null) {
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
                                postBook(widget.isUpdate);
                                if (widget.isUpdate == false) {
                                  clearData();
                                } else if (widget.isUpdate == true) {
                                  Navigator.pop(context, true);
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
    titlebook.clear();
    desbook.clear();
    bookcode.clear();
    bookprice.clear();
    currentvalue = null;
    currentrate = null;
  }

  void postBook(isUpdate) {
    var book = DataRequest(
        code: bookcode.text,
        title: titlebook.text,
        description: desbook.text,
        price: int.parse(bookprice.text),
        starReview: int.parse(currentrate),
        ibAuthor: authorid.toString(),
        thumbnail: imageid.toString());

    if (isUpdate) {
      print('edit book');
      print('Book id : ${widget.bookid}');
      bookviewModel.putBook(book, widget.bookid);

      String? photo;
      print("Url = $photo");

      if (isImagePicked == true) {
        photo = imageViewModel.imageResponse.data!.url;
      } else if (isImagePicked == false) {
        photo = widget.book?.attributes?.thumbnail?.data?.attributes?.url;
      }
      Provider.of<Book>(context, listen: false).updatenBook(
          photo,
          titlebook.text,
          desbook.text,
          bookcode.text,
          int.parse(bookprice.text),
          currentvalue,
          currentrate,
          widget.index);
    } else {
      print('post book');
      bookviewModel.postBook(book);
    }
  }
}

class ChooseAuthorWidget extends StatelessWidget {
  const ChooseAuthorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Choose Author',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.arrow_drop_down_circle,
              size: 25,
              color: Colors.grey.shade700,
            )
          ],
        ));
  }
}
