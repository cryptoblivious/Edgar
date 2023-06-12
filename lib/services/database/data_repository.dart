import 'package:edgar/services/errors/error_handler.dart';

abstract class DataRepository {
  Future<void> fetchData() async {
    try {
      // Call the specific implementation method
      await fetchDataImpl();
    } catch (error) {
      // Use the ErrorHandling class to handle the error
      ErrorHandler.handleDataRetrievalError(error);
      rethrow; // Rethrow the error to propagate it to the calling code
    }
  }

  Future<void> updateData() async {
    try {
      // Call the specific implementation method
      await updateDataImpl();
    } catch (error) {
      // Use the ErrorHandling class to handle the error
      ErrorHandler.handleDataUpdateError(error);
      rethrow; // Rethrow the error to propagate it to the calling code
    }
  }

  // Define the specific implementation methods in the subclasses
  Future<void> fetchDataImpl();
  Future<void> updateDataImpl();
  // Add other methods as needed
}
