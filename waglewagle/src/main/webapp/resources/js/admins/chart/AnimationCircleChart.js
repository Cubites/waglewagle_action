// 랜덤 문자열 생성 함수
const characters = 'abcdefghijklmnopqrstuvwxyz';
const randomString = (num) => {
  const StringGenerator = (number) => {
    let list = [];
    for(let i = 0; i < number; i++){
      let tempnum = Math.random().toString().slice(2,-1).split('').map(d => Number(d));
      list.push(tempnum.map(d => characters[d]).join(''));
    }
    return list;
  }
  for(let i = 0; i < 5; i++){
    let stringList = StringGenerator(num);
    let tempList = new Set(stringList);
    tempList = new Array(...tempList);
    if(stringList.length !== tempList.length){
      stringList = StringGenerator(num);
    }else{
      return stringList;
    }
  }
}

/*
  ChartTag: 차트를 추가할 태그의 class name
  ChartData: 차트에 사용할 데이터
  ----<데이터 구조>----
    [
        {"domain": "분류1", "count": 값1, "rate": 비율1},
        {"domain": "분류2", "count": 값2, "rate": 비율2},
        {"domain": "분류3", "count": 값3, "rate": 비율3},
        {"domain": "분류4", "count": 값4, "rate": 비율4},
        {"domain": "분류5", "count": 값5, "rate": 비율5},
        ...
    ]
  --------------------

  Title: 차트 제목
  Domain: 값 종류
  OuterWidth: 차트 영역 너비(Margin 포함)
  OuterHeight: 차트 영역 높이(Margin 포함)
  InnerRadius: 차트 내경
  OuterRadius: 차트 외경
  LebalRadius: 데이터 레이블 위치(차트 중심으로부터 거리)
  Margin: 1이상의 값은 px단위, 1미만은 차트 영역 대비 비율로 처리 됨
  ShapeColors: 차트 도형 색
  FontColors: 데이터 레이블 글자 색
  stroke: 차트 도형 경계 색
  AnimeDuration: 애니메이션 재생 속도(단위: ms)
  FontFamily: 폰트
*/

