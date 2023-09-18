import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleSheetsService {
  final _credentials = ServiceAccountCredentials.fromJson({
    "type": "service_account",
    "project_id": "marandacan",
    "private_key_id": "dbedc705298587de612326fad8d8e4a506c9330f",
    "private_key":
        "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCQwUBksJo3Rt4Y\nkZc7y5Z5TWIb5bGQke4xj18uzErjHrVpzRnM67nKlmi7X2N4JL4Q1GwPJ465vUdT\nCfa5mQy1jfWhHHVhtFY0kKwNEmogFNAQOprAeG3OiMrjzri6CozmJqr/jhmewYYA\nO0RF+caioFsPIFtrwzT+Jp+Q0Av7haS1JwcaWJ8HxdJbdt/IvEe+jZ0fnWgdmzwW\nGsXkkifzCuhUH+fJ5Ujd8usIY9v3nl5kWNelLmnEAX7169Ioi1znj3IQp/Jcx4eE\nYhw9RoG35MS2p3Kb0I7NXz7GG18ACHlkkOEiWJI8J/WUFVNoaJVfTrLxRyit6/2u\npWGPSKR3AgMBAAECggEACsQDCbOkT766onTwtioOvGHLDXKyF71XfwizL9QfMH1A\nFijPWOq7koh7xieysNfgUBJRIRI0Yelkv+IqhXFcPR2pA+NaclRK4jW6RG43Eo2J\nteAUUoLPMKbPmoBTqitCGsg+1ar+ijL8lNE5/PXpIuVhlrvo0+U2PT3auZa6tWkf\nJjtt7OYHgAT44m+G9N7W461+5LCkJM+oytSFxmLuPdCaIpTLxant38K6DBr8JSeN\nyJ52Ft30bt2pbqY/r+LBlc8ZgGiqkV7TVHfgH7BCk7MDGMSuSKBURJF9YBAfY8a9\niTC0bgZ8Q/qikqfWdXLG4/fZJVv/LYqs4hqmVfJ1+QKBgQDDXoLAyeVxE1kM03Qs\nVd6D9lf+zZK8X2cl+wtJjvVXsf/sfooUCssGn3noyJsjaHkhmP+1/0I5IsOliD7I\nLcb+K7z9/kzGHABsuMHXKR+Jlw9951AoGa17T+f9efnHs46m+THjyRhb+7KM/I9S\ndg0FVyr4kuCIVoXVSPswOxJxfwKBgQC9rZatxuKkkwdRo9NrrULR+QZQHCWCEvmB\n/32ap7sw6KvmS7OWvmNg7Z/uzGKZR6mQ4mHW2BWlXt0pJYF4Ok55ar0WMUh4h5Fl\nJuDeIZf1HvAIIsYwinS2Ug7mqsGCQMWzWcolIKriuMr9xE8Qe81NqB8BZ7HzwXHI\n9ExpYZLZCQKBgQCU/jLBTDfKsHKtMWXbmfEEuo4JKEXLmwZTFM1a38eDhaAjf61V\n85U6C80xFiwaKMaYNNJuvaiHYlfKmcknaKHlnP2YxqNOQnSgdZZ+vEHs8GNEJXAf\n5NVEwX+u86LmBa248Tp2+Rm2rJFSrBmxTY5IkF2ZDIpn73RJYEsQUTyTiQKBgQCq\n0EfQqTnzsYC20c0UvAxf4V4BCMfycroFixsHCqQ18GLV2ziYuU3vvS75M1Bb70BR\n/LzVaPVdXqfWZTNKHWAMUcaE1M8J1DRonnGFOUWKdlj9SqumjRl8EzveGMp5TXF9\nCZBUjS23TWlozL/S/Vqu44dAkayc8olQykiB4mAHWQKBgQCxdCi74I4Pr7Cl7cr7\nbpGLgc9qyv3m6TFoAULnWyY87ofY696Y19jVu2hFrfN06GWkRtM6twzJ7bKKclku\ngcwBKfmfx+AOQbwJqWLlq0FYYkF5LXsMyxhIXDZYzRhL8FrY4walCR8h9eYt9TAD\n0ULmgQTgJMrnWR9GHQskTqP/8Q==\n-----END PRIVATE KEY-----\n",
    "client_email": "marandacandb@marandacan.iam.gserviceaccount.com",
    "client_id": "104773851008801158805",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/marandacandb%40marandacan.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com",
  });

  Future<List<List<String>>> fetchData() async {
    final client = await clientViaServiceAccount(_credentials, [SheetsApi.spreadsheetsReadonlyScope]);
    final sheets = SheetsApi(client);
    const spreadsheetId = '1q-BRxCTVV3HA5PsF1m8FneiGs0hWcYReqsIjnvNyVps';
    const range = 'A2:H18';

    try {
      final response = await sheets.spreadsheets.values.get(spreadsheetId, range);
      final values = response.values;
      if (values != null) {
        return values.map((row) => row.map((cell) => cell.toString()).toList()).toList();
      } else {
        return [];
      }
    } finally {
      client.close();
    }
  }
}

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoogleSheetsService _sheetsService = GoogleSheetsService();
  List<List<String>> data = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final sheetData = await _sheetsService.fetchData();
      setState(() {
        data = sheetData;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error loading data: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Function to handle item click
  void onItemClick(String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Clicked Item"),
          content: Text("You clicked on: $item"),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Marandacan Family'),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final row = data[index];

                  final nId = row[0];
                  final nFName = row[1];
                  final nMName = row[2];
                  final nLName = row[3];
                  final nMother = row[4];
                  final nFather = row[5];
                  final nLocation = row[6];
                  final nBirthday = row[7];

                  final item = '$nFName $nMName $nLName';

                  return InkWell(
                    onTap: () {
                      onItemClick(item);
                    },
                    child: ListTile(
                      title: Text(row[0]),
                      subtitle: Text(row[1]),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
