import 'package:edgar/services/errors/error_handler.dart';

abstract class DataRepository {
  Future<void> getData() async {
    try {
      // Call the specific implementation method
      await getDataImpl();
    } catch (error) {
      // Use the ErrorHandling class to handle the error
      ErrorHandler.handleDataRetrievalError(error);
      rethrow; // Rethrow the error to propagate it to the calling code
    }
  }

  Future<void> updateData(dynamic params) async {
    try {
      Map<String, dynamic> data = params as Map<String, dynamic>;

      // Call the specific implementation method
      await updateDataImpl(data);
    } catch (error) {
      // Use the ErrorHandling class to handle the error
      ErrorHandler.handleDataUpdateError(error);
      rethrow; // Rethrow the error to propagate it to the calling code
    }
  }

  // Define the specific implementation methods in the subclasses
  Future<void> getDataImpl();
  Future<void> updateDataImpl(Map<String, dynamic> data);
  // Add other methods as needed
}
