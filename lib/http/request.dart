import 'dart:convert';
import 'package:http/http.dart' as http;
import 'baseurl.dart';

class Request {
  static Future requestGet(
    url, {
    String baseurl = '',
    Map<String, dynamic>? params,
  }) async {
    late String base;
    base = (baseurl.isEmpty ? baseURL['url1'] : baseurl)!;
    final uri = Uri.parse('$base$url').replace(queryParameters: params);
    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Cookie':
            '_MHYUUID=e7cc6de4-2927-411d-bfd5-11d4b192eee5; DEVICEFP_SEED_ID=6cb457bc032c43a1; DEVICEFP_SEED_TIME=1693807081201; _ga=GA1.1.1251471435.1693807081; cookie_token_v2=v2_5X9WAO4v5vyPe1YL9V3aY4QcDIpIIyOTQIRDViU5jTjUpAilkpAU_Oaxr8s3UQmV2Lp9JpJqAyLv_w_6qUixntSnypsZoGcgRbj2fdOrW5fN18PzdbXQafVyUudY_MI=; account_mid_v2=0uzefx29uo_mhy; account_id_v2=17722507; ltoken_v2=v2_oaOMRUpr-PuehKIoDnGxhwIsyCamXKVetblSK9Oykktip-QLWD1wXSGyOYateV_ftNIJqehyAKk94znNNxbk0YW3S25U41104sX_gsp_zej7jVCtL0QHRR2ZXLX95w==; ltmid_v2=0uzefx29uo_mhy; ltuid_v2=17722507; ltoken=EPmlOnKgDskLqhgUEhFG3zBt37hOdXMloBkhBfAC; ltuid=17722507; cookie_token=NQ9VwtnF40hX3UMMr46MUGuJntx2GCsFoTEiwr9p; account_id=17722507; DEVICEFP=38d7f21e68edb; acw_tc=ac11000117018291999377046efde552de0c44d49d4161220ce79b8aad1d30; _ga_KS4J8TXSHQ=GS1.1.1701830229.24.1.1701830263.0.0.0',
        'Referer': 'https://m.miyoushe.com/',
      },
    );
    return _handleResponse(response);
  }

  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final Map<String, dynamic> data =
          json.decode(utf8.decode(response.bodyBytes));
      return data;
    } else {
      throw Exception('HTTP request failed with status ${response.statusCode}');
    }
  }
}
