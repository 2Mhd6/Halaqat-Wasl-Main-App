import 'dart:developer';

import 'package:halaqat_wasl_main_app/model/hospital_model/hospital_model.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HospitalRepo {

  static final SupabaseClient _hospitalSupabase = SetupSupabase.sharedSupabase.client;

  static Future<List<HospitalModel>> getAllHospital() async{
    try{
      final allHospital = await _hospitalSupabase.from('hospital').select();
      log('$allHospital');
      return allHospital.map((hospital) => HospitalModelMapper.fromMap(hospital)).toList();
    }catch(error){
      throw error.toString();
    }
  }
}