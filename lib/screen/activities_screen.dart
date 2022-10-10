
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ui_travel_app/components/custom_header.dart';
import 'package:ui_travel_app/models/activity_model.dart';
import 'package:ui_travel_app/screen/activity_details_screen.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  static const routeName = '/activities';


  @override
  Widget build(BuildContext context) {

    List<ActivityModel> activityList = ActivityModel.activities;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 50,),
          const CustomHeader(title: 'Activities',),
          _ActivitiesMasonryGrid(
            width: width,
            activityList: activityList
          )
        ],
      ),
    );
  }
}

class _ActivitiesMasonryGrid extends StatelessWidget {
  const _ActivitiesMasonryGrid({
    Key? key,
    this.masonryCardHeights = const [200, 250, 300],
    required this.activityList,
    required this.width
  }) : super(key: key);

  final List<double> masonryCardHeights;
  final List<ActivityModel> activityList;
  final double width;


  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      itemCount: activityList.length,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      itemBuilder: (context, index){
        ActivityModel activity = activityList[index];
        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ActivityDetailsScreen(
                  activity: activity
                ),
              )
            );
          },
          child: Column(
            children: [
              Hero(
                tag: '${activity.id}_${activity.title}',
                child: Container(
                  height: masonryCardHeights[index % 3],
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(activity.imageUrl),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                activity.title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
                maxLines: 3,
              )
            ],
          ),
        );
      },
    );
  }
}




