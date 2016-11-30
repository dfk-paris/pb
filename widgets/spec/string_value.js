describe("pb-string-value", function() {
  var $ = Zepto;
  var tag = null;

  beforeEach(spec.ensureTagElement);
  // afterEach(function(){spec.unmount(tag)});

  it('should render a value with unit', function() {
    tag = spec.mount('pb-string-value', {label: 'length', value: '12', unit: 'cm'});
    expect($(tag.root).text().trim()).to.equal('length: 12 cm');
  });

  it('should render a value without unit', function() {
    tag = spec.mount('pb-string-value', {label: 'length', value: '13'});
    expect($(tag.root).text().trim()).to.equal('length: 13');
  });

  it('should not render an empty value', function() {
    tag = spec.mount('pb-string-value', {label: 'length'});
    expect($('context').text().trim()).to.equal('');
  });
});