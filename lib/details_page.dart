// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, deprecated_member_use, unnecessary_import, prefer_const_declarations, dead_code, avoid_print, unnecessary_null_comparison, use_key_in_widget_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/data.dart';

class DetailsPage extends StatefulWidget {
	const DetailsPage(this.newListing, this.index);

	final Listing newListing;
	final int index;

	@override
	State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
	int selectedIndex = -1;//dont set it to 0

	bool isExpanded = false;
	bool selected = false;

	@override
	Widget build(BuildContext context) {
		Size size = MediaQuery.of(context).size;

		return Scaffold(
				body: SafeArea(
			child: Stack(
				children: [
					Positioned.fill(
							bottom: size.height * 0.45,
							child: GestureDetector(
								child: buildCarousel(context),
								onTap: () {
									Navigator.push(
										context,
										MaterialPageRoute(builder: (context) => photoViewer(context, 0)),
									);
								},
							)),
					Positioned(
						left: 20,
						top: 20,
						child: GestureDetector(
							onTap: () {
								Navigator.pop(context);
							},
							child: Container(
								decoration: BoxDecoration(
									gradient: LinearGradient(
										begin: Alignment.topCenter,
										end: Alignment.bottomCenter,
										colors: [
											Color.fromARGB(0, 0, 0, 19),
											Colors.black.withOpacity(0.7),
										],
									),
									shape: BoxShape.rectangle,
									borderRadius: BorderRadius.circular(10),
									//color: Color.fromARGB(0, 221, 38, 38),
								),
								child: Icon(
									Icons.arrow_back_ios_rounded,
									color: Colors.white,
									size: 30,
								),
							),
						),
					),
					Positioned(
						right: 20,
						top: 20,
						child: GestureDetector(
							onTap: () {
                _showBottomSheet();
              },
							child: Container(
								decoration: BoxDecoration(
									gradient: LinearGradient(
										begin: Alignment.topCenter,
										end: Alignment.bottomCenter,
										colors: [
											Color.fromARGB(0, 0, 0, 19),
											Colors.black.withOpacity(0.7),
										],
									),
									shape: BoxShape.rectangle,
									borderRadius: BorderRadius.circular(10),
									//color: Color.fromARGB(0, 221, 38, 38),
								),
								child: Icon(
									Icons.more_horiz_outlined,
									color: Colors.white,
									size: 30,
								),
							),
						),
					),
					Positioned(
						left: 10,
						top: 180,
						child: Padding(
							padding: EdgeInsets.symmetric(vertical: 8),
              child: Text(
                widget.newListing.info[widget.index]["i_price"] == null ?  "TL5000000" :
                                  widget.newListing.info[widget.index]["i_price"] + 'TL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
							// child: Container(
							// 	decoration: BoxDecoration(
							// 		color: Colors.yellow[700],
							// 		borderRadius: BorderRadius.all(
							// 			Radius.circular(5),
							// 		),
							// 	),
							// 	width: 100,
							// 	padding: EdgeInsets.symmetric(
							// 		vertical: 4,
							// 	),
							// 	child: Center(
							// 		child: Text(
							// 			widget.newListing.info[widget.index]['process'],
							// 			style: TextStyle(
							// 				color: Colors.white,
							// 				fontSize: 15,
							// 				fontWeight: FontWeight.bold,
							// 			),
							// 		),
							// 	),
							// ),
						),
					),
					Positioned(
						//left: 10,
						top: 220,
						child: Padding(
							padding: EdgeInsets.all(10),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									Text(
										widget.newListing.info[widget.index]['s_title'] ?? "No Title",
										style: TextStyle(
											color: Colors.white,
											fontSize: 24,
											fontWeight: FontWeight.bold,
										),
									),
								],
							),
						),
					),
					Positioned.fill(
						child: NotificationListener<DraggableScrollableNotification>(
								// onNotification: (notification) {
								//   // setState(() {
								//   //   _percent = 2 * notification.extent - 0.8;
								//   // });

								//   // return true;
								// },
							child: DraggableScrollableSheet(
						maxChildSize: 0.9,
						minChildSize: 0.5,
						initialChildSize: 0.6,
						builder: (_, controller) {
							return Material(
								elevation: 10,
								borderRadius: BorderRadius.only(
									topLeft: Radius.circular(15),
									topRight: Radius.circular(15),
								),
								color: Colors.white,
								child: ListView(
									controller: controller,
									children: [
										Center(
												child: Column(
											children: [
												Container(
													margin: EdgeInsets.all(5),
													height: 4,
													width: 50,
													decoration: BoxDecoration(
														borderRadius: BorderRadius.circular(5),
														color: Color.fromARGB(255, 212, 209, 209),
													),
												),
												Padding(
													padding: EdgeInsets.only(
															right: 24, left: 24, bottom: 16, top: 15),
													child: Text(
														"Listing Info".tr,
														style: TextStyle(
															fontSize: 18,
															fontWeight: FontWeight.bold,
														),
													),
												),
											],
										)),
										Divider(
											indent: 10,
											endIndent: 10,
											color: Colors.grey[500],
											height: 1,
										),
										Padding(
											padding: EdgeInsets.all(24),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: [
													Row(
														children: [
															Icon(
																Icons.person_pin,
																size: 60,
															),
															SizedBox(
																width: 16,
															),
															Column(
																crossAxisAlignment: CrossAxisAlignment.start,
																children: [
																	Text(
																		widget.newListing.info[widget.index]
																				['s_user_name'] ?? widget.newListing.info[widget.index]
																				['s_contact_name'],
																		style: TextStyle(
																			fontSize: 20,
																			fontWeight: FontWeight.bold,
																		),
																	),
																	SizedBox(
																		height: 4,
																	),
																	Text(
																		"Property Owner".tr,
																		style: TextStyle(
																			fontSize: 18,
																			color: Colors.grey[500],
																		),
																	),
																],
															),
														],
													),
												],
											),
										),
										Divider(
											indent: 10,
											endIndent: 10,
											color: Colors.grey[500],
											height: 1,
										),
										Padding(
											padding: EdgeInsets.only(
													right: 24, left: 24, bottom: 24, top: 15),
											child: Row(
												mainAxisAlignment: MainAxisAlignment.spaceBetween,
												children: [
													buildFeature(Icons.hotel, "3 Bedroom".tr),
													buildFeature(Icons.wc, "2 Bathroom".tr),
													buildFeature(Icons.kitchen, "1 Kitchen".tr),
													buildFeature(Icons.local_parking, "2 Parking".tr),
												],
											),
										),
										Padding(
											padding: EdgeInsets.only(
												right: 5,
												left: 5,
												bottom: 16,
											),
											child: ExpansionTile(
												initiallyExpanded: true,
												backgroundColor: Color.fromARGB(255, 245, 242, 242),
												title: Text(
													'Details'.tr,
													style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),
												),
												children: [
													buildInfo(context, 'Title'.tr, 's_title'),
													buildInfo(context, 'About'.tr, 's_description'),
													buildInfo(context, 'Phone'.tr, 's_contact_phone'),
													buildInfo(context, 'Email'.tr, 's_contact_email'),
													//buildInfo(context, 'Price'.tr, 'i_price'),
													buildInfo(context, 'State'.tr, 's_region'),
													buildInfo(context, 'Address'.tr, 's_address'),
													buildInfo(context, 'Posted on'.tr, 'dt_pub_date'),
												],
											),
										),
										Padding(
											padding: EdgeInsets.only(
												right: 24,
												left: 24,
												bottom: 16,
											),
											child: Text(
												"Photos".tr,
												style: TextStyle(
													fontSize: 20,
													fontWeight: FontWeight.bold,
												),
											),
										),
										Container(
											height: 170,
											child: ListView(
												physics: ClampingScrollPhysics(),
												scrollDirection: Axis.horizontal,
												shrinkWrap: true,
												children:
														buildPhotos(context, widget.newListing.images),
											),
										),
										SizedBox(
											height: 4,
										),
									],
								),
							);
						},
					))),
				],
			),
		));
	}

	Widget buildCarousel(BuildContext context) {
		Size size = MediaQuery.of(context).size;

		final List<Widget> imageSliders = widget.newListing.images
				.map((item) => Container(
							child: Container(
								margin: EdgeInsets.only(
									left: 1,
								),
								child: ClipRRect(
										borderRadius: BorderRadius.all(Radius.circular(5.0)),
										child: Stack(
											children: <Widget>[
												Image.network(
													item,
													fit: BoxFit.cover,
													width: 1000.0,
													height: 1000,
													//cacheWidth: (size.width * 1).toInt(),
													//cacheHeight: (size.height * 0.6).toInt(),
												),
												Positioned.fill(
													bottom: 0.0,
													left: 0.0,
													right: 0.0,
													child: Container(
														decoration: BoxDecoration(
															gradient: LinearGradient(
																colors: [
																	Colors.transparent,
																	Colors.black.withOpacity(0.7),
																],
																begin: Alignment.topCenter,
																end: Alignment.bottomCenter,
															),
														),
														padding: EdgeInsets.symmetric(
																vertical: 10.0, horizontal: 20.0),
														child: Text(
															'',
															//'${widget.newListing.images.indexOf(item)}',
															style: TextStyle(
																color: Colors.white,
																fontSize: 13.0,
																fontWeight: FontWeight.bold,
															),
														),
													),
												),
											],
										)),
							),
						))
				.toList();

		return CarouselSlider(
			options: CarouselOptions(
				//aspectRatio: 1,
				//viewportFraction: 0.79,
				autoPlay: true,
				height: size.height * 0.6,
				autoPlayCurve: Curves.fastOutSlowIn,
				//enlargeCenterPage: true,
				// enlargeStrategy: CenterPageEnlargeStrategy.scale,
			),
			items: imageSliders,
		);
	}

	Widget buildInfo(BuildContext context, String title, String subtitle) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			children: [
				Divider(
					indent: 10,
					endIndent: 10,
					color: Colors.grey[500],
					height: 1,
				),
				Padding(
					padding: EdgeInsets.only(right: 24, left: 24, bottom: 16, top: 15),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							Text(
								title,
								style: TextStyle(
									fontSize: 15,
									fontWeight: FontWeight.bold,
								),
							),
							SizedBox(
								height: 4,
							),
							Text(
								widget.newListing.info[widget.index][subtitle] ?? "Not Specified",
								style: TextStyle(
									fontSize: 15,
									color: Colors.grey[500],
								),
							),
						],
					),
				),
			],
		);
	}

	List<Widget> buildPhotos(BuildContext context, List<String> images) {
		List<Widget> list = [];
		list.add(SizedBox(
			width: 15,
		));
		for (var i = 0; i < images.length; i++) {
			list.add(buildPhoto(context, images[i], i));
		}
		return list;
	}

	Widget buildPhoto(BuildContext context, String url, int index) {
		return GestureDetector(
			child: SizedBox(
				child: Container(
					width: 180,
					margin: EdgeInsets.all(16),
					child: ClipRRect(
						borderRadius: BorderRadius.circular(10),
						child: Image.network(
							url,
							fit: BoxFit.cover,
						),
					),
				),
			),
			onTap: () {
				Navigator.push(
					context,
					MaterialPageRoute(builder: (context) => photoViewer(context, index)),
				);
			},
		);
	}

	Widget buildFeature(IconData iconData, String text) {
		return Column(
			children: [
				Icon(
					iconData,
					color: Colors.yellow[700],
					size: 28,
				),
				SizedBox(
					height: 8,
				),
				Text(
					text,
					style: TextStyle(
						color: Colors.grey[500],
						fontSize: 14,
					),
				),
			],
		);
	}

	Widget photoViewer(BuildContext context, int i) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: Colors.black,
				foregroundColor: Colors.white,
			),
			body: PhotoViewGallery.builder(
				itemCount: widget.newListing.images.length,
				builder: (context, i) {
					return PhotoViewGalleryPageOptions(
						imageProvider: NetworkImage(widget.newListing.images[i]),
						minScale: PhotoViewComputedScale.contained * 0.8,
						maxScale: PhotoViewComputedScale.covered * 2,
					);
				},
				scrollPhysics: BouncingScrollPhysics(),
			),
		);
	}

  void _showBottomSheet(){
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context){ 
        return Wrap(
          children: [
            buildInfo(context, 'Edit'.tr, ''),
            buildInfo(context, 'Share'.tr, ''),
            buildInfo(context, 'Delete'.tr, ''),
            //Filter(),
          ],
        );
      }
    );
  }

	// Widget blackIconTiles(){
	// 	return Container(
	// 		//width: 200,
	// 		//color: Colorz.complexDrawerBlack,
	// 		child: Column(
	// 			children: [
	// 				//controlTile(),
	// 				Expanded(
	// 					child: ListView(  
							
	// 						 return ExpansionTile(
	// 							 onExpansionChanged:(z){
	// 								 setState(() {
	// 									 selectedIndex = z?index:-1;
	// 								 });
	// 							 },
	// 						 leading: Icon(cdm.icon,color: Colors.white),
	// 							title: Text(
	// 								'Details'.tr,
	// 								style: TextStyle(),
	// 							),
	// 							trailing: Icon(selected?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,
	// 								color: Colors.white,
	// 							),
	// 							children: cdm.submenus.map((subMenu){
	// 								return sMenuButton(subMenu, false);
	// 							}).toList()
	// 						);
	// 					 },
	// 					),
	// 				),
	// 				//accountTile(),
	// 			],
	// 		),
	// 	);
	// }

	// static List<CDM> cdms = [
	 
	// 	CDM(Icons.subscriptions, "Details".tr, [buildInfo(context, 'Title'.tr, 'title'), "Javascript","PHP & MySQL"]),
	// ];

	Widget appBar(BuildContext context) {
		return Material(
				elevation: 10,
				child: Row(
					children: [
						GestureDetector(
							onTap: () {
								Navigator.pop(context);
							},
							child: Icon(
								Icons.arrow_back_ios,
								color: Colors.black,
								size: 24,
							),
						),
						Spacer(),
						GestureDetector(
							onTap: () {},
							child: Icon(
								Icons.more_horiz,
								color: Colors.black,
								size: 24,
							),
						),
					],
				));
	}
}
