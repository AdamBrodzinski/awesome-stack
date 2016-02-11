const initialState = {
  alertMessage: "Hello World",
};

export default function app(state = initialState, action) {
  switch (action.type) {

  case 'FOO':
    return {...state, bar: action.bar};

  default:
    return state;
  }
};
