enum Provinces {
  EC('Eastern Cape'),
  FS('Free State'),
  GAU('Gauteng'),
  KZN('KwaZulu-Natal'),
  LIM('Limpopo'),
  MPU('Mpumalanga'),
  NC('Northern Cape'),
  NW('North West'),
  WC('Western Cape');
    
  const Provinces(this.province);
  final String province;
}

enum ECcities {
  Mthatha('Mthatha'),
  Cradock('Cradock'),
  EastLondon('East London'),
  Gqeberha('Gqeberha'),
  Makhanda('Makhanda');

  const ECcities(this.city);
  final String city;
}

enum FScities{
  Bloemfontein('Bloemfontein'),
  Welkom('Welkom'),
  Kroonstad('Kroonstad'),
  Sasolburg('Sasolburg'),
  Virginia('Virginia');

  const FScities(this.city);
  final String city;
}

enum GAUcities{
  Johannesburg('Johannesburg'),
  Pretoria('Pretoria'),
  Benoni('Benoni'),
  Roodepoort('Roodepoort'),
  Vereeniging('Vereeniging');

  const GAUcities(this.city);
  final String city;

}

enum KZNcities{
  Durban('Durban'),
  Pietermaritzburg('Petermaritzburg'),
  Newcastle('Newcastle'),
  Empangeni('Empangeni'),
  Ulindi('Ulindi');

  const KZNcities(this.city);
  final String city;
}

enum LIMcities{
  Polokwane('Polokwane'),
  Musina('Musina'),
  Giyani('Giyani'),
  Lebowakgomo('Lebowakgomo'),
  Phalaborwa('Phalaborwa');

  const LIMcities(this.city);
  final String city;
}

enum MPUcities{
  Mbombela('Mbombela'),
  Secunda('Secunda'),
  Emalahleni('Emalahleni'),
  Khamani('Khamani'),
  Witbank('Witbank');

  const MPUcities(this.city);
  final String city;

}

enum NWcities{
  Mahikeng('Mahikeng'),
  Potchefstroom('Potchefstroom'),
  Klerksdorp('Klerksdorp'),
  Rusternburg('Rusternburg'),
  Mmabatho('Mmabatho');

  const NWcities(this.city);
  final String city;
}

enum NCcities{
  Kimberley('Kimberley'),
  Kuruman('Kuruman'),
  PortNolloth('Port Nolloth'),
  Galesheke('Galesheke'),
  Vanrhyn('Vanrhyn');

  const NCcities(this.city);
  final String city;
}

enum WCcities{
  CapeTown('Cape Town'),
  Paarl('Paarl'),
  Stellenbosch('Stellenbosch'),
  George('George'),
  Worcester('Worcester');

  const WCcities(this.city);
  final String city;                    

}