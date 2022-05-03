import 'package:wathakren/pages/components/custom_button.dart';
import 'package:wathakren/pages/components/titled_box.dart';
import 'package:wathakren/providers/settings_provider.dart';
import 'package:wathakren/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FrequencyController extends StatelessWidget {
  final double width;
  final double paddingTop;

  final List<String> frequencyLabel = [
    "من 5 إلى 10 يومياً",
    "من 10 إلى 18 يومياً ",
    "20 فأكثر يومياً"
  ];
  FrequencyController({Key? key, required this.width, required this.paddingTop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          SizedBox(
            height: paddingTop,
          ),
          Text(
            frequencyLabel[Provider.of<SettingsProvider>(context).frequency],
            maxLines: 1,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Provider.of<ThemeProvider>(context).accentColor),
          ),
          SizedBox(
            height: paddingTop / 4,
          ),
          SizedBox(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Provider.of<SettingsProvider>(context).frequency == 2
                    ? CustomElevatedButton(
                        text: "عـالـي",
                        ontap: () => Provider.of<SettingsProvider>(context,
                                listen: false)
                            .setFrequency(2),
                      )
                    : CustomOutlinedButton(
                        text: "عـالـي",
                        ontap: () => Provider.of<SettingsProvider>(context,
                                listen: false)
                            .setFrequency(2),
                      ),
                Provider.of<SettingsProvider>(context).frequency == 1
                    ? CustomElevatedButton(
                        text: "متوسط",
                        ontap: () => Provider.of<SettingsProvider>(context,
                                listen: false)
                            .setFrequency(1),
                      )
                    : CustomOutlinedButton(
                        text: "متوسط",
                        ontap: () => Provider.of<SettingsProvider>(context,
                                listen: false)
                            .setFrequency(1),
                      ),
                Provider.of<SettingsProvider>(context).frequency == 0
                    ? CustomElevatedButton(
                        text: "منخفض",
                        ontap: () => Provider.of<SettingsProvider>(context,
                                listen: false)
                            .setFrequency(0),
                      )
                    : CustomOutlinedButton(
                        text: "منخفض",
                        ontap: () => Provider.of<SettingsProvider>(context,
                                listen: false)
                            .setFrequency(0),
                      ),
              ],
            ),
          ),
          SizedBox(
            height: paddingTop / 4,
          ),
        ],
      ),
    );
  }
}

class FrequencyBox extends StatefulWidget {
  final Size size;
  const FrequencyBox({Key? key, required this.size}) : super(key: key);

  @override
  State<FrequencyBox> createState() => _FrequencyBoxState();
}

class _FrequencyBoxState extends State<FrequencyBox> {
  @override
  Widget build(BuildContext context) {
    return TitledBox(
      width: widget.size.width * .8,
      title: "معدل ظهور الأذكار على الشاشه",
      child: FrequencyController(
        width: widget.size.width * .8,
        paddingTop: 48,
      ),
    );
  }
}
