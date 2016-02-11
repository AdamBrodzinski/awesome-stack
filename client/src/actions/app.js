export function showAlert(message) {
  return {
    type: 'SHOW_ALERT',
    payload: {
      message: message,
    }
  };
}
