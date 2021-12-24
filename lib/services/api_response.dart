class ApiResponse<T> {
  Status status;
  T data;
  String message;
  String errorCode;

  // ApiResponse(this.status, this.data, this.message);
  //  ApiResponse();

  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message, {this.errorCode}) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $message \n Data: $data \n errorCode: $errorCode";
  }
}

enum Status { LOADING, COMPLETED, ERROR }
