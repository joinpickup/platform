export default interface Response {
  status: number;
  error?: string;
  payload?: string;
}

export default interface ServerResponse {
  message: string;
}
