

import '../../../DB/CRUD.dart';
import '../../../LinksConnect/LinksAPI.dart';

class StoreRemoteData {
  CRUD crud;

  StoreRemoteData(this.crud);

  getStore(categories_id) async {
    var response = await crud.postData(LinksApp.linkStore, {
      "categories_id":categories_id .toString(),
     });
    return response.fold((l) => l, (r) => r);
  }
  getStoreAll() async {
    var response = await crud.postData(LinksApp.linkStoreAll, {

    });
    return response.fold((l) => l, (r) => r);
  }
  getAllProduct() async {
    var response = await crud.postData(LinksApp.linkStoreproducts, {
    });
    return response.fold((l) => l, (r) => r);
  }
  getAllCategory() async {
    var response = await crud.postData(LinksApp.linkStorecategories, {
    });
    return response.fold((l) => l, (r) => r);
  }










  insertInvoic(invoice_userId,invoice_productID ,invoice_productName,invoice_productQuantity,invoice_productPrice,invoice_productDiscount,invoice_priceShip,invoice_totalPrice,invoice_shipCo,invoice_productImg) async {
    var response = await crud.postData(LinksApp.linkStoreInsertInvoice, {
      "invoice_userId":invoice_userId.toString()!,
      "invoice_productID":invoice_productID.toString()!,
      "invoice_productName":invoice_productName.toString()!,

      "invoice_productQuantity":invoice_productQuantity.toString()!,
      "invoice_productPrice":invoice_productPrice.toString()!,
      "invoice_productDiscount":invoice_productDiscount.toString()!,

      "invoice_priceShip":invoice_priceShip.toString()!,
      "invoice_totalPrice":invoice_totalPrice.toString()!,
      "invoice_shipCo":invoice_shipCo.toString()!,
      "invoice_productImg":invoice_productImg.toString()!,
    });
    return response.fold((l) => l, (r) => r);
  }

  getInvoiceAll(invoice_userId) async {
    var response = await crud.postData(LinksApp.linkStoreInvoiceAll, {
"invoice_userId":invoice_userId.toString()
    });
    return response.fold((l) => l, (r) => r);
}

  getInvoiceOne(invoice_id) async {
    var response = await crud.postData(LinksApp.linkStoreInvoiceOne, {
      "invoice_id":invoice_id.toString()
    });
    return response.fold((l) => l, (r) => r);
  }

  updateInvoiceAccept(invoice_userId,invoice_id,product_id,product_quantity) async {
    var response = await crud.postData(LinksApp.linkStoreInvoiceUpadte, {
      "invoice_userId":invoice_userId.toString(),
      "invoice_id":invoice_id.toString(),
      "product_id":product_id.toString(),
      "product_quantity":product_quantity.toString(),
    });
    return response.fold((l) => l, (r) => r);
  }




/////////////////////////////////////////////////////////////////////////////store admin
  StoreView() async {
    var response = await crud.postData(LinksApp.linkStoreView, {});
    return response.fold((l) => l, (r) => r);
  }

  StoreUpdate(
      product_id,
      product_name,
      product_name_ar,
      product_quantity,
      product_price,
      product_discount,
      product_categories,
      product_active,
      product_img) async {
    var response = await crud.postData(LinksApp.linkStoreUpdate, {
      "product_id": product_id,
      "product_name": product_name,
      "product_name_ar": product_name_ar,
      "product_quantity": product_quantity,
      "product_price": product_price,
      "product_discount": product_discount,
      "product_categories": product_categories,
      "product_active": product_active,
      "product_img": product_img,
    });
    return response.fold((l) => l, (r) => r);
  }


  StoreUpdateWithFile(
      product_id,
      product_name,
      product_name_ar,
      product_quantity,
      product_price,
      product_discount,
      product_categories,
      product_active,
      product_img,myfile) async {
    var response = await crud.postRequestWithFile(LinksApp.linkStoreUpdate, {
      "product_id": product_id,
      "product_name": product_name,
      "product_name_ar": product_name_ar,
      "product_quantity": product_quantity,
      "product_price": product_price,
      "product_discount": product_discount,
      "product_categories": product_categories,
      "product_active": product_active,
      "product_img": product_img,
    }, myfile);

    // Assuming response is a Map, not using fold
    return response ;
  }






  StoreAdd(product_name, product_name_ar, product_quantity, product_price,
      product_discount, product_categories, product_active, product_img) async {
    var response = await crud.postData(LinksApp.linkStoreAdd, {
      "product_name": product_name,
      "product_name_ar": product_name_ar,
      "product_quantity": product_quantity,
      "product_price": product_price,
      "product_discount": product_discount,
      "product_categories": product_categories,
      "product_active": product_active,
      "product_img": product_img,
    });
    return response.fold((l) => l, (r) => r);
  }

  StoreAddWithFile(
      product_name, product_name_ar, product_quantity, product_price,
      product_discount, product_categories, product_active, product_img,myfile) async {
    var response = await crud.postRequestWithFile(LinksApp.linkStoreAdd, {
      "product_name": product_name,
      "product_name_ar": product_name_ar,
      "product_quantity": product_quantity,
      "product_price": product_price,
      "product_discount": product_discount,
      "product_categories": product_categories,
      "product_active": product_active,
      "product_img": product_img,
    }, myfile);

    // Assuming response is a Map, not using fold
    return response ;
  }





  StoreDelete(product_id) async {
    var response = await crud.postData(LinksApp.linkStoreDelete, {
      "product_id": product_id,
    });
    return response.fold((l) => l, (r) => r);
  }
}
