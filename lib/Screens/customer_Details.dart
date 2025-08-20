import 'package:flutter/material.dart';
import 'package:middle_man/Resources/Data/enums.dart';

class CustomerDetails extends StatefulWidget{
  const CustomerDetails({super.key
  //can add what is required here
  
  });

  //hold the values for when it is called here
  //(values that are transfered from the previous class)
  
  @override
  State<CustomerDetails> createState() => _CustomerDetails();

}

class _CustomerDetails extends State<CustomerDetails> {
  final provinceController = TextEditingController();
  Provinces selectedProvince = Provinces.EC;
  Object cities = ECcities;
  Object selectedCity = ECcities.Mthatha;

  @override
  Widget build(BuildContext context){ 
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container( // provincve drop down menu below 
              color:  Color.fromARGB(255, 235, 233, 233),
              child: SizedBox( 
                width: 150,
                child:
                    DropdownMenu<Provinces>(
                    initialSelection: Provinces.EC,
                    controller: provinceController,
                    // requestFocusOnTap is enabled/disabled by platforms when it is null.
                    // On mobile platforms, this is false by default. Setting this to true will
                    // trigger focus request on the text field and virtual keyboard will appear
                    // afterward. On desktop platforms however, this defaults to true.
                    requestFocusOnTap: true,
                    label: const Text('Province'),
                    onSelected: (Provinces? province) {
                      setState(() {
                        selectedProvince = province!;

                        switch (selectedProvince){
                          case Provinces.WC:
                            cities = WCcities.values;
                            break;
                          case Provinces.FS:
                            cities = FScities.values;
                            break;
                          case Provinces.GAU:
                            cities = GAUcities.values;
                            break;
                          case Provinces.KZN:
                            cities = KZNcities.values;
                            break;
                          case Provinces.LIM:
                            cities = LIMcities.values;
                            break;
                          case Provinces.MPU:
                            cities = MPUcities.values;
                            break;
                          case Provinces.NC:
                            cities = NCcities.values;
                            break;
                          case Provinces.NW:
                            cities = NWcities.values;
                            break;
                          case Provinces.EC:
                            cities = ECcities.values;
                            break;
                        }

                      });
                    },

                    //FIND OUT HOW TO SOLVE THE BELOW TO ENSURE THAT THE CITIES OF 
                    // A SPECIFIC PROVINCE SELECTED ABOVE APPEAR 
                    dropdownMenuEntries: Provinces.values
                      .map<DropdownMenuEntry<Provinces>>(
                          (Provinces province) {
                            return DropdownMenuEntry<Provinces>(
                              value: province,
                              label: province.province,
                              enabled: province.province != '',
                              // style: MenuItemButton.styleFrom(
                              //   foregroundColor: color.color,
                              // ),
                            );
                    }).toList(),
                )
              ),
            ),

            SizedBox (height: 40),
            
            // Container( //city drop down menu below 
            //   color:  Color.fromARGB(255, 235, 233, 233),

              // City depending on province selected
              
              // child: SizedBox( 
              //   width: 150,
              //   child:
              //       DropdownMenu<Object>(
              //       initialSelection: cities,
              //       controller: provinceController,
              //       // requestFocusOnTap is enabled/disabled by platforms when it is null.
              //       // On mobile platforms, this is false by default. Setting this to true will
              //       // trigger focus request on the text field and virtual keyboard will appear
              //       // afterward. On desktop platforms however, this defaults to true.
              //       requestFocusOnTap: true,
              //       label: const Text('Province'),
              //       onSelected: (Object? city) {
              //         setState(() {
              //           selectedCity = city!;
              //         });
              //       },
              //       dropdownMenuEntries: cities.values
              //         .map<DropdownMenuEntry<Provinces>>(
              //             (Object province) {
              //               return DropdownMenuEntry<Provinces>(
              //                 value: province,
              //                 label: province.province,
              //                 enabled: province.province != '',
              //                 // style: MenuItemButton.styleFrom(
              //                 //   foregroundColor: color.color,
              //                 // ),
              //               );
              //       }).toList(),
              //   )
              //),
            //),

            SizedBox (height: 40),

            Container( // city drop down menu below 
              color:  Color.fromARGB(255, 235, 233, 233),
              //decoration: ,
              child: SizedBox(
                width: 150,
                child: TextFormField(
                    //controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: 'Password',),
                    validator: (String? value) {
                    if(value == null || value.isEmpty){
                      return 'Enter your Password please.';
                    }
                      return null;
                    }
                  )
              ),
            ),

            Container( // phyical address 
              color:  Color.fromARGB(255, 235, 233, 233),
              //decoration: ,
              child: SizedBox(
                width: 150,
                child: TextFormField(
                    //controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: 'Password',),
                    validator: (String? value) {
                    if(value == null || value.isEmpty){
                      return 'Enter your Password please.';
                    }
                      return null;
                    }
                  )
              ),
            ),

            Container( //access to location-find how to do this one? 
              color:  Color.fromARGB(255, 235, 233, 233),
              //decoration: ,
              child: SizedBox(
                width: 150,
                child: TextFormField(
                    //controller: passwordController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: 'Password',),
                    validator: (String? value) {
                    if(value == null || value.isEmpty){
                      return 'Enter your Password please.';
                    }
                      return null;
                    }
                  )
              ),
            ),
          ]
        )
      )
    );

  }
}

