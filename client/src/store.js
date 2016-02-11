import {registerRedux} from 'simple-react-redux'


export const {dispatch} = registerRedux({
  debug: true,
  renderToElementId: 'root',
  routes: require('./routes'),
  reducers: {
    app: require('./reducers/app'),
  },
});
