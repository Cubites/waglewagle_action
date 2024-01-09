let left = document.querySelector('#imgleft > img');
let right = document.querySelector('#imgRight > img');
function addClickEvent() {
  left.addEventListener('click', () => {
    moveSlide(currImg - 1);
  });
  right.addEventListener('click', () => {
    moveSlide(currImg + 1);
  });
}
