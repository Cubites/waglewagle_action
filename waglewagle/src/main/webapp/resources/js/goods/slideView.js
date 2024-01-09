let left = document.querySelector('#left');
let right = document.querySelector('#right');

$('#slideList').click(function (event) {
  if (event.offsetX >= 210) {
    moveSlide(currImg + 1);
  } else {
    moveSlide(currImg - 1);
  }
});

function addClickEvent() {
  left.addEventListener('click', () => {
    moveSlide(currImg - 1);
  });
  right.addEventListener('click', () => {
    moveSlide(currImg + 1);
  });
}
