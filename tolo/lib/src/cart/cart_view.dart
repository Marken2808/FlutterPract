import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tolo/model/cart.dart';
import 'package:tolo/src/cart/cart_bloc.dart';
import 'package:tolo/src/cart/cart_repository.dart';
import 'package:tolo/src/cart/item/item_view.dart';
import 'package:tolo/src/home/loading_view.dart';
import 'package:tolo/utility/state/status.dart';

class CartView extends StatefulWidget {
  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _navBar(),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitState ||
              // state is CartRefreshState ||
              state.status is StatusSucess) {
            return _sceneBuilder();
          } else {
            return LoadingView();
          }
        },
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  AppBar _navBar() {
    return AppBar(
      title: Text('Shopping List'),
      leading: IconButton(icon: Icon(Icons.menu, size: 30), onPressed: () {}),
    );
  }

  Widget _sceneBuilder() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: CartRepository().getSnapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: RefreshProgressIndicator(),
                );
              }
              // final carts = snapshot.data!.docs;
              List<Cart> carts = (snapshot.data!.docs)
                  .map(
                      (cart) => Cart.fromMap(cart.data()).copyWith(id: cart.id))
                  .toList();
              return Expanded(
                child: ListView.builder(
                  // reverse: true,
                  itemCount: carts.length,
                  itemBuilder: (BuildContext context, int index) {
                    // Cart _cart = Cart.fromMap(carts[index].data())
                    //     .copyWith(id: carts[index].id);
                    return ItemView(cart: carts[index]);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _groupTextField() {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(hintText: 'Add something new?'),
          controller: _titleController,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Some note?'),
          controller: _noteController,
        ),
      ],
    );
  }

  Widget _addCartButton() {
    return ElevatedButton(
      onPressed: () {
        context.read<CartBloc>().add(AddCartEvent(
              cart: Cart(
                title: _titleController.text,
                note: _noteController.text,
                isDone: false,
              ),
            ));
        Navigator.of(context).pop();
        _titleController.clear();
        _noteController.clear();
      },
      child: Text('Add Cart'),
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                _groupTextField(),
                _addCartButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}
