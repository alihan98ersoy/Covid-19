import 'package:covid19/app_localizations.dart';
import 'package:flutter/cupertino.dart';

class TranslationStrings{

  String language; //  TR  -- EN
  String Listbartitle,Aboutbartitle,Staticsbartitle,population,newcases,activecases,totalrecoverd,totalcases,newdeceased,totaldeceased,totaltest,datanull,networkwarning,morethanninecountry,howcaniprotectmyself,maskekullan,washhand,home,distance;
  BuildContext context;
  TranslationStrings(String language,BuildContext context){
    this.language=language;
    this.context=context;
    if(language=="TR"){

      Listbartitle="Covid-19";
      Aboutbartitle="Yardımcı Bilgiler";
      Staticsbartitle="Ülkeler";
      population="Nüfus:";
      newcases="Bugünkü vaka sayısı:";
      activecases="Aktif vaka sayısı:";
      totalrecoverd="Toplam iyileşen sayısı:";
      totalcases="Toplam vaka sayısı:";
      newdeceased="Bugünkü vefat eden sayısı:";
      totaldeceased="Toplam vefat sayısı:";
      totaltest="Toplam test sayısı:";
      datanull = "Seçili günde yeterli veri yok";
      networkwarning="İnternet bağlantınızı kontrol ediniz";
      morethanninecountry = "9 dan fazla ülke ekleyemezsiniz.";
      howcaniprotectmyself = "Kendimizi nasıl koruruz?";
      maskekullan = "Dışarı çıktığınızda maske kullanın\n ve yüzünüze dokunmaktan kaçının.";
      washhand = "Ellerinizi sık sık yıkayın ve \n öksürürken dirsek içine doğru öksürün.";
      home = "Mümkünse evde kalın.";
      distance = "Sosyal mesafenizi koruyun.";



    }else if(language=="EN"){

      Listbartitle="Covid-19";
      Aboutbartitle="Helpful information";
      Staticsbartitle="Countries";
      population="Population:";
      newcases="New cases:";
      activecases="Active cases:";
      totalrecoverd="Total recoverd:";
      totalcases="Total cases:";
      newdeceased="New deceased:";
      totaldeceased="Total deceased:";
      totaltest="Total test:";
      datanull="selected day has not enough data for display";
      networkwarning="Network connection problem";
      morethanninecountry = "Limit is 9 country.";
      howcaniprotectmyself = "How can I protect myself?";
      maskekullan = "Cough or sneeze into your elbow and \n wear a mask.";
      washhand = "Wash your hand frequently \n and thoroughly with soap and water.";
      home = "Stay at home if it's possible";
      distance = "Maintain at least 1 meter (3 feet) \n distance between yourself and others.";

    }

  }

  String Month(String m){

    int i = int.parse(m);
    i--;
    print(i);
    if(language=="TR"){

      var aylar = ["Ocak","Şubat","Mart","Nisan","Mayıs","Haziran","Temmuz","Ağustos","Eylül","Ekim","Kasım","Aralık"];
      return aylar[i];

    }else if(language=="EN"){

      var month = ["January","February","March","April","May","June","July","August","September","October","November","December"];
      return month[i];
    }

    return "null";
  }

