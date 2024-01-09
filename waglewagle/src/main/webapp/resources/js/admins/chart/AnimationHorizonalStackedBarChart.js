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

  Title: 차트 제목
  Domain: 차트 y축 값
  OuterWidth: 차트 영역 너비(Margin 포함)
  OuterHeight: 차트 영역 높이(Margin 포함)
  Margin: 1이상의 값은 px단위, 1미만은 차트 영역 대비 비율로 처리 됨
  yPadding: 막대 사이의 간격(비율)
  ShapeColors: 막대 색상
  FontColors: 데이터 레이블 색상
  xFormat: x축 도메인 형태(예: "&.2f"(소수 둘째자리까지 표시))
  AnimeDuration: 애니메이션 재생 속도(단위: ms)
  FontFamily: 폰트
*/

function HorizontalStackedBarChart(ChartTag, ChartData, {
  Title, 
  Legend,
  Margin = {top: 50, bottom: 100, left: 100, right: 100},
  OuterWidth = document.querySelector(`.${ChartTag}`).offsetWidth, 
  OuterHeight = document.querySelector(`.${ChartTag}`).offsetHeight, 
  yPadding = 0.4, // amount of y-range to reserve to separate bars
  ShapeColors = d3.schemeTableau10,
  FontColors = Array(ShapeColors.length).fill('#000'),
  xFormat,
  AnimeDuration = 1000,
  FontFamily,
  RateDataLabelOnOff = true
} = {}) {
  /* 에러 */
  if(typeof ChartTag !== 'string'){console.error(`"ChartTag" is not string type.`);return;}
  else if(typeof OuterWidth !== 'number'){console.error(`"OuterWidth" is not number type.`);return;}
  else if(typeof OuterHeight !== 'number'){console.error(`"OuterHeight" is not number type.`);return;}
  else if(typeof Margin !== 'object'){console.error(`"OuterWidth" is not object type. If you don't know Margin's form, see the following example.\nconst Margin = {top: 50, bottom: 100, left: 100, right: 100};`);return;}
    else if(typeof Margin.top !== 'number'){console.error(`"Margin.top" must be number type. `);return;}
    else if(typeof Margin.bottom !== 'number'){console.error(`"Margin.bottom" must be number type.`);return;}
    else if(typeof Margin.left !== 'number'){console.error(`"Margin.left" must be number type.`);return;}
    else if(typeof Margin.right !== 'number'){console.error(`"Margin.right" must be number type.`);return;}
  
  /******************** 기존 차트(<svg> 태그) 전부 삭제(차트 누적 방지) ********************/
  d3.select(`.${ChartTag}`).selectAll("svg").remove();

  /******************** 차트에 필요한 값 ********************/
  const X = d3.map(ChartData, d => d.count);                // x축(count) 값
  const Y = d3.map(ChartData, d => d.domain);               // y축(domain) 값
  const Z = d3.map(ChartData, d => d.legend);               // z축(legend) 값
  const xRange = [Margin.left, OuterWidth - Margin.right];  // x축 범위(px)
  const yRange = [OuterHeight - Margin.bottom, Margin.top]; // y축 범위(px)

  let yDomain = new d3.InternSet(Y);
  let zDomain = new d3.InternSet(Z);

  
  // 각 막대의 index 값(0부터 X.length * Z.length까지)
  // x, z축 도메인 값을 별도로 받은 경우, x, z 값 중에 x, z 도메인 값에 있는 것만 남김
  const I = d3.range(X.length).filter(i => yDomain.has(Y[i]) && zDomain.has(Z[i]));

  // stack 차트를 그리기 위한 데이터 변환 
  const series = d3.stack()
      .keys(zDomain)
      .value(([, I], z) => X[I.get(z)])
      .order(d3.stackOrderNone)
    (d3.rollup(I, ([i]) => i, i => Y[i], i => Z[i]))
    .map(s => s.map(d => Object.assign(d, {
      i: d.data[1].get(s.key),
      rate: ChartData[d.data[1].get(s.key)].rate
    })));

  const seriesDeptOne = series.reduce((a, b) => a.concat(b)).sort((a, b) => a.i - b.i);

  /*
    series =
    [
      [
        [ 0, 12, data: [ '남', InternMap(n) ], i: 0 ], 
          // [info-1] ( 0, 12 ) 각 막대의 bottom 값, top 값(막대가 표현할 데이터 수치 값으로 표시)
          // [info-2] ( '남' ) Domain 값
          // [info-3] ( InternMap(n) ) legend 값 입력 시 해당 legend의 index 값 출력
          // [info-4] ( i: 0 ) 각 막대들을 순서대로 나열했을 때 이 막대의 index
        [ 0, 5, data: [ '여', InternMap(n) ], i: 5 ]
      ],
      [
        [ ... ],
        [ ... ]
      ],
      ...
    ]

    * [info-1] 데이터 추출 방법 : d3.data(series).attr( ([y1, y2]) => ... );
    * [info-4] 데이터 추출 방법 : d3.data(series).attr( {i} => ... );
  */

  /******************** y축 눈금 ********************/
  // y축 범위 지정
  let xDomain = d3.extent(series.flat(2)); // series의 depth2의 값들 중 최소, 최대 값 출력
  let xMax10s = String(xDomain[1]).length - 1;
  if(xDomain[1] <= 10){ // <= 10
    // xDomain[1] = xDomain[1];
  }else if(xDomain[1] < 2*10**xMax10s){
    xDomain[1] = (2*10**(xMax10s-1))*parseInt(xDomain[1] / (2*10**(xMax10s-1))) + (2*10**(xMax10s-1));
  }else if(yDomain[1] < 5*10**xMax10s){
    xDomain[1] = (5*10**(xMax10s-1))*parseInt(xDomain[1] / (5*10**(xMax10s-1))) + (5*10**(xMax10s-1));
  }else{
    xDomain[1] = (10**(xMax10s))*(parseInt(xDomain[1] / (10**xMax10s)) + 1);
  }
  // y축 눈금 데이터 생성
  const tickNum = (d) => {
    let strTickNum = String(d[1]);
    if(d[1] < 10){
      return d[1];                                // < 10
    }else if(d[1] < 2*10**(strTickNum.length-1)){
      return Number(strTickNum.slice(0, 2)) / 2;  // < 2*10**n
    }else if(d[1] < 5*10**(strTickNum.length-1)){
      return Number(strTickNum.slice(0, 2)) / 5;  // < 5*10**n
    }else{
      return Number(strTickNum.slice(0, 2)) / 10; // <= 10*n
    }
  }
  
  /******************** 크기, 축, 형식 데이터 계산 ********************/
  const xScale = d3.scaleLinear(xDomain, xRange);
  const yScale = d3.scaleBand(yDomain, yRange).paddingInner(yPadding).paddingOuter(yPadding);
  const color = d3.scaleOrdinal(zDomain, ShapeColors);
  const xAxis = d3.axisBottom(xScale).ticks(tickNum(xDomain), xFormat);
  const yAxis = d3.axisLeft(yScale).tickSizeOuter(0);
  const tagId = randomString(ChartData.length);

  /******************** 차트 ********************/
  // 차트 영역 지정
  const svg = d3.select(`.${ChartTag}`)
    .append("svg")
    .attr("width", OuterWidth)
    .attr("height", OuterHeight)
    .attr("viewBox", [0, 0, OuterWidth, OuterHeight]);

  // x축, 막대 뒤 눈금선 그리기
  svg.append("g")
      .attr("transform", `translate(0,${OuterHeight - Margin.bottom})`)
    .call(xAxis)
    .call(g => g.select(".domain").remove())
    .call(g => 
      g.selectAll(".tick line")
        .clone()
        .attr("y2", -(OuterHeight - Margin.top - Margin.bottom))
        .attr("stroke-opacity", 0.1)
    )
    .selectAll('text')
      .attr('font-size', '1.2em');

  // y축 그리기
  svg.append("g")
      .attr("transform", `translate(${xScale(0)},0)`)
    .call(yAxis)
    .selectAll('text')
      .attr('font-size', '1.2em');

  // 차트 그리기
  const bar = svg.append("g")
      .attr('class', 'bars')
    .selectAll("g")
    .data(seriesDeptOne)
    .join("g")
      .attr('class', ({i}) => `${tagId[i]}`)
    .append('rect')
      .attr('class', d => xScale(d[1]) - xScale(d[0]) > 35 ? 
        `${tagId[d.i]} label` : `${tagId[d.i]} hidden-label`
      )
      .attr('rx', 5)
      .attr("fill", ({i}) => color(Z[i]))
      .attr('stroke', ({i}) => color(Z[i])) // 테두리
      .attr('stroke-width', '0px')
      .attr("x", ([x1, x2]) => Math.min(xScale(x1), xScale(x2))+1) // x 좌표(좌측끝 ~ 막대 좌하단 모서리 사이 거리)
      .attr("y", ({i}) => yScale(Y[i])) // y 좌표(상단-하단 사이 거리)
      .attr("width", 0) // 너비
      .attr("height", yScale.bandwidth()); // 높이

  /******************** Tooltip(툴팁) ********************/
  // tooltip 함수 생성
  const formatValue = xScale.tickFormat(100, xFormat);
  const title = i => `${Number(formatValue(X[i]))} (${Number(formatValue(ChartData[i].rate))}%)`;

  // tooltip 추가
  if (title) bar.append("title")
    .attr('font-size', '0.9em')
    .attr('text-anchor', 'end')
    .text(({i}) => title(i));
 
  
  /******************** 차트 제목 ********************/
  svg.append('text')
    .attr('x', OuterWidth / 2)
    .attr('y', Margin.top / 2)
    .attr('text-anchor', 'middle')
    .attr('font-family', FontFamily)
    .attr('font-size', '1.5em')
    .attr('font-weight', 'bold')
    .text(Title);

  /******************** 범례 ********************/
  // 범례 사이 간격 계산
  let yLegend = []
  let tw = 0;
  if(OuterWidth < 400){ // 차트 영역이 400미만일 때 범례를 여러줄로 표시
    for(let i = 0; i < Legend.length; i++){
      tw += Legend[i].length * 15 + 30;
      yLegend.push({
        x: i % 3 === 0 ? 0 : yLegend[i-1]['x'] + yLegend[i-1]['w'],
        y: parseInt(i / 3) * 20, 
        w: Legend[i].length * 15 + 30
      });
      if(i % 3 === 2 || i === Legend.length - 1){
        for(let j = parseInt(i/3)*3; j <= i; j++){
          yLegend[j]['tw'] = tw;
        }
        tw = 0;
      }
    }
  }else{ // 차트 영역이 400이상일 때 범례를 한줄로 표시
    for(let i = 0; i < Legend.length; i++){
      // 앞 범례 시작 위치 + 앞 범례 글자길이 *15 + 30
      tw += Legend[i].length * 15 + 30;
      yLegend.push({
        x: i === 0 ? 0 : yLegend[i-1]['x'] + yLegend[i-1]['w'],
        y: 0, 
        w: Legend[i].length * 15 + 30
      });
    }
    for(let i = 0; i < Legend.length; i++){
      yLegend[i]['tw'] = tw;
    }
  }
  /* <yLegend 예시>
    yLegend = [
      {x: 0, y: 0: w: ..., tw: ...},
      {x: 90, y: 0: w: ..., tw: ...},
      {x: 150, y: 0: w: ..., tw: ...},
      ...
    ]
  */

  // 차트 하단에 범례 추가(색)
  svg.append("g")
      .attr('class', 'legends')
      .attr('dx', OuterWidth / 2)
      .attr('dy', OuterHeight - Margin.bottom / 2)
    .selectAll("g")
    .data(yLegend)
    .join('g')
      .attr('class', 'legend')
    .append('circle')
      .attr("cx", d => (OuterWidth - d['tw']) / 2 + d['x'])
      .attr("cy", d => OuterHeight - Margin.bottom / 2 + d['y'])
      .attr("r", 6)
      .style("fill", (d, i) => ShapeColors[i]);
  // 차트 하단에 범례 추가(텍스트)
  svg.selectAll('g.legend')
    .append('text')
      .attr("x", d => (OuterWidth - d['tw']) / 2 + d['x'] + 10)
      .attr("y", d => OuterHeight - Margin.bottom / 2 + 2 + d['y'])
      .style("font-size", "15px")
      .attr('font-family', FontFamily)
      .attr("alignment-baseline","middle")
      .text((d, i) => Legend[i]);

  
  /******************** 데이터 레이블 ********************/  
  // 데이터 레이블 표시
  svg.select('g.bars')
    .selectAll('g')
    .data(seriesDeptOne)
    .append('text')
      .attr("class", d => xScale(d[1]) - xScale(d[0]) >= 35 ? 
        `${tagId[d.i]} label` : `${tagId[d.i]} hidden-label`
      )
      .attr('font-family', FontFamily)
      .attr('opacity', 0)
    .selectAll('tspan')
    .data(d => [
      {x0: d[0], x1: d[1], y: Y[d.i], i: d.i, text: d[1] - d[0]},
      {x0: d[0], x1: d[1], y: Y[d.i], i: d.i, text: d.rate}
    ])
    .join('tspan')
      .attr("class", ({x0, x1, i}) => xScale(x1) - xScale(x0) >= 35 ? 
        `${tagId[i]} label` : `${tagId[i]} hidden-label`
      )
      .attr('text-anchor', 'middle')
      .attr('font-size', (_, i) => i%2 === 0 ? '1em' : '0.9em')
      .attr('font-weight', (_, i) => i%2 === 0 ? 'bold' : '')
      .attr('fill', ({i}) => FontColors[i % Legend.length])
      .attr('x', ({x0, x1}) => (xScale(x0) + xScale(x1)) / 2)
      // ㄴ x축 거리(막대 좌하단 모서리 거리 + 두께/2)
      .attr('y', ({y}) => yScale(y) + (yScale.bandwidth() / 2)) 
      // ㄴ y축 거리((막대 상단 거리 + 하단 거리)/2)
      .attr('dy', (d, i) => i%2 === 0 ? '' : '1em') // 레이블 세로 위치 조정
      .text((d, i) => d.x1-d.x0 !== 0 ? (i%2 === 0 ? `${d.text}` : `(${d.text}%)`) : '');

  
  /******************** 애니메이션 ********************/
  // 차트 도형 애니메이션
  const xMaxs = series.slice(-1).map(d => d.map(dd => dd[1]))[0];
  bar.transition()
    .delay(d => {
      return AnimeDuration / xMaxs[parseInt(d.i / series.length)] * d[0]
    })
    .duration(d => {
      return AnimeDuration / xMaxs[parseInt(d.i / series.length)] * (d[1]-d[0])
    })
    .attr('width', ([x1, x2]) => Math.abs(xScale(x1) - xScale(x2)))
    .ease(d3.easeLinear);

  // 레이블 표시 애니메이션
  svg.selectAll('text.label')
    .transition()
      .delay(AnimeDuration)
      .duration(500)
      .attr('opacity', 1)
      .on('end', function(){
        /********** 숨겨진 레이블 표시 + 차트 도형 강조 **********/
        // 차트 도형에 마우스를 올렸을 때
        svg.select('g.bars')
          .selectAll('rect')
            .attr('cursor', 'pointer')
          .on('mouseover', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
              .transition()
                .duration(200)
                .attr('opacity', 1)
                .attr('font-size', '1.2em');
            svg.select(`rect.${e.target.classList[0]}`)
              .transition()
              .duration(200)
                .attr('stroke-width', e.target.classList.contains('hidden-label') ? '1.5em' : '1em');
            svg.select(`g.${e.target.classList[0]}`).raise();
          })
          .on('mouseleave', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
              .transition()
                .duration(200)
                .attr('opacity', e.target.classList.contains('hidden-label') ? 0 : 1)
                .attr('font-size', '1em');
            svg.select(`rect.${e.target.classList[0]}`)
              .transition()
              .duration(200)
                .attr('stroke-width', `0px`)
          });

        // 데이터 레이블에 마우스를 올렸을 때
        svg.select('g.bars')
          .selectAll('text')
            .attr('cursor', 'pointer')
          .on('mouseover', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
                .transition()
                  .duration(200)
                  .attr('opacity', 1)
                  .attr('font-size', '1.2em');
            svg.select(`rect.${e.target.classList[0]}`)
              .transition()
              .duration(200)
                .attr('stroke-width', e.target.classList.contains('hidden-label') ? '1.5em' : '1em');
            svg.select(`g.${e.target.classList[0]}`).raise();
          })
          .on('mouseleave', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
              .transition()
                .duration(200)
                .attr('opacity', e.target.classList.contains('hidden-label') ? 0 : 1)
                .attr('font-size', '1em');
            svg.select(`rect.${e.target.classList[0]}`)
              .transition()
              .duration(200)
                .attr('stroke-width', `0px`)
          });

        // 데이터 레이블에 마우스를 올렸을 때
        svg.select('g.bars')
          .selectAll('tspan')
            .attr('cursor', 'pointer')
          .on('mouseover', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
                .transition()
                  .duration(200)
                  .attr('opacity', 1)
                  .attr('font-size', '1.2em');
            svg.select(`rect.${e.target.classList[0]}`)
              .transition()
              .duration(200)
                .attr('stroke-width', e.target.classList.contains('hidden-label') ? '1.5em' : '1em');
            svg.select(`g.${e.target.classList[0]}`).raise();
          })
          .on('mouseleave', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
              .transition()
                .duration(200)
                .attr('opacity', e.target.classList.contains('hidden-label') ? 0 : 1)
                .attr('font-size', '1em');
            svg.select(`rect.${e.target.classList[0]}`)
              .transition()
              .duration(200)
                .attr('stroke-width', `0px`)
          });
      })


// 글자 드래그 막기
svg.selectAll('text')
  .classed('noselect', true);
}

export default HorizontalStackedBarChart;