import 'package:halaqat_wasl_main_app/model/complaint_model/complaint_model.dart';
import 'package:halaqat_wasl_main_app/shared/set_up.dart';

class ComplaintRepo {
  static final _supabase = SetupSupabase.sharedSupabase.client;
  //getComplaintByRequestId function -> This function fetches the complaint associated with a particular request.
  static Future<ComplaintModel?> getComplaintByRequestId(
    String requestId,
  ) async {
    final response = await _supabase
        .from('complaint')
        .select()
        .eq('request_id', requestId)
        .maybeSingle();

    if (response == null) return null;

    return ComplaintModelMapper.fromMap(response);
  }

  //insertComplaint Function: -> This function sends a new complaint to the database.
  static Future<void> insertComplaint(ComplaintModel complaint) async {
    await _supabase.from('complaints').insert(complaint.toMap());
  }
}
