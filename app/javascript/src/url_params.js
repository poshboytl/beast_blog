function getUrlParam(key) {
  let target = decodeURI(window.location.href)
  let values = [];
  if (!target) target = decodeURI(location.href);

  key = key.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");

  let pattern = key + '=([^&#]+)';
  let o_reg = new RegExp(pattern, 'ig');
  while (true) {
    let matches = o_reg.exec(target);
    if (matches && matches[1]) {
      values.push(matches[1]);
    } else {
      break;
    }
  }

  if (!values.length) {
    return null;
  } else {
    return values;
  }
}

function removeUrlParam(key) {
  let href = window.location.href
  let r = new RegExp(`(\\?)${key}=[^&]*(?:&|$)|&${key}=[^&]*`, 'gmi')
  window.location.href = href.replace(r, '$1');
}

function insertUrlParam(key, value) {
  key = encodeURI(key);
  value = encodeURI(value);

  let kvp = document.location.search.substr(1).split('&');

  let i = kvp.length;
  let x;
  while (i--) {
    x = kvp[i].split('=');

    if (x[0] === key) {
      x[1] = value;
      kvp[i] = x.join('=');
      break;
    }
  }

  if (i < 0) {
    kvp[kvp.length] = [key, value].join('=');
  }

  //this will reload the page, it's likely better to store this until finished
  document.location.search = kvp.join('&');
}

export { insertUrlParam, removeUrlParam, getUrlParam }