function CircleChart(ChartTag, ChartData, {
  Title,
  Domain = d3.map(ChartData, d => d.domain),
  OuterWidth = document.querySelector(`.${ChartTag}`).offsetWidth, 
  OuterHeight = document.querySelector(`.${ChartTag}`).offsetHeight, 
  InnerRadius = 0,
  OuterRadius = Math.min(OuterWidth, OuterHeight) / 3.5,
  LabelRadius = OuterRadius * 1.2,
  Margin = {top: 50, bottom: 100, left: 100, right: 100},
  ShapeColors = d3.schemeTableau10,
  FontColors = Array(ShapeColors.length).fill('#000'),
  stroke = InnerRadius > 0 ? "none" : "white", // stroke separating widths
  padAngle = stroke === "none" ? 1 / OuterRadius : 0, // angular separation between wedges
  AnimeDuration = 1000, // 애니메이션 재생 속도(단위: ms)
  FontFamily
} = {}) {
  // 에러
  if(typeof ChartTag !== 'string'){console.error(`"ChartTag" must be string type.`);return;}
  if(typeof OuterWidth !== 'number'){console.error(`"OuterWidth" must be number type.`);return;}
  if(typeof OuterHeight !== 'number'){console.error(`"OuterHeight" must be number type.`);return;}
  if(typeof Margin !== 'object'){console.error(`"OuterWidth" must be object type. If you don't know Margin's form, see the following example.\nconst Margin = {top: 50, bottom: 100, left: 100, right: 100};`);return;}
    if(typeof Margin.top !== 'number'){console.error(`"Margin.top" must be number type. `);return;}
    if(typeof Margin.bottom !== 'number'){console.error(`"Margin.bottom" must be number type.`);return;}
    if(typeof Margin.left !== 'number'){console.error(`"Margin.left" must be number type.`);return;}
    if(typeof Margin.right !== 'number'){console.error(`"Margin.right" must be number type.`);return;}
  if(typeof ShapeColors !== 'object'){console.error(`"ShapeColors" must be array.`);return;}
  if(typeof FontColors !== 'object'){console.error(`"FontColors" must be array.`);return;}

  // 범례와 읽는 방향을 맞추기 위해 역순으로 변경
  ChartData.reverse();

  /* 기존 차트(<svg> 태그) 전부 삭제(차트가 누적되는 것을 방지) */
  d3.select(`.${ChartTag}`).selectAll("svg").remove();

  /******************** 차트에 필요한 값 ********************/
  const D = d3.map(ChartData, d => d.domain);             // domain 값
  const C = d3.map(ChartData, d => d.count);              // 수치 값
  const I = d3.range(D.length).filter(i => !isNaN(C[i])); // index
  const R = d3.map(ChartData, d => d.rate);               // 비율 값
  const tagId = randomString(ChartData.length);
  let colorId = {};
  for(let i = 0; i < Domain.length; i++){
    colorId[tagId[i]] = ShapeColors[ChartData.length - 1 - i];
  }
  const arcs = d3.pie().padAngle(padAngle).sort(null).value(i => C[i])(I);
  const arc = d3.arc().innerRadius(InnerRadius).outerRadius(OuterRadius).cornerRadius(5);
  const arcLabel = d3.arc().innerRadius(LabelRadius).outerRadius(LabelRadius);

  /******************** 차트 그리기 ********************/
  // 차트 구역 생성, 위치 조정
  const svg = d3.select(`.${ChartTag}`)
    .append("svg")
    .attr("width", OuterWidth)
    .attr("height", OuterHeight)
    .attr("viewBox", [-OuterWidth / 2, -OuterHeight / 2, OuterWidth, OuterHeight]);
    // [주의사항!] viewBox를 옮겼기 때문에 [x,y] = [0, 0] 좌표가 차트 영역의 정중앙이 됨(default: 좌상단)

  // 파이 차트 추가
  svg.append("g")
      .attr("stroke", stroke)
      .attr("stroke-width", 2)
      .attr("stroke-linejoin", 'round')
    .selectAll("path")
    .data(arcs)
    .join("path")
      .attr('class', (d, i) => `${tagId[i]} ${Number(R[d.index]) <= 5 ? 'hidden-label' : ''}`)
      .attr('fill', (d, i) => ShapeColors[ChartData.length - 1 - i])
      .attr('shape-rendering', 'geometricPrecision')
      .transition()
        .delay((d, i) => i === 0 ? 0 : AnimeDuration / C.reduce((a, b) => a + b) * C.slice(0, i).reduce((a, b) => a + b))
        .duration((d, i) => AnimeDuration / C.reduce((a, b) => a + b) * C[i])
        .attrTween('d', function(d) {
            let i = d3.interpolate(d.startAngle+0.1, d.endAngle);
            return t => {
              d.endAngle = i(t);
              return arc(d);
            }
        })
        .ease(d3.easeLinear);

  /******************** Tooltip 추가 ********************/
  // tooltip 데이터 지정
  const title = i => `${C[i]}\n(${R[i]}%)`;

  // tooltip 추가
  svg.selectAll('path')
    .append("title")
      .text(d => title(d.data))
      .attr('stroke', '#091A7A')
      .attr('stroke-width', '10px')
      .attr('opacity', '0.5');
    
  /******************** 차트 제목 ********************/
  if(Title){
    svg.append('text')
      .attr('x', 0)
      .attr('y', -(OuterHeight / 2) + Margin.top / 2)
      .attr('text-anchor', 'middle')
      .attr('font-family', FontFamily)
      .attr('font-size', '1em')
      .attr('font-weight', 'bold')
      .text(Title);
  }

  /******************** 범례 ********************/
  // 범례 사이 간격 계산
  let xLegend = []
  let tw = 0;
  if(OuterWidth < 400){ // 차트 영역 너비가 400미만인 경우, 범례를 여러줄로 표시
    for(let i = 0; i < Domain.length; i++){
      tw += Domain[i].length * 15 + 30;
      xLegend.push({
        x: i % 3 === 0 ? 0 : xLegend[i-1]['x'] + xLegend[i-1]['w'],
        y: parseInt(i / 3) * 20, 
        w: Domain[i].length * 15 + 30
      });
      if(i % 3 === 2 || i === Domain.length - 1){
        for(let j = parseInt(i/3)*3; j <= i; j++){
          xLegend[j]['tw'] = tw;
        }
        tw = 0;
      }
    }
  }else{ // 차트 영역 너비가 400이상인 경우, 범례를 한줄로 표시
    for(let i = 0; i < Domain.length; i++){
      tw += Domain[i].length * 15 + 30;
      xLegend.push({
        x: i === 0 ? 0 : xLegend[i-1]['x'] + xLegend[i-1]['w'],
        y: 0, 
        w: Domain[i].length * 15 + 30
      });
    }
    for(let i = 0; i < Domain.length; i++){
      xLegend[i]['tw'] = tw;
    }
  }
  /* <xLegend 예시>
    xLegend = [
      {x: 0, y: 0: w: ..., tw: ...},
      {x: 90, y: 0: w: ..., tw: ...},
      {x: 150, y: 0: w: ..., tw: ...},
      ...
    ]
  */

  /* 차트 하단에 범례 추가 */
  // 범례 추가(색)
  svg
    .append("g")
      .attr('class', 'legends')
      .attr('dx', OuterWidth / 2)
      .attr('dy', OuterHeight - Margin.bottom / 2)
    .selectAll("g")
    .data(xLegend)
    .join('g')
      .attr('class', 'legend')
    .append('circle')
      .attr("cx", d => -d['tw'] / 2 + d['x'])
      .attr("cy", d => (OuterHeight - Margin.bottom) / 2 + d['y'])
      .attr("r", 6)
      .attr("fill", (_, i) => ShapeColors[i])
  // 범례 추가(텍스트)
  svg.selectAll('g.legend')
    .append('text')
      .attr("x", d => -d['tw'] / 2 + d['x'] + 10)
      .attr("y", d => (OuterHeight - Margin.bottom) / 2 + d['y'])
      .text((_, i) => Domain[i])
      .attr('font-family', FontFamily ? FontFamily : '')
      .attr("font-size", "15px")
      .attr("alignment-baseline","middle");

  /******************** 데이터 레이블 ********************/  
  svg.append("g")
      .attr('class', 'labels')
      .attr("font-family", "sans-serif")
      .attr("font-size", '1em')
      .attr("text-anchor", "middle")
    .selectAll("text")
    .data(arcs)
    .join("text")
      .attr('class', (d, i) => `${tagId[i]} ${Number(R[d.index]) <= 5 ? 'hidden-label' : 'label'}`)
      .attr("transform", d => `translate(${arcLabel.centroid(d)})`)
      .attr('font-family', FontFamily ? FontFamily : '')
      .attr('opacity', 0)
    .selectAll("tspan")
    // 수치, 비율 분리("134\n(12%)" ==> "134", "(12%)")
    .data((d, i) => [C[i], `(${R[i]}%)`])
    .join("tspan") // 도메인 수 x2 만큼 순회(수치, 비율, 수치, 비율, ...)
      .attr("x", 0)
      .attr("y", (_, i) => `${i * 1.2}em`)
      .attr("font-size", (_, i) => i ? "0.7em" : "1em")
      .attr("font-weight", (_, i) => i ? null : "bold")
      .text(d => d)
      
    /******************** 애니메이션 ********************/
    // 첫 로딩 시, 표시되는 애니메이션
    svg.selectAll('text.label')
      .transition()
        .delay(AnimeDuration)
        .duration(500)
        .attr('opacity', 1)
        .on('end', () => {
          /********** 숨겨진 레이블 표시 + 차트 도형 강조 **********/
          svg.selectAll('path')
              .attr('cursor', 'pointer')
            .on('mouseover', (e) => {
              svg.select(`text.${e.target.classList[0]}`)
                .transition()
                  .duration(200)
                  .attr('opacity', 1)
                  .attr('font-size', '1.2em');
              svg.select(`path.${e.target.classList[0]}`)
                .raise()
                .transition()
                  .duration(200)
                  .attr("stroke", colorId[e.target.classList[0]])
                  .attr("stroke-width", 5)
                  .attr("stroke-linejoin", 'round');
            })
            .on('mouseleave', (e) => {
              svg.select(`text.${e.target.classList[0]}`)
                .transition()
                  .duration(200)
                  .attr('opacity', e.target.classList.contains('hidden-label') ? 0 : 1)
                  .attr('font-size', '1em');
              svg.select(`path.${e.target.classList[0]}`)
                .transition()
                  .duration(200)
                  .attr("stroke", stroke)
                  .attr("stroke-width", 2)
                  .attr("stroke-linejoin", 'round')
            });
        })  
  
  // 글자 드래그 막기
  svg.selectAll('text')
    .classed('noselect', true);
}

export default CircleChart;