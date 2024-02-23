import 'package:flutter/material.dart';
import 'package:librarybook/provider/author.dart';
import 'package:librarybook/viewmodels/author_viewmodel.dart';
import 'package:librarybook/views/pages/author/add_edit_author.dart';
import 'package:librarybook/views/pages/author/author.dart';
import 'package:librarybook/views/pages/author/widgets/author_book.dart';
import 'package:provider/provider.dart';

import '../../../../data/response/status.dart';
import '../../../../models/authormodel.dart';
import '../../../../res/constants/app_color.dart';

class CardAuthor extends StatefulWidget {
  CardAuthor({super.key, this.author, this.authorid, this.index});
  AuthorsData? author;
  var authorid;
  var index;
  @override
  State<CardAuthor> createState() => _CardAuthorState();
}

enum MenuValues { edit, delete }

class _CardAuthorState extends State<CardAuthor> {
  AuthorScreenState screen = AuthorScreenState();

  @override
  Widget build(BuildContext context) {
    //final author = Provider.of<AuthorViewModel>;
    return Container(
      padding: const EdgeInsets.only(
        top: 20,
      ),
      decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, 100),
          borderRadius: BorderRadius.all(Radius.circular(15))),
      height: double.infinity,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Appcolor.fixcolor,
                boxShadow: [
                  BoxShadow(
                      color: Appcolor.fixcolor.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 3,
                      spreadRadius: 2)
                ]),
            child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                    'https://cms.istad.co${widget.author?.attributes?.photo?.data?.attributes?.url}')),
          ),
          const SizedBox(
            height: 10,
          ),
          Text('${widget.author?.attributes?.name}',
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListAuthorBookScreen(
                                authorid: widget.authorid,
                              )));
                },
                icon: const Icon(Icons.book),
                color: Appcolor.nbcolor,
              ),
              PopupMenuButton<MenuValues>(
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    value: MenuValues.edit,
                    child: Row(children: const [
                      Icon(Icons.edit),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Edit')
                    ]),
                  ),
                  PopupMenuItem(
                    value: MenuValues.delete,
                    child: Row(children: const [
                      Icon(Icons.delete),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Delete')
                    ]),
                  ),
                ],
                icon: const Icon(
                  Icons.menu_sharp,
                  color: Appcolor.nbcolor,
                ),
                onSelected: (value) {
                  switch (value) {
                    case MenuValues.edit:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddandEditAuthor(
                              isUpdate: true,
                              author: widget.author,
                              isCreate: true,
                              authorid: widget.authorid,
                              index: widget.index ,
                            ),
                          ));
                      break;
                    case MenuValues.delete:
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Are you sure to remove'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('NO')),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                              Provider.of<AuthorViewModel>(context,listen: false).deleteAuthor(widget.authorid);
                                              Provider.of<Author>(context,listen: false).removeAuthor(widget.index);
                                          Navigator.of(context).pop();
                                        });
                                        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LibraryScreen()  ));
                                      },
                                      child: const Text('Yes'))

                                  //   }),
                                  // )
                                ],
                              ));

                      break;
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
