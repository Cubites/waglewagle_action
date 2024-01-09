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
  Domain: 차트 x축 값
  OuterWidth: 차트 영역 너비(Margin 포함)
  OuterHeight: 차트 영역 높이(Margin 포함)
  Margin: 1이상의 값은 px단위, 1미만은 차트 영역 대비 비율로 처리 됨
  xPadding: 막대 사이의 간격(비율)
  ShapeColors: 막대 색상
  FontColors: 데이터 레이블 색상
  AnimeDuration: 애니메이션 재생 속도(단위: ms)
  FontFamily: 폰트
*/

function BarChart(ChartTag, ChartData, {
  Title,
  Domain = d3.map(ChartData, d => d.domain),
  OuterWidth = document.querySelector(`.${ChartTag}`).offsetWidth, 
  OuterHeight = document.querySelector(`.${ChartTag}`).offsetHeight, 
  Margin = {top: 50, bottom: 100, left: 100, right: 100},
  xPadding = 0.3,
  ShapeColors = d3.schemeTableau10,
  FontColors = Array(ShapeColors.length).fill('#000'),
  AnimeDuration = 1000,
  FontFamily
} = {}) {
  /* 에러 */
  if(typeof ChartTag !== 'string'){console.error(`"ChartTag" must be string type.`);return;}
  if(typeof OuterWidth !== 'number'){console.error(`"OuterWidth" must be number type.`);return;}
  if(typeof OuterHeight !== 'number'){console.error(`"OuterHeight" must be number type.`);return;}
  if(typeof Margin !== 'object'){console.error(`"OuterWidth" must be object type. If you don't know Margin's form, see the following example.\nconst Margin = {top: 50, bottom: 100, left: 100, right: 100};`);return;}
    if(typeof Margin.top !== 'number'){console.error(`"Margin.top" must be number type. `);return;}
    if(typeof Margin.bottom !== 'number'){console.error(`"Margin.bottom" must be number type.`);return;}
    if(typeof Margin.left !== 'number'){console.error(`"Margin.left" must be number type.`);return;}
    if(typeof Margin.right !== 'number'){console.error(`"Margin.right" must be number type.`);return;}
  if(typeof xPadding !== 'number' || xPadding > 1 || xPadding < 0){console.error(`"xPadding" must be number between 0 to 1.`);return;}
  if(typeof ShapeColors !== 'object'){console.error(`"ShapeColors" must be array.`);return;}
  if(typeof FontColors !== 'object'){console.error(`"FontColors" must be array.`);return;}

  /******************** 기존 차트(<svg> 태그) 전부 삭제(차트 누적 방지) ********************/
  d3.select(`.${ChartTag}`).selectAll("svg").remove();

  /******************** 차트에 필요한 값 ********************/
  const X = d3.map(ChartData, d => d.domain);               // x축 domain 값
  const Y = d3.map(ChartData, d => d.count);                // y축 값
  const xRange = [Margin.left, OuterWidth - Margin.right];  // x축 범위(px)
  const yRange = [OuterHeight - Margin.bottom, Margin.top]; // y축 범위(px)

  /******************** y축 눈금 ********************/
  // y축 최대값 지정
  let yDomain = [0, Math.round(Math.max(...Y) / 95 * 100)];
  let yMaxLen = String(yDomain[1]).length;
  if(yDomain[1] < 10){                        // 간격 <= 10
    yDomain[1] += 1;
  } else if(yDomain[1] < (10**yMaxLen / 5)){   // 간격 = 2xx...
    yDomain[1] = (10**yMaxLen / 50)*(parseInt(yDomain[1] / (10**yMaxLen / 50)) + 1);
  } else if(yDomain[1] < (10**yMaxLen / 2)){   // 간격 = 5xx...
    yDomain[1] = (10**yMaxLen / 20)*(parseInt(yDomain[1] / (10**yMaxLen / 20)) + 1); 
  } else{                                      // 간격 = 10xx...
    yDomain[1] = (10**yMaxLen / 10)*(parseInt(yDomain[1] / (10**yMaxLen / 10)) + 1); 
  }

  // y축 눈금 생성
  const tickNum = (d) => {
    let strTickNum = String(d).length;
    if(d < 10){
      return d;                         // < 10
    }else if(d < (10**strTickNum / 5)){
      return d / (10**strTickNum / 50); // < 2*10**n
    }else if(d < (10**strTickNum / 2)){ 
      return d / (10**strTickNum / 20); // < 5*10**n
    }else{
      return d / (10**strTickNum / 10); // <= 10*n
    }
  }
  
    /******************** 크기, 축, 형식 데이터 계산 ********************/
  const xScale = d3.scaleBand(X, xRange).paddingInner(xPadding).paddingOuter(xPadding);
  const yScale = d3.scaleLinear(yDomain, yRange);
  const xAxis = d3.axisBottom(xScale).tickSizeOuter(0);
  const yAxis = d3.axisLeft(yScale).ticks(tickNum(yDomain[1]));
  const tagId = randomString(ChartData.length);
    
  /******************** 차트 ********************/
  // 차트 영역 지정
  const svg = d3.select(`.${ChartTag}`)
    .append('svg')
    .attr('width', OuterWidth)
    .attr('height', OuterHeight)

  // y축, 막대 뒤 눈금선 그리기
  svg.append('g')
    .attr('transform', `translate(${Margin.left}, 0)`)
    .call(yAxis)
    .call(g => g.select(".domain").remove())
    .call(g => 
      g.selectAll(".tick line")
        .clone()
        .attr("x2", OuterWidth - Margin.left - Margin.right)
        .attr("stroke-opacity", 0.1)
    )
    .selectAll('text')
      .attr('font-size', '1.5em');

  // x축 추가
  svg.append("g")
      .attr("transform", `translate(0, ${yScale(0)})`)
    .call(xAxis)
    .selectAll('text')
      .attr('font-size', '1.5em')

  // 차트 그리기
  const bars = svg.append('g')
    .selectAll('rect')
    .data(ChartData)
    .join("rect")
      .attr('class', (d, i) => tagId[i])
      .attr('x', d => xScale(d.domain))
      .attr('y', yRange[0])
      .attr('rx', 5)
      .attr('ry', 5)
      .attr('height', 0)
      .attr('width', xScale.bandwidth)
      .attr('fill', (d, i) => ShapeColors[i])
      .attr('stroke', (d, i) => ShapeColors[i])
      .attr('stroke-width', '0px');

  /******************** Tooltip(툴팁) ********************/
  const formatValue = yScale.tickFormat(100);
  const title = i => `${Number(formatValue(Y[i]))}\n(${Number(formatValue(ChartData[i].rate))}%)`;
  bars.append("title")
    .attr('font-size', '0.9em')
    .attr('text-anchor', 'end')
    .text((d, i) => title(i));

  /******************** 차트 제목 ********************/
  svg.append('text')
    .attr('x', OuterWidth / 2)
    .attr('y', Margin.top / 2)
    .attr('text-anchor', 'middle')
    .attr('font-family', FontFamily)
    .attr('font-size', '1em')
    .attr('font-weight', 'bold')
    .text(Title);
  
  /******************** 범례 ********************/
  // 범례 사이 간격 계산
  let xLegend = []
  let tw = 0;
  if(OuterWidth < 500){ // 차트 영역이 500px미만일 때 범례를 여러줄로 표시
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
  }else{ // 차트 영역이 500px이상일 때 범례를 한줄로 표시
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

  // 차트 하단에 범례 추가(색)
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
      .attr("cx", d => (OuterWidth - d['tw']) / 2 + d['x'])
      .attr("cy", d => OuterHeight - Margin.bottom / 2 + d['y'])
      .attr("r", 6)
      .style("fill", (d, i) => ShapeColors[i]);
  // 차트 하단에 범례 추가(텍스트)
  svg.selectAll('g.legend')
    .append('text')
      .attr("x", d => (OuterWidth - d['tw']) / 2 + d['x'] + 10)
      .attr("y", d => OuterHeight - Margin.bottom / 2 + 2 + d['y'])
      .text((d, i) => Domain[i])
      .style("font-size", "15px")
      .attr('font-family', FontFamily)
      .attr("alignment-baseline","middle");

  
  /******************** 데이터 레이블 ********************/  
  // 데이터 레이블 표시 
  svg.append("g")
      .attr('class', 'labels')
      .attr("font-family", "sans-serif")
    .selectAll("text")
    .data(ChartData)
    .join("text")
      .attr("class", (d, i) => `${tagId[i]} label`)
      .attr('opacity', 0)
    .selectAll("tspan")
    .data(d => {
      if(d.rate){ // 비율값이 있으면 출력 없으면 출력 안함
        return [
          {domain: d.domain, count: d.count, text: d.count}, 
          {domain: d.domain, count: d.count, text: d.rate}
        ];
      } else {
        return [{domain: d.domain, count: d.count, text: d.count}];
      }
    })
    .join("tspan")
      .attr('x', d => xScale(d.domain) + xScale.bandwidth() / 2)
      .attr('y', d => yScale(d.count) - 5)
      .attr('dy', (d, i) => i === 0 ? '-1em' : '-0.3em') // 레이블 세로 위치 조정
      .attr('font-family', FontFamily)
      .attr('font-size', (_, i) => i === 0 ? '1em' : '0.7em')
      .attr('font-weight', (_, i) => i === 0 ? 'bold' : '')
      .attr('text-anchor', 'middle')
      .text((d, i) => d.count !== 0 ? (i === 0 ? `${d.text}` : `(${d.text}%)`) : '');

  svg.selectAll('g.labels')
    .selectAll('text')
    .insert('rect', 'text')

  /******************** 애니메이션 ********************/
  // 차트 도형 애니메이션
  bars.transition()
    .duration(AnimeDuration)
    .attr('height', d => yRange[0] - yScale(d.count))
    .attr('transform', d => `translate(0, -${yRange[0] - yScale(d.count)})`)
    .ease(d3.easeExpOut);
      
  // 레이블 표시 애니메이션
  svg
    .selectAll('text.label')
    .transition()
      .delay(AnimeDuration)
      .duration(500)
      .attr('opacity', 1)
      .on('end', function(d, i){
        /********** 숨겨진 레이블 표시 + 차트 도형 강조 **********/
        svg.selectAll('rect')
            .attr('cursor', 'pointer')
          .on('mouseover', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
              .transition()
                .duration(200)
                .attr('font-size', '1.2em');
            svg.select(`rect.${e.target.classList[0]}`)
              .transition()
              .duration(200)
                .attr('stroke-width', `10px`)
          })
          .on('mouseleave', (e) => {
            svg.select(`text.${e.target.classList[0]}`)
              .transition()
                .duration(200)
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

export default BarChart;