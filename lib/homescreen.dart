import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'timing.dart';
import 'package:lottie/lottie.dart';

late Future<List<Timing>> futureFetch;

Future<List<Timing>> _getTime() async {
  // Fetch the response from the URL

  String getLink = urlget(); //To get the URL link
  var response = await http.get(Uri.parse(getLink));
  var body = json.decode(response.body);
  return body.map<Timing>(Timing.fromJson).toList();
}

//links
String urlget() {
  switch (valueChoose) {
    case "Arani":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Arcot":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Bengaluru":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Chengalpattu":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Chennai":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Gingee":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Kanchipuram":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Melmaruvathur":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Salem":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Pondicherry":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Tambaram":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Thiruthani":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Tindivanam":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Tirupati":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Thiruvannamalai":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Trichy":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Vandavasi":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    case "Vellore":
      return "https://santhosh24-sk.github.io/Samplejson/" +
          valueChoose.toString() +
          ".json";
    default:
      return "0";
  }
}

final String adUnitId = "ca-app-pub-5552605139399024/8964626650";
final String adInterId = "ca-app-pub-5552605139399024/1658853836";

//final String adUnitId = "ca-app-pub-5552605139399024/2661550950"; //real Ads
//final String adInterId = "ca-app-pub-5552605139399024/1851178267"; //real Ads
//final String adUnitId = "ca-app-pub-3940256099942544/6300978111"; //Test ads
//final String adInterId = 'ca-app-pub-3940256099942544/1033173712'; //Test Ads
String? valueChoose;
int adCount = 0;
List<String> places = <String>[
  'Arani',
  'Arcot',
  'Bengaluru',
  'Chengalpattu',
  'Chennai',
  'Gingee',
  'Kanchipuram',
  'Melmaruvathur',
  'Salem',
  'Pondicherry',
  'Tambaram',
  'Thiruthani',
  'Tindivanam',
  'Tirupati',
  'Thiruvannamalai',
  'Trichy',
  'Vandavasi',
  'Vellore'
];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(HomeApp());
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;

  void _loadAd() {
    final bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: adUnitId,
      request: const AdRequest(),
      listener: BannerAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    );

    // Start loading.
    bannerAd.load();
  }

  void loadAdInter() {
    InterstitialAd.load(
        adUnitId: adInterId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad) {
                loadAdInter();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
                //loadAdInter();
              },
              onAdImpression: (ad) {
                //loadAdInter();
              },
              onAdDismissedFullScreenContent: (ad) {
                //loadAdInter();
              },
            );
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
            loadAdInter();
          },
        ));
  }

  void adcountfunc() {
    if (adCount % 2 == 0) {
      _interstitialAd?.show();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFetch = _getTime();
    _loadAd();
    loadAdInter();
  }

  bool _test_visibility = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.white,
            //   title: Text("Cheyyar Bus", style: TextStyle(fontSize: 22, color: Color(0xFF005075)),),
            // ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  //color: Color.fromRGBO(2, 143, 199, 1),
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "CHEYYAR BUS",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color.fromARGB(255, 1, 145, 137)),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.only(top: 2, left: 12, right: 12, bottom: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          Color(0xFF01B0B6),
                          Color.fromRGBO(1, 224, 213, 1)
                        ],
                        //colors: [Color.fromARGB(255, 250, 118, 56), Color.fromARGB(255, 252, 184, 59)],
                        begin: AlignmentDirectional.topCenter,
                        end: AlignmentDirectional.bottomCenter),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 3),
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.transparent, width: 0.1),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 15, right: 1),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                      ),
                                      BoxShadow(
                                        color: Colors.white70,
                                        spreadRadius: -1.0,
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                    border: Border.all(
                                        color: Colors.transparent, width: 2),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        bottomLeft: Radius.circular(16)),
                                  ),
                                  child: DropdownButton(
                                    underline: SizedBox(),
                                    icon: const Icon(
                                        Icons.arrow_drop_down_rounded),
                                    hint: const Text('Select the Place'),
                                    dropdownColor: Colors.white,
                                    iconSize: 36,
                                    isExpanded: true,
                                    value: valueChoose,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        valueChoose = newValue;
                                      });
                                    },
                                    items: places.map<DropdownMenuItem<String>>(
                                        (String valueItem) {
                                      return DropdownMenuItem<String>(
                                        value: valueItem,
                                        child: Text(valueItem),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(14),
                                    bottomRight: Radius.circular(14)),
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.search_rounded,
                                  size: 32,
                                ),
                                onPressed: () {
                                  if (valueChoose == null) {
                                  } else {
                                    setState(() {
                                      adCount = adCount + 1;
                                      adcountfunc();
                                      futureFetch = _getTime();
                                      _test_visibility = true;
                                    });
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Visibility(
                        visible: _test_visibility,
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 5, 8, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CHEYYAR ",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                                Icon(Icons.keyboard_double_arrow_right_rounded,
                                    size: 22, color: Colors.white),
                                Text(
                                  " " + valueChoose.toString().toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(8.0),
                            padding: EdgeInsets.fromLTRB(10, 5, 8, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Time",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Bus Name",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: 4, left: 8, bottom: 10, right: 8),
                    child: Center(
                      child: FutureBuilder(
                        future: futureFetch,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              width: 100,
                              height: 100,
                              child: LottieBuilder.network(
                                'https://lottie.host/1537d7cf-9af1-44c7-bb9c-40934c7befe0/g241QRRhRC.json',
                                repeat: true,
                                animate: true,
                              ),
                            );
                          } else if (snapshot.hasData) {
                            final times = snapshot.data;
                            return ListView.builder(
                              itemCount: times.length,
                              itemBuilder: (BuildContext context, int index) {
                                final t = times[index];
                                return Container(
                                  margin: EdgeInsets.all(8.0),
                                  padding: EdgeInsets.fromLTRB(10, 5, 8, 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Color(0xFF04C5CF),
                                          width: 2,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.blueAccent.withAlpha(50),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: Offset(0, 4)),
                                      ]),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        t.time,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        t.bus,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            return Container(
                              width: 200,
                              height: 200,
                              child: Lottie.network(
                                  'https://lottie.host/1e1a3c77-c9c5-4424-84b3-606ce93483b2/OYdmDV79uT.json',
                                  repeat: true,
                                  animate: true),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AdSize.banner.width.toDouble(),
                  height: AdSize.banner.height.toDouble(),
                  child: _bannerAd == null
                      // Nothing to render yet.
                      ? SizedBox()
                      // The actual ad.
                      : AdWidget(ad: _bannerAd!),
                ),
              ],
            ),
          ),
        ));
  }
}