  String NumberFortmat(String number){

    if(number.length>4&&(number[0]!="+"||number[0]!="-")){

      if(language=="TR"){

        return number.replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.');

      }else if(language=="EN"){

        return number.replaceAllMapped(new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      }


    }

    return number;
  }
  List<List<String>> countries =[];
  List ENcontries=[];


  String Country(String country){
    country=country.toLowerCase();
    if(language=="TR"){

      if(country=="all"){
        return "Dünya";
      }else if(country=="turkey"){
        return "Türkiye";
      }else if(country=="usa"){
        return "ABD";
      }else if(country=="china"){
        return "Çin";
      }else if(country=="italy"){
        return "İtalya";
      }else if(country=="france"){
        return "Fransa";
      }else if(country=="germany"){
        return "Almanya";
      }else if(country=="uk"){
        return "İngiltere";
      }else if(country=="russia"){
        return "Rusya";
      }else if(country=="qatar"){
        return "Katar";
      }else if(country=="japan"){
        return "Japonya";
      }else if(country=="iraq"){
        return "Irak";
      }else if(country=="india"){
        return "Hindistan";
      }else if(country=="greece"){
        return "Yunanistan";
      }else if(country=="afghanistan"){
        return "Afganistan";
      }else if(country=="albania"){
        return "Arnavutluk";
      }else if(country=="algeria"){
        return "Cezayir";
      }else if(country=="argentina"){
        return "Arjantin";
      }else if(country=="armenia"){
        return "Ermenistan";
      }else if(country=="australia"){
        return "Avustralya";
      }else if(country=="austria"){
        return "Avusturya";
      }else if(country=="azerbaijan"){
        return "Azerbaycan";
      }else if(country=="bolivia"){
        return "bolivya";
      }else if(country=="bosnia-and-herzegovina"){
        return "Bosna Hersek";
      }else if(country=="belgium"){
        return "Belçika";
      }else if(country=="brazil"){
        return "Brezilya";
      }else if(country=="bulgaria"){
        return "Bulgaristan";
      }else if(country=="cameroon"){
        return "Kamerun";
      }else if(country=="canada"){
        return "Kanada";
      }else if(country=="chile"){
        return "Şili";
      }else if(country=="costa-rica"){
        return "Kosta Rika";
      }else if(country=="croatia"){
        return "Hırvatistan";
      }else if(country=="cuba"){
        return "Küba";
      }else if(country=="czechia"){
        return "Çekya";
      }else if(country=="denmark"){
        return "Danimarka";
      }else if(country=="dominican-republic"){
        return "Dominik Cumhuriyeti";
      }else if(country=="ecuador"){
        return "Ekvador";
      }else if(country=="egypt"){
        return "Mısır";
      }else if(country=="estonia"){
        return "Estonya";
      }else if(country=="ethiopia"){
        return "Etiyopya";
      }else if(country=="finland"){
        return "Finlandiya";
      }else if(country=="georgia"){
        return "Gürcistan";
      }else if(country=="greenland"){
        return "Grönland";
      }else if(country=="hungary"){
        return "Macaristan";
      }else if(country=="indonesia"){
        return "Endonesya";
      }else if(country=="bhutan"){
        return "Butan";
      }else if(country=="brazil"){
        return "Brezilya";
      }else if(country=="bangladesh"){
        return "Bangladeş";
      }else if(country=="iran"){
        return "İran";
      }else if(country=="ireland"){
        return "İrlanda";
      }else if(country=="iceland"){
        return "İzlanda";
      }else if(country=="jordan"){
        return "Ürdün";
      }else if(country=="kazakhstan"){
        return "Kazakistan";
      }else if(country=="kyrgyzstan"){
        return "Kırgızistan";
      }else if(country=="kuwait"){
        return "Kuveyt";
      }else if(country=="lebanon"){
        return "Lübnan";
      }else if(country=="brazil"){
        return "Brezilya";
      }else if(country=="latvia"){
        return "Letonya";
      }else if(country=="brazil"){
        return "Brezilya";
      }else if(country=="liberia"){
        return "Liberya";
      }else if(country=="lithuania"){
        return "Litvanya";
      }else if(country=="luxembourg"){
        return "Lüksemburg";
      }else if(country=="malaysia"){
        return "Malezya";
      }else if(country=="malawi"){
        return "Malavi";
      }else if(country=="madagascar"){
        return "Madagaskar";
      }else if(country=="maldives"){
        return "Maldivler";
      }else if(country=="martinique"){
        return "Martinik";
      }else if(country=="mexico"){
        return "Meksika";
      }else if(country=="moldova"){
        return "Moldova";
      }else if(country=="mongolia"){
        return "Moğolistan";
      }else if(country=="montenegro"){
        return "Karadağ";
      }else if(country=="morocco"){
        return "Fas";
      }else if(country=="mozambique"){
        return "Mozambik";
      }else if(country=="namibia"){
        return "Namibya";
      }else if(country=="netherlands"){
        return "Hollanda";
      }else if(country=="new-caledonia"){
        return "Yeni Kaledonya";
      }else if(country=="new-zealand"){
        return "Yeni Zellanda";
      }else if(country=="nicaragua"){
        return "Nikaragua";
      }else if(country=="niger"){
        return "Nijer";
      }else if(country=="nigeria"){
        return "Nijerya";
      }else if(country=="north-macedonia"){
        return "Kuzey Makedonya";
      }else if(country=="norway"){
        return "Norveç";
      }else if(country=="oman"){
        return "Umman";
      }else if(country=="palestine"){
        return "Filistin";
      }else if(country=="papua-new-guinea"){
        return "Papua Yeni Gine";
      }else if(country=="philippines"){
        return "Filipinler";
      }else if(country=="poland"){
        return "Polonya";
      }else if(country=="portugal"){
        return "Portekiz";
      }else if(country=="puerto-rico"){
        return "Porto Riko";
      }else if(country=="romania"){
        return "Romanya";
      }else if(country=="rwanda"){
        return "Ruanda";
      }else if(country=="s-korea"){
        return "Güney Kore";
      }else if(country=="saint-kitts-and-nevis"){
        return "Saint Kitts ve Nevis";
      }else if(country=="saudi-arabia"){
        return "Suudi Arabistan";
      }else if(country=="serbia"){
        return "Sırbistan";
      }else if(country=="seychelles"){
        return "Seyşeller";
      }else if(country=="singapore"){
        return "Singapur";
      }else if(country=="slovakia"){
        return "Slovakya";
      }else if(country=="slovenia"){
        return "Slovenya";
      }else if(country=="somalia"){
        return "Somali";
      }else if(country=="south-afrika"){
        return "Güney Afrika";
      }else if(country=="south-sudan"){
        return "Güney Sudan";
      }else if(country=="spain"){
        return "İspanya";
      }else if(country=="sri-lanka"){
        return "Sri Lanka";
      }else if(country=="Suriname"){
        return "Surinam";
      }else if(country=="sweden"){
        return "İsveç";
      }else if(country=="switzerland"){
        return "İsviçre";
      }else if(country=="syria"){
        return "Suriye";
      }else if(country=="taiwan"){
        return "Tayvan";
      }else if(country=="tajikistan"){
        return "Tacikistan";
      }else if(country=="tanzania"){
        return "Tanzanya";
      }else if(country=="thailand"){
        return "Tayland";
      }else if(country=="timor-leste"){
        return "Doğu Timor";
      }else if(country=="trinidad-and-tobago"){
        return "Trinidad ve Tobago";
      }else if(country=="tunisia"){
        return "Tunus";
      }else if(country=="turks-and-caicos"){
        return "Turks ve Caicos Adaları";
      }else if(country=="uae"){
        return "Birleşik Arap Emirlikleri";
      }else if(country=="ukraine"){
        return "Ukrayna";
      }else if(country=="uzbekistan"){
        return "Özbekistan";
      }else if(country=="vatican-city"){
        return "Vatikan";
      }else if(country=="western-sahara"){
        return "Batı Sahra";
      }else if(country=="zambia"){
        return "Zambiya";
      }else if(country=="zimbabwe"){
        return "Zimbabve";
      }else if(country=="madagascar"){
        return "Madagaskar";
      }

    }else if(language=="EN"){

      if(country=="all"){
        return "World";
      }else if(country=="usa"){
        return "USA";
      }


    }
    return country[0].toUpperCase()+country.substring(1);
  }



}