
// ライブラリの読み込み
let map;

async function initMap() {
  const { Map } = await google.maps.importLibrary("maps");
  const {AdvancedMarkerElement} = await google.maps.importLibrary("marker")

  // 地図の中心と倍率は公式から変更済
  map = new Map(document.getElementById("map"), {
    center: { lat: 35.681236, lng: 139.767125 },
    zoom: 9,
    mapId: "45d758010836ec98",
    mapTypeControl: true
  });
  try {
    const response = await fetch("/posts.json");
    if (!response.ok) throw new Error('Network response was not ok');

    const { data: { items } } = await response.json();
    if (!Array.isArray(items)) throw new Error("Items is not an array");

    items.forEach( item => {
      const latitude = item.latitude;
      const longitude = item.longitude;
      const title = item.title;
      const name = item.user.name;
      const image = item.image;
      const address = item.address;
      const introduction = item.introduction;

      // マーカー機能
      const marker = new google.maps.marker.AdvancedMarkerElement ({
        position: { lat: latitude, lng: longitude },
        map,
        title: title,
        // 他オプション追加可能
      });
      // 情報ウィンドウ
      const contentString = `
        <div class="information container p-0">
          <div class="mb-3 d-flex align-items-center">
            <p class="lead m-0 font-weight-bold">${name}</p>
          </div>
            <img class="thumbnail" src="${image}" loading="lazy" style="max-width: 200px; height: auto;">
          <div>
            <h1 class="h4 font-weight-bold">${title}</h1>
            <p class="text-muted">${address}</p>
            <p class="lead">${introduction}</p>
          </div>
        </div>
      `;
      const infowindow = new google.maps.InfoWindow({
        content: contentString,
        ariaLabel: title,
      });

      marker.addListener("click", () => {
          infowindow.open({
          anchor: marker,
          map,
        })
      });
    });
  } catch (error) {
    console.error('Error fetching or processing post images:', error);
  }
}

initMap()